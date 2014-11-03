using System;
using System.ComponentModel;
using System.Net.Http;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using Microsoft.AspNet.SignalR.Client;
using SoftFluent.Samples.SignalR.Proxy;

namespace SoftFluent.Samples.SignalR.Client
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public const string ServerUri = "http://localhost:12345";
        private static readonly object _lock = new object();

        public MainWindow()
        {
            InitializeComponent();
        }

        private IHubProxy HubProxy { get; set; }
        private HubConnection Connection { get; set; }

        private async Task<bool> EnsureProxy()
        {
            if (HubProxy != null)
                return true;

            Connection = new HubConnection(ServerUri);
            HubProxy = Connection.CreateHubProxy("CustomerHub");

            // Register callbacks
            HubProxy.On<Customer>("Saved", OnCustomerSaved);
            HubProxy.On<Guid>("Deleted", OnCustomerDeleted);
            try
            {
                await Connection.Start();
                return true;
            }
            catch (HttpRequestException)
            {
                Connection.Dispose();
                Connection = null;
                MessageBox.Show("Unable to connect to server: Start server before connecting clients.");
                return false;
            }
        }

        private void OnCustomerDeleted(Guid id)
        {
            var customerCollection = DataGrid.ItemsSource as CustomerCollection;
            if (customerCollection != null)
            {
                customerCollection.Remove(id);
            }
        }

        private void OnCustomerSaved(Customer customer)
        {
            var customerCollection = DataGrid.ItemsSource as CustomerCollection;
            if (customerCollection != null)
            {
                var c = customerCollection[customer.Id];
                if (c != null)
                {
                    customer.CopyTo(c, true); // Update existing customer
                }
                else
                {
                    customerCollection.Add(customer); // Add new customer
                }
            }
        }

        private async void ButtonLoadCustomers_OnClick(object sender, RoutedEventArgs e)
        {
            if (!await EnsureProxy())
                return;

            var customers = await HubProxy.Invoke<CustomerCollection>("Get");
            if (customers == null)
                customers = new CustomerCollection();

            BindingOperations.EnableCollectionSynchronization(customers, _lock);
            DataGrid.ItemsSource = customers;
        }

        private void MainWindow_OnClosing(object sender, CancelEventArgs e)
        {
            if (Connection != null)
            {
                Connection.Stop();
                Connection.Dispose();
            }
        }

        private async void DataGrid_RowEditEnding(object sender, DataGridRowEditEndingEventArgs e)
        {
            if (e.Cancel)
                return;

            var result = await HubProxy.Invoke<bool>("Save", e.Row.Item);
        }

        private async void ButtonDelete_OnClick(object sender, RoutedEventArgs e)
        {
            var customer = ((Button)sender).DataContext as Customer;
            if (customer == null)
                return;

            if (!await EnsureProxy())
                return;

            var result = await HubProxy.Invoke<bool>("Delete", customer);
        }
    }
}