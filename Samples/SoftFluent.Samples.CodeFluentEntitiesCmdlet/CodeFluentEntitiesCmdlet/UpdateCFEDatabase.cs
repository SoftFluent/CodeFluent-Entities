using CodeFluent.Runtime;
using CodeFluent.Runtime.Database.Management.SqlServer;
using System;
using System.IO;
using System.Management.Automation;

namespace CodeFluentEntitiesCmdlet
{
    [Cmdlet(VerbsData.Update, "CFEDatabase", SupportsShouldProcess = true, ConfirmImpact = ConfirmImpact.High)]
    public class UpdateCFEDatabase : Cmdlet
    {
        private FileInfo _pivotFileInfo;

        [Parameter(Mandatory = true)]
        public string ConnectionString { get; set; }

        [Parameter(Mandatory = true)]
        public string PivotFilePath { get; set; }

        private FileInfo PivotFileInfo
        {
            get
            {
                if (_pivotFileInfo == null)
                    _pivotFileInfo = new FileInfo(PivotFilePath);
                return _pivotFileInfo;
            }
        }

        protected override void ProcessRecord()
        {
            if (!PivotFileInfo.Exists)
            {
                WriteObject("Error: The PivotFilePath parameter does not lead to an existing file path!");
                return;
            }

            DumpParameters();

            UpdateDatabase();
        }

        private void UpdateDatabase()
        {
            try
            {
                PivotRunner runner = new PivotRunner(PivotFilePath);

                runner.ConnectionString = ConnectionString;

                if (!runner.Database.Exists)
                {
                    WriteObject("Error: The ConnectionString parameter does not lead to an existing database!");
                    return;
                }

                if (ShouldProcess(runner.Database.Name, "Update"))
                {
                    runner.Logger = new CmdletLogger(this);
                    runner.Run();
                }
            }
            catch (Exception e)
            {
                WriteObject("An exception has been thrown during the update process: " + e.Message);
            }
        }

        private void DumpParameters()
        {
            WriteObject("Sent parameters:");

            WriteObject(string.Format("\t[Connection string] {0}", ConnectionString));

            WriteObject(string.Format("\t[Pivot filename] {0}", PivotFileInfo.Name));
        }
    }

    public class CmdletLogger : IServiceHost
    {
        private Cmdlet _cmdLet;

        public CmdletLogger(Cmdlet cmdlet)
        { _cmdLet = cmdlet; }

        public void Log(object value)
        {
            _cmdLet.WriteObject(value);
        }
    }
}
