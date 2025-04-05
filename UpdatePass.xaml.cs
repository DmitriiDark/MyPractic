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

namespace Shadrin_new
{
    /// <summary>
    /// Логика взаимодействия для UpdatePass.xaml
    /// </summary>
    public partial class UpdatePass : Window
    {
        SHADRINEntities db = new SHADRINEntities();
        private int usID;
        public UpdatePass(int usID)
        {
            this.usID = usID;
            InitializeComponent();
        }

        private void button2_Click(object sender, RoutedEventArgs e)
        {
            // создаём массив пользователей из базы данных
            // загружаем данные пользователя, у которого ид равен передаваемому с формы авторизации
            var user = (from x in db.Users
                        where x.ID == usID
                        select x).ToArray();
            Console.WriteLine(user);
            // если старый и новый пароли совпадают
            try
            {
                if (user[0].password == TextBox3.Text)
                {
                    // если новый и подтверждение пароля совпадают
                    if (TextBox4.Text == TextBox5.Text)
                    {
                        // меняем старый пароль на новый в базе данных
                        user[0].password = TextBox4.Text;
                        db.SaveChanges();
                        MessageBox.Show("Пароль успешно изменён",
                        "Уведомление", MessageBoxButton.OK, MessageBoxImage.Information);
                        // сохраняем новую дату входа
                        user[0].date = DateTime.Now;
                        // обнуляем счётчик неправильных попыток входа
                        user[0].count = 0;
                        db.SaveChanges();
                        // переходим на окно пользователя
                        Window2 window1 = new Window2(user[0].ID);
                        window1.Show();
                    }
                    else
                    {
                        MessageBox.Show("Введённые пароли не совпадают!", "Пожалуйста проверьте ещё развведённые данные",

                        MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                }
                else
                {
                    MessageBox.Show("Старый пароль не совпадает!", "Пожалуйста проверьте ещё раз введённыеданные",

                    MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
            catch (Exception ex) 
            { 
                Console.WriteLine(ex);
            }
        }
    }
}
