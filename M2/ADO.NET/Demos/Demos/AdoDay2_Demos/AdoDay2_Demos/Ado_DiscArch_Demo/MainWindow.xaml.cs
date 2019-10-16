using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Ado_DiscArch_Demo
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        SqlConnection cn = null;
        SqlCommand cmd = null;
        SqlDataAdapter da = null;
        DataSet ds = null;
        public MainWindow()
        {
            InitializeComponent();
            cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cn1"].ConnectionString);
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            FillDataSet();
            PopulateUI();
        }

        private void FillDataSet()
        {
            ds = new DataSet();
            cmd = new SqlCommand("select * from Product", cn);
            da = new SqlDataAdapter(cmd);
            da.MissingSchemaAction = MissingSchemaAction.AddWithKey;
            da.Fill(ds, "tblProduct");
        }

        public void PopulateUI()
        {
            try
            {                
                List<Product> prods = (from DataRow row in ds.Tables["tblProduct"].Rows
                                       select new Product
                                       {
                                           Id = Convert.ToInt32(row["Id"]),
                                           ProdName = row["ProdName"].ToString(),
                                           Price = Convert.ToDouble(row["Price"]),
                                           ExpDate = Convert.ToDateTime(row["ExpDate"])
                                       }).ToList();
                dgProducts.ItemsSource = prods;
                cmbProdName.ItemsSource = prods;
                cmbProdName.DisplayMemberPath = "ProdName";
            }
            catch(Exception ex)
            {

            }
        }

        private void btnUpdate_Click(object sender, RoutedEventArgs e)
        {
            Product p = (Product)cmbProdName.SelectedItem;
            DataRow row = ds.Tables["tblProduct"].Rows.Find(p.Id);
            row["ProdName"] = cmbProdName.Text;
            row["Price"] = Convert.ToDouble(txtPrice.Text);
            row["ExpDate"] = dpExpDate.SelectedDate;
            MessageBox.Show("Updated!");
            PopulateUI();
        }

        private void btnDelete_Click(object sender, RoutedEventArgs e)
        {
            Product p = (Product) cmbProdName.SelectedItem;
            DataRow rw = ds.Tables["tblProduct"].Rows.Find(p.Id);
            rw.Delete();            
            MessageBox.Show("Deleted!");
            PopulateUI();
        }

        private void btnInsert_Click(object sender, RoutedEventArgs e)
        {
            DataRow row = ds.Tables["tblProduct"].NewRow();            
            row["ProdName"] = cmbProdName.Text;
            row["Price"] = Convert.ToDouble(txtPrice.Text);
            row["ExpDate"] = dpExpDate.SelectedDate;
            ds.Tables["tblProduct"].Rows.Add(row);
            MessageBox.Show("Inserted!");
            PopulateUI();
        }

        private void btnUpdateIntoDatabase_Click(object sender, RoutedEventArgs e)
        {
            //foreach (DataRow r in ds.Tables["tblProduct"].Rows)
            //{
            //    MessageBox.Show(r.RowState.ToString());
            //}
            //100 = +10   -10   +-10
            SqlCommandBuilder cmdBuilder = new SqlCommandBuilder(da);            
            da.Update(ds, "tblProduct");
        }
    }
}
