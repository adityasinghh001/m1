using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace Ado_DiscArch_Demo
{
    /// <summary>
    /// Interaction logic for Window1.xaml
    /// </summary>
    public partial class Window1 : Window
    {
        public Window1()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            List<Student> studs = new List<Student>
            {
                new Student { RollNo = 101, FullName = "Sharad" },
                new Student { RollNo = 102, FullName = "Ashwini" },
                new Student { RollNo = 103, FullName = "Renuka" },
                new Student { RollNo = 104, FullName = "Harshal" }
            };
            //studs = bal.GetAll();
            cbStudName.ItemsSource = studs;
            cbStudName.DisplayMemberPath = "RollNo";
        }
    }
}
