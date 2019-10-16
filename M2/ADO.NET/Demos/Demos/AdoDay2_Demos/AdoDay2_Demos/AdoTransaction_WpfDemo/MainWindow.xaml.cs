using System;
using System.Collections.Generic;
using System.Configuration;
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

namespace AdoTransaction_WpfDemo
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cn1"].ConnectionString);
        SqlCommand cmd1 = null, cmd2 = null;

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            BindData();
        }

        private void BindData()
        {
            cmd1 = new SqlCommand("select * from BankAccount", cn);
            cn.Open();
            SqlDataReader dr = cmd1.ExecuteReader();
            List<BankAccount> bankAccs = new List<BankAccount>();
            while(dr.Read())
            {
                BankAccount ba = new BankAccount();
                ba.AccNo = (int)dr[0];
                ba.AccHolderName = dr[1].ToString();
                ba.CurBalance = (decimal)dr[2];
                bankAccs.Add(ba);
            }
            dr.Close();
            cn.Close();
            dgAccInfo.ItemsSource = bankAccs;
        }

        private void TransferMoney(int fromAcc, int toAcc, decimal amount)
        {
            SqlTransaction t1 = null;

            try
            {
                cmd1 = new SqlCommand("update BankAccount set CurBalance=(CurBalance-@amt) where AccNo=@frmAcc", cn);
                cmd1.Parameters.AddWithValue("@amt", amount);
                cmd1.Parameters.AddWithValue("@frmAcc", fromAcc);

                cmd2 = new SqlCommand("update BankAccount set CurBalance=(CurBalance+@amt) where AccNo=@toAcc", cn);
                cmd2.Parameters.AddWithValue("@amt", amount);
                cmd2.Parameters.AddWithValue("@toAcc", toAcc);

                cn.Open();

                //t1 = cn.BeginTransaction();
                //cmd1.Transaction = t1;
                //cmd2.Transaction = t1;

                cmd1.ExecuteNonQuery();
                throw new Exception();
                cmd2.ExecuteNonQuery();

                //t1.Commit();
                MessageBox.Show("Successfull!");
            }
            catch (Exception ex)
            {
                //t1.Rollback();
            }
            finally
            {
                cn.Close();
            }
        }

        private void btnTransfer_Click(object sender, RoutedEventArgs e)
        {
            int accNo1 = int.Parse(txtAccNo1.Text);
            int accNo2 = int.Parse(txtAccNo2.Text);
            decimal amt = decimal.Parse(txtAmt.Text);
            TransferMoney(accNo1, accNo2, amt);
            BindData();
        }
    }
}
