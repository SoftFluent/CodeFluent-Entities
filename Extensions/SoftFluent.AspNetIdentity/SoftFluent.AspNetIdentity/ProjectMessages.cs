using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CodeFluent.Model;

namespace SoftFluent.AspNetIdentity
{
    public class ProjectMessages
    {
        private readonly Project _project;

        public ProjectMessages(Project project)
        {
            if (project == null) throw new ArgumentNullException("project");

            _project = project;

            RoleNotFoundMessages = GetMessages(ProjectMessageType.RoleNotFound);
        }

        public Message RoleNotFoundMessage
        {
            get { return GetMessage(RoleNotFoundMessages); }
        }

        public IList<Message> RoleNotFoundMessages { get; private set; }

        private Message GetMessage(IList<Message> messages)
        {
            if (messages == null)
                return null;

            foreach (var message in messages)
            {
                if (Equals(message.Culture, _project.Culture))
                {
                    return message;
                }
            }

            return messages.FirstOrDefault();
        }

        private IList<Message> GetMessages(ProjectMessageType messageType)
        {
            IList<Message> result = new List<Message>();
            foreach (var message in _project.Messages)
            {
                if (message.Class != MessageClass._default.ToString())
                    continue;

                if (message.GetAttributeValue("messageType", Constants.NamespaceUri, ProjectMessageType.None) == messageType)
                {
                    result.Add(message);
                }
            }

            return result;
        }
    }
}
