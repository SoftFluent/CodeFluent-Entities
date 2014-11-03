using System;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Json;
using System.Text;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Transports;
using Microsoft.Owin.Hosting;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using Owin;

namespace SoftFluent.Samples.SignalR.Server
{
class Program
{
    static void Main(string[] args)
    {
        using (WebApp.Start<Startup>("http://localhost:12345"))
        {
            Console.WriteLine("Server started");
            Console.WriteLine("Press any key to exit...");
            Console.ReadKey();
        }
    }
}

public class Startup
{
    public void Configuration(IAppBuilder app)
    {
        //FiddlerFriendly(GlobalHost.DependencyResolver);
        HubConfiguration hubConfiguration = new HubConfiguration();
        hubConfiguration.EnableDetailedErrors = true;
        app.MapSignalR(hubConfiguration);
    }

    //private static void FiddlerFriendly(IDependencyResolver resolver)
    //{
    //    var transportManager = resolver.Resolve<ITransportManager>() as TransportManager;
    //    if (transportManager != null)
    //    {
    //        transportManager.Remove("webSockets");
    //        transportManager.Remove("foreverFrame");
    //    }
    //}
}
}
