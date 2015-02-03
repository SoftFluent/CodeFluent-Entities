using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Web.Http;
using Newtonsoft.Json.Serialization;

namespace SoftFluent.Samples.AngularJs
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            // Web API configuration and services

            // Use camel case for JSON data.
            config.Formatters.JsonFormatter.SerializerSettings.ContractResolver = new CamelCasePropertyNamesContractResolver();

            //// use WCF serializer
            //JsonMediaTypeFormatter jsonFormatter = (JsonMediaTypeFormatter)config.Formatters.FirstOrDefault(f => f is JsonMediaTypeFormatter);
            //if (jsonFormatter != null)
            //{
            //    jsonFormatter.UseDataContractJsonSerializer = true; 
            //}

            // Web API routes
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{ids}",
                defaults: new { ids = RouteParameter.Optional }
            );
        }
    }
}
