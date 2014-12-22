using System;
using System.CodeDom;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using CodeFluent.Model;
using CodeFluent.Model.Code;
using CodeFluent.Producers.CodeDom;
using CodeFluent.Runtime.Utilities;

namespace SoftFluent.AspNetIdentity
{
    public abstract class AspNetIdentityCodeUnitProducer : SimpleCodeUnitProducer
    {
        private readonly AspNetIdentityProducer _identityProducer;

        protected AspNetIdentityCodeUnitProducer(AspNetIdentityProducer identityProducer, CodeDomBaseProducer codeDomBaseProducer) : base(codeDomBaseProducer)
        {
            if (identityProducer == null) throw new ArgumentNullException("identityProducer");
            if (codeDomBaseProducer == null) throw new ArgumentNullException("codeDomBaseProducer");

            _identityProducer = identityProducer;
        }

        public AspNetIdentityProducer IdentityProducer
        {
            get { return _identityProducer; }
        }

        public override bool IsWebType
        {
            get { return true; }
        }

        protected override string DefaultNamespace
        {
            get { return CodeDomProducer.Project.DefaultNamespace + CodeDomProducer.WebNamespaceSuffix + ".Security"; }
        }

        protected override bool RaiseProducing(IDictionary dictionary)
        {
            return true;
        }

        protected override void RaiseProduced()
        {
        }

        public override string TargetPath
        {
            get
            {
                string path = ConvertUtilities.Nullify(XmlUtilities.GetAttribute(CodeDomProducer.Element, ConvertUtilities.Camel(TargetName) + "TargetPath", (string)null), true);
                if (path == null)
                    return BaseType.GetFilePath(CodeDomProducer.TargetBaseNamespace, TypeName, Namespace, CodeDomProducer.FullTargetDirectory, null);

                return CodeDomProducer.GetFullRelativeDirectoryPath(path);
            }
        }

        protected CodeMethodInvokeExpression CreateMethodInvokeExpression(Method method, params CodeExpression[] parameters)
        {
            if (method == null) throw new ArgumentNullException("method");

            switch (method.MethodType)
            {
                case CodeFluent.Model.Code.MethodType.SetLoad:
                case CodeFluent.Model.Code.MethodType.SetBodySnippet:
                case CodeFluent.Model.Code.MethodType.SetSnippet:
                case CodeFluent.Model.Code.MethodType.Count:
                case CodeFluent.Model.Code.MethodType.Delete:
                    return new CodeMethodInvokeExpression(new CodeTypeReferenceExpression(method.Entity.Set.ClrFullTypeName), method.Name, parameters);

                default:
                    return new CodeMethodInvokeExpression(new CodeTypeReferenceExpression(method.Entity.ClrFullTypeName), method.Name, parameters);
            }
        }

        protected CodeMethodInvokeExpression CreateMethodInvokeExpression(Entity entity, string methodName, params CodeExpression[] parameters)
        {
            if (entity == null) throw new ArgumentNullException("entity");
            if (methodName == null) throw new ArgumentNullException("methodName");

            return new CodeMethodInvokeExpression(new CodeTypeReferenceExpression(entity.ClrFullTypeName), methodName, parameters);
        }

        protected CodeMethodInvokeExpression CreateMethodInvokeExpression(Set set, string methodName, params CodeExpression[] parameters)
        {
            if (set == null) throw new ArgumentNullException("set");
            if (methodName == null) throw new ArgumentNullException("methodName");

            return new CodeMethodInvokeExpression(new CodeTypeReferenceExpression(set.ClrFullTypeName), methodName, parameters);
        }

        protected CodeExpression CreateStringFormatExpression(CodeExpression expression)
        {
            if (expression == null) throw new ArgumentNullException("expression");

            return new CodeMethodInvokeExpression(new CodeTypeReferenceExpression(typeof(string)), "Format", new CodePrimitiveExpression("\"{0}\""), expression);
        }

        protected CodeStatement CreateThrowInvalidOperationException()
        {
            return new CodeThrowExceptionStatement(new CodeObjectCreateExpression(typeof(InvalidOperationException)));
        }

        protected CodeExpression CreateHasValueExpression(CodeExpression nullable)
        {
            if (nullable == null) throw new ArgumentNullException("nullable");

            return new CodePropertyReferenceExpression(nullable, "HasValue");
            //return new CodeBinaryOperatorExpression(new CodePropertyReferenceExpression(nullable, "HasValue"), CodeBinaryOperatorType.ValueEquality, new CodePrimitiveExpression(true));
        }

        protected CodeStatement CreateEmptyTaskResult()
        {
            return new CodeMethodReturnStatement(new CodeMethodInvokeExpression(
                new CodeTypeReferenceExpression(typeof(Task)), "FromResult", new CodePrimitiveExpression(0)));
        }

        protected CodeStatement CreateTaskResult(CodeExpression expression)
        {
            return new CodeMethodReturnStatement(new CodeMethodInvokeExpression(
                new CodeTypeReferenceExpression(typeof(Task)), "FromResult", expression));
        }

        protected void ImplementIDisposableInterface(CodeTypeDeclaration type)
        {
            type.BaseTypes.Add(new CodeTypeReference(typeof(IDisposable)));

            CodeMemberField disposedField = new CodeMemberField(typeof(bool), "_disposed");
            disposedField.InitExpression = new CodePrimitiveExpression(false);
            type.Members.Add(disposedField);

            CodeMemberMethod disposeMethod = new CodeMemberMethod();
            disposeMethod.Name = "Dispose";
            disposeMethod.Attributes = MemberAttributes.Public;
            disposeMethod.ImplementationTypes.Add(new CodeTypeReference(typeof(IDisposable)));
            disposeMethod.Statements.Add(
                new CodeAssignStatement(
                    new CodeFieldReferenceExpression(new CodeThisReferenceExpression(), disposedField.Name),
                    new CodePrimitiveExpression(true)));
            type.Members.Add(disposeMethod);

            CodeMemberMethod throwIfDisposedMethod = new CodeMemberMethod();
            throwIfDisposedMethod.Name = "ThrowIfDisposed";
            throwIfDisposedMethod.Attributes = MemberAttributes.Family;

            var condition = new CodeConditionStatement();
            condition.Condition = new CodeBinaryOperatorExpression(
                new CodeFieldReferenceExpression(new CodeThisReferenceExpression(), disposedField.Name),
                CodeBinaryOperatorType.ValueEquality,
                new CodePrimitiveExpression(true));
            condition.TrueStatements.Add(
                new CodeThrowExceptionStatement(
                    new CodeObjectCreateExpression(
                        typeof(ObjectDisposedException),
                        new CodePropertyReferenceExpression(
                            new CodeMethodInvokeExpression(new CodeThisReferenceExpression(), "GetType"),
                            "Name"))));

            throwIfDisposedMethod.Statements.Add(condition);
            type.Members.Add(throwIfDisposedMethod);
        }

        protected void FinalizeMethods(CodeTypeDeclaration type)
        {
            // Create overloads with CancellationToken when possible
            foreach (CodeMemberMethod method in type.Members.OfType<CodeMemberMethod>().ToList())
            {
                if (method.ReturnType == null)
                    continue;

                if (method.ReturnType.BaseType != typeof(Task).FullName && !method.ReturnType.BaseType.StartsWith(typeof(Task).FullName + "`"))
                    continue;

                if (method.Parameters.Cast<CodeParameterDeclarationExpression>().Any(p => p.Type.BaseType == typeof(CancellationToken).FullName))
                    continue;

                CodeMemberMethod newMethod = new CodeMemberMethod();
                newMethod.Name = method.Name;
                newMethod.Attributes = method.Attributes;
                newMethod.ReturnType = method.ReturnType;

                foreach (CodeParameterDeclarationExpression parameter in method.Parameters)
                {
                    newMethod.Parameters.Add(parameter);
                }

                newMethod.Parameters.Add(new CodeParameterDeclarationExpression(typeof(CancellationToken), "cancellationToken"));

                newMethod.Statements.Add(new CodeMethodInvokeExpression(new CodeArgumentReferenceExpression("cancellationToken"), "ThrowIfCancellationRequested"));
                newMethod.Statements.Add(new CodeMethodInvokeExpression(new CodeThisReferenceExpression(), "ThrowIfDisposed"));
                foreach (CodeStatement statement in method.Statements)
                {
                    newMethod.Statements.Add(statement);
                }

                // replace existing method
                method.Statements.Clear();
                List<CodeExpression> parameters = new List<CodeExpression>();
                foreach (CodeParameterDeclarationExpression parameter in method.Parameters)
                {
                    parameters.Add(new CodeArgumentReferenceExpression(parameter.Name));
                }

                parameters.Add(new CodePropertyReferenceExpression(new CodeTypeReferenceExpression(typeof(CancellationToken)), "None"));

                method.Statements.Add(new CodeMethodReturnStatement(new CodeMethodInvokeExpression(new CodeThisReferenceExpression(), newMethod.Name, parameters.ToArray())));

                type.Members.Insert(type.Members.IndexOf(method) + 1, newMethod);
            }
        }
    }
}