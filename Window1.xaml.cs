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
using System.Data.Entity;

namespace Shadrin_new
{
    /// <summary>
    /// Логика взаимодействия для Window1.xaml
    /// </summary>
    public partial class Window1 : Window
    {
        // подключаемся к базе данных
        SHADRINEntities db = new SHADRINEntities();
        public Window1()
        {
            InitializeComponent();
            // создаём массив ролей, передаём значения из бд в выпадающий список
            var Role = (from x in db.Role select x).ToArray();
            typeRole.DisplayMemberPath = "role1";
            typeRole.SelectedValuePath = "ID";
            db.Users.Load();
            typeRole.ItemsSource = db.Users.Local.ToBindingList();
            typeRole.ItemsSource = Role;
            
            // создаём массив пользователй, передаём значения из бд в таблицу

            var user1 = (from u in db.Users select u).ToArray();
                GridUser.ItemsSource = db.Users.ToList();
        }

        private void button3_Click(object sender, RoutedEventArgs e)
        {
            Users Users1 = new Users();
            var user2 = (from u in db.Users
                         where u.login == TextBox1.Text
                         select u).ToArray();
            // проверяем наличие пользователя
            if (user2.Length == 0)
            {
                // записываем данные из полей в таблицу бд
                Users1.surname = TextBox3.Text;
                Users1.name = TextBox4.Text;
                Users1.otchestvo = TextBox5.Text;
                Users1.role2 = (typeRole.SelectedItem as Role).ID;
                Users1.login = TextBox1.Text;
                Users1.password = TextBox2.Text;
                Users1.count = 0;
                Users1.active = true;
                Users1.date = null;
                db.Users.Add(Users1);
                db.SaveChanges();
                // обновление таблицы для вывода из базы
                var user1 = (from u in db.Users select u).ToArray();
                GridUser.ItemsSource = user1;
                MessageBox.Show("Данные успешно добавлены", "Уведомление",
                MessageBoxButton.OK, MessageBoxImage.Information);
            }
            else
            {
                MessageBox.Show("Такой пользователь уже существует",
                "!", MessageBoxButton.OK, MessageBoxImage.Error);
            }

        }

        private void button4_Click(object sender, RoutedEventArgs e)
        {
            db.SaveChanges();
        }
    }
}
