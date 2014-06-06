using CodeFluent.Runtime.TemplateEngine;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;

namespace SoftFluent.Samples.CustomTemplateEngine
{
    class Program
    {
        static void Main(string[] args)
        {
            Template template = new Template();
            string templateText =
@"<% var now = new Date(); %>
Hello <%= Name %>!
It's <%= now.toDateString() %>";
            template.LoadText(templateText, "Name");
            string templateResult = template.Run(new Dictionary<string, object> { { "Name", "Jone Doe" } });
            Console.WriteLine(templateResult);

            // Custom template
            Template customTemplate = new CustomTemplate();
            customTemplate.LoadText(
@"Hello {{Name}}!
It's {{Date:yyyy/MM/dd}}
My name is {{CurrentUser}}", "Name", "Date");

            string sourceCode = customTemplate.Parsed.SourceCode;
            string customTemplateResult = customTemplate.Run(new Dictionary<string, object> { { "Name", "Jone Doe" }, { "Date", DateTime.Now } });
            Console.WriteLine(customTemplateResult);
        }
    }

    public class CustomTemplate : Template
    {
        string[] _arguments = null;

        public CustomTemplate()
        {
            StartToken = "{{";
            EndToken = "}}";
        }

        public override CodeBlock CreateNewCodeBlock(string code, int creationIndex)
        {
            return new CustomCodeBlock(code, creationIndex, _arguments);
        }

        public override ParsedTemplate CreateParsedTemplate(TextReader reader, params string[] arguments)
        {
            _arguments = arguments;
            return new ParsedTemplate(this, reader, arguments);
        }

        public override Output CreateNewOutput(ParsedTemplate parsedTemplate, TextWriter writer)
        {
            return new CustomOutput(parsedTemplate, writer);
        }
    }

    public enum CustomCommand
    {
        None,
        Argument,
        CurrentUser
    }

    public class CustomCodeBlock : CodeBlock
    {
        public CustomCommand Command { get; private set; }
        public string ArgumentName { get; private set; }
        public string Format { get; private set; }
        public string[] Arguments { get; private set; }

        public CustomCodeBlock(string code, int creationIndex, params string[] arguments)
            : base(code, creationIndex)
        {
            this.Arguments = arguments;

            Parse(code);
        }

        private void Parse(string text)
        {
            if (text == null || text.StartsWith("="))
                return;

            string argumentName = text;
            string format = null;
            int formatIndex = text.IndexOf(":");
            if (formatIndex > 0)
            {
                argumentName = text.Substring(0, formatIndex);
                format = text.Substring(formatIndex + 1);
            }

            if (Arguments.Any(_ => _ == argumentName))
            {
                Command = CustomCommand.Argument;
                ArgumentName = argumentName;
                Format = format;
            }
            else if (string.Equals(text, "CurrentUser", StringComparison.InvariantCultureIgnoreCase))
            {
                Command = CustomCommand.CurrentUser;
            }
        }

        public override void BuildSourceCode(StringBuilder source, ParsedTemplate parsed)
        {
            switch (Command)
            {
                case CustomCommand.Argument:
                    source.Append(parsed.Template.OutputItemName);
                    if (string.IsNullOrEmpty(Format))
                    {
                        source.Append(".Write(");
                        source.Append(ArgumentName);
                        source.Append(");");
                    }
                    else
                    {
                        source.Append(".WriteFormatted(");
                        source.Append(ArgumentName);
                        source.Append(", \"");
                        source.Append(Format);
                        source.Append("\");");
                    }

                    return;

                case CustomCommand.CurrentUser:

                    source.Append(parsed.Template.OutputItemName);
                    source.Append(".Write(\"");
                    source.Append(Environment.UserName);
                    source.Append("\");");
                    return;
            }

            base.BuildSourceCode(source, parsed);
        }
    }

    [ComVisible(true)] // Needed to be used by JavaScript
    public class CustomOutput : Output
    {
        public CustomOutput(ParsedTemplate template, TextWriter writer)
            : base(template, writer)
        {

        }

        public void WriteFormatted(object value, string format)
        {
            if (string.IsNullOrWhiteSpace(format))
            {
                Write(string.Format("{0}", value));
            }
            else
            {
                string formattedValue = string.Format("{0:" + format + "}", value);
                Write(formattedValue);
            }
        }
    }
}