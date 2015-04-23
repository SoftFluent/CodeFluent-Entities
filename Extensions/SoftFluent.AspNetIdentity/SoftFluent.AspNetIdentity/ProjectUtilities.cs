using System;
using System.Linq;
using CodeFluent.Model;
using CodeFluent.Model.Code;

namespace SoftFluent.AspNetIdentity
{
    public class ProjectUtilities
    {
        public static Entity FindByEntityType(Project project, EntityType entityType)
        {
            if (project == null) throw new ArgumentNullException("project");

            foreach (var entity in project.Entities)
            {
                if (entity.GetAttributeValue("entityType", Constants.NamespaceUri, EntityType.None) == entityType)
                {
                    return entity;
                }
            }

            return null;
        }

        public static Property FindByPropertyType(Entity entity, PropertyType propertyType)
        {
            if (entity == null) throw new ArgumentNullException("entity");

            foreach (var property in entity.AllProperties)
            {
                if (property.GetAttributeValue("propertyType", Constants.NamespaceUri, PropertyType.None) == propertyType)
                {
                    return property;
                }
            }

            PropertyTypeCompatibility compatibility = (PropertyTypeCompatibility) propertyType;
            foreach (var property in entity.AllProperties)
            {
                var value = property.GetAttributeValue("propertyType", Constants.NamespaceUri, PropertyTypeCompatibility.None);
                if (value == compatibility ||
                    (value == PropertyTypeCompatibility.User && propertyType == PropertyType.UserClaimUser) ||
                    (value == PropertyTypeCompatibility.User && propertyType == PropertyType.UserLoginUser))
                {
                    return property;
                }
            }

            return null;
        }

        public static Method FindByMethodType(Entity entity, MethodType methodType)
        {
            if (entity == null) throw new ArgumentNullException("entity");

            foreach (var method in entity.AllMethods)
            {
                if (method.GetAttributeValue("methodType", Constants.NamespaceUri, MethodType.None) == methodType)
                {
                    return method;
                }
            }

            return null;
        }
        
        public static Property FindNameProperty(Entity entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");

            var properties = entity.AllProperties.Where(_ => _.ClrFullTypeName == typeof(string).FullName).ToList();

            return properties.FirstOrDefault(_ => _.IsCollectionKey) ??
                   properties.FirstOrDefault(_ => _.IsUnique) ??
                   properties.FirstOrDefault();
        }
    }
}