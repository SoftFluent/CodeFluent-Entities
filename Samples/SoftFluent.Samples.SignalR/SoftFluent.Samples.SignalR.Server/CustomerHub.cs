using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNet.SignalR;

namespace SoftFluent.Samples.SignalR.Server
{
public class CustomerHub : Hub
{
    public IEnumerable<Customer> Get()
    {
        IEnumerable<Customer> customerCollection = CustomerCollection.LoadAll();
        return customerCollection;
    }

    public bool Save(Customer customer)
    {
        if (customer == null) throw new ArgumentNullException("customer");

        Console.WriteLine("Saving: " + customer.Trace());
        bool save = Customer.Save(customer);
        if (save)
        {
            Clients.All.Saved(customer);
        }

        return save;
    }

    public bool Delete(Customer customer)
    {
        if (customer == null) throw new ArgumentNullException("customer");

        Console.WriteLine("Deleting: " + customer.Trace());
        bool delete = Customer.Delete(customer);
        if (delete)
        {
            Clients.All.Deleted(customer.Id);
        }

        return delete;
    }

    public override Task OnConnected()
    {
        Console.WriteLine("Client connected: " + Context.ConnectionId);
        return base.OnConnected();
    }

    public override Task OnDisconnected(bool stopCalled)
    {
        Console.WriteLine("Client disconnected: " + Context.ConnectionId);
        return base.OnDisconnected(stopCalled);
    }
}
}