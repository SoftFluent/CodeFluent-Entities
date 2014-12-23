using System;
using System.CodeDom;
using System.CodeDom.Compiler;
using System.Collections;
using System.IO;
using CodeFluent.Model;
using CodeFluent.Producers.CodeDom;
using CodeFluent.Runtime;
using CodeFluent.Runtime.Utilities;

namespace SoftFluent.AspNetIdentity
{
    public abstract class SimpleCodeUnitProducer
    {
        private string _ns;
        private string _targetName;
        private string _resourceManagerTypeName;

        public string EnvironmentVersion
        {
            get
            {
                if ((CodeDomProducer.ProductionFlags & ProductionFlags.RemoveDates) == ProductionFlags.RemoveDates)
                    return string.Empty;
                else
                    return Environment.Version.ToString();
            }
        }

        public abstract bool IsWebType { get; }

        public CodeDomBaseProducer CodeDomProducer { get; private set; }

        public virtual string ResourceManagerTypeName
        {
            get
            {
                return _resourceManagerTypeName ?? CodeDomLocal.GetManagerTypeName(CodeDomProducer);
            }
            set
            {
                _resourceManagerTypeName = value;
            }
        }

        protected abstract string DefaultNamespace { get; }

        public virtual string Namespace
        {
            get
            {
                return _ns ?? ConvertUtilities.Nullify(XmlUtilities.GetAttribute(CodeDomProducer.Element, ConvertUtilities.Camel(TargetName) + "Namespace", DefaultNamespace), true);
            }
            set
            {
                _ns = value;
            }
        }

        protected abstract string DefaultTypeName { get; }

        public virtual string TypeName
        {
            get
            {
                return ConvertUtilities.Nullify(XmlUtilities.GetAttribute(CodeDomProducer.Element, ConvertUtilities.Camel(TargetName) + "TypeName", DefaultTypeName), true);
            }
        }

        protected virtual string TargetName
        {
            get
            {
                if (_targetName == null)
                {
                    _targetName = GetType().Name;
                    if (_targetName.EndsWith("Producer"))
                        _targetName = _targetName.Substring(0, _targetName.Length - 8);
                }
                return _targetName;
            }
        }

        public abstract string TargetPath { get; }

        protected virtual Node ProductionNode
        {
            get
            {
                return null;
            }
        }

        protected SimpleCodeUnitProducer(CodeDomBaseProducer codeDomProducer)
        {
            if (codeDomProducer == null)
                throw new ArgumentNullException("codeDomProducer");
            CodeDomProducer = codeDomProducer;
        }

        protected abstract bool RaiseProducing(IDictionary dictionary);

        protected abstract void RaiseProduced();

        protected virtual string FinalizeTargetPath()
        {
            if (TargetPath == null)
                throw new CodeFluentCodeDomProducerException(string.Format("invalidProducerImplementation {0}", GetType().FullName));

            return !TargetPath.EndsWith(CodeDomProducer.FileExtension) ? TargetPath + CodeDomProducer.FileExtension : TargetPath;
        }

        public abstract CodeCompileUnit CreateCodeCompileUnit();

        public virtual string Produce(bool addFile)
        {
            Hashtable dic = new Hashtable();
            dic.Add("Project", CodeDomProducer.Project);
            dic.Add("Producer", CodeDomProducer);
            dic.Add("TemplateProducer", this);
            string productionTargetPath = CodeDomProducer.GetProductionTargetPath(ProductionNode, FinalizeTargetPath(), IsWebType, false);
            string tempPath = (CodeDomProducer.TargetProductionOptions & TargetProductionOptions.CreateTempFile) == TargetProductionOptions.None ? null : productionTargetPath + ".tmp";
            dic.Add("TargetPath", productionTargetPath);
            dic.Add("TempTargetPath", tempPath);
            if (!RaiseProducing(dic))
                return null;

            try
            {
                if (tempPath == null)
                {
                    BaseProducer.CreateFileDirectory(productionTargetPath, CodeDomProducer);
                    BaseProducer.PathUnprotect(productionTargetPath, CodeDomProducer);
                }
                else
                    BaseProducer.CreateFileDirectory(tempPath, CodeDomProducer);

                bool append = false;
                if (File.Exists(productionTargetPath) && CodeDomProducer.IsGeneratedFile(productionTargetPath))
                {
                    if (tempPath != null)
                        IOUtilities.PathOverwrite(productionTargetPath, tempPath, true);
                    append = true;
                }
                string target = tempPath ?? productionTargetPath;
                try
                {
                    var unit = CreateCodeCompileUnit();
                    if (unit == null)
                        return null;

                    IOUtilities.WrapSharingViolations(() =>
                    {
                        using (StreamWriter streamWriter = new StreamWriter(target, append, CodeDomProducer.OutputEncoding))
                        {
                            IndentedTextWriter indentedTextWriter = ((CodeDomProducer.ProductionFlags & ProductionFlags.RemoveDates) != ProductionFlags.RemoveDates ? new IndentedTextWriter(streamWriter) : new NoDiffIndentedTextWriter(streamWriter));
                            CodeDomProducer.CodeDomProvider.GenerateCodeFromCompileUnit(unit, indentedTextWriter, CodeDomProducer.CodeGeneratorOptions);
                        }
                    });
                }
                catch (Exception ex)
                {
                    CodeFluentRuntimeException violationException = IOUtilities.GetSharingViolationException(target, ex);
                    if (violationException != null)
                        throw violationException;

                    throw;
                }

                if (File.Exists(tempPath ?? productionTargetPath))
                {
                    CodeDomProducer.RaiseProduction(this, ProductionEventArgs.CreateFileWriteEvent(productionTargetPath, GetType().FullName));
                    if (tempPath != null)
                    {
                        BaseProducer.FileOverwrite(tempPath, productionTargetPath, CodeDomProducer, false);
                    }

                    CodeDomProducer.AddToGeneratedFiles(productionTargetPath);
                }
            }
            finally
            {
                if (tempPath != null && File.Exists(tempPath))
                {
                    File.Delete(tempPath);
                }
            }

            RaiseProduced();
            if (addFile)
            {
                CodeDomProducer.AddFileName(productionTargetPath);
            }

            return productionTargetPath;
        }
    }
}