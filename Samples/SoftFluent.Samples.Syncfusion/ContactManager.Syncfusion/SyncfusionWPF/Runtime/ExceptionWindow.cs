using System;
using System.Collections.Generic;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace ContactManager.WPFSyncfusion.Runtime
{
    /// <summary>
    /// Interaction logic for ExceptionWindow.xaml
    /// </summary>
    public partial class ExceptionWindow : Window
    {
        public ExceptionWindow()
        {
            InitializeComponent();
        }

        public void SetException(Exception e)
        {
            ExceptionContent.Text = e.ToString();
        }

        public void CloseButtonClicked(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}
