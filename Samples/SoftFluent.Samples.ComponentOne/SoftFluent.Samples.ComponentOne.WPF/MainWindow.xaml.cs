using System.Windows;
using C1.WPF.DataGrid;
using C1.WPF.DataGrid.Excel;

namespace SoftFluent.Samples.ComponentOne.WPF
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private readonly UserCollection _userCollection;
        public MainWindow()
        {
            InitializeComponent();
            _userCollection = UserCollection.LoadAll();
            DataGrid.ItemsSource = _userCollection;
        }

        private void ButtonSaveAll_OnClick(object sender, RoutedEventArgs e)
        {
            _userCollection.SaveAll();
        }

        private void C1DataGrid_BeginningNewRow(object sender, DataGridBeginningNewRowEventArgs e)
        {
            var contact = e.Item as Contact;
            if (contact == null)
                return;
            var user = DataGrid.CurrentRow.DataItem as User;
            if (user != null)
            {
                contact.User = user;
            }
        }

        private void ButtonExportToExcel_OnClick(object sender, RoutedEventArgs e)
        {
            DataGrid.Save("export.xlsx", FileFormat.Xlsx);
        }
    }
}
