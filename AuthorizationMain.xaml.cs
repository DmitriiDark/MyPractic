using System;
using System.Collections.Generic;
using System.Data.Entity;
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

namespace Shadrin_new
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>\
    
    public partial class AuthorizationMian : Window
    {
        SHADRINEntities db = new SHADRINEntities();
        
        public AuthorizationMian()
        {
            InitializeComponent();
        }
        private int usID;
        private void Button1_Click(object sender, RoutedEventArgs e)
        {
            // Организуем обработчик "ошибок кода"
            try
            {
                Console.WriteLine("start");
                // создаём массив пользователей из БД
                //var user = (from x in db.Users
                //            where x.login == TextBox1.Text
                //            select x).ToArray();
                var user = db.Users.Where(x => x.login == TextBox1.Text).ToArray();
                Console.WriteLine("added");
                // проверяем условия входа - поля логин и пароль должны быть не пустыми
                if (TextBox1.Text.Length == 0 || TextBox2.Text.Length == 0)
                {
                    // если 1 из полей пустое = выводим сообщение об ошибке
                    MessageBox.Show("Заполните обязательные поля Логин и Пароль", "!",
                        MessageBoxButton.OK, MessageBoxImage.Error);
                    Console.WriteLine("not fill");
                }
                else
                {
                    // проверяем правильность введеного логина
                    if (TextBox1.Text == user[0].login)
                    {
                        Console.WriteLine("login ok");
                        // вычисляем количество дней, прошедших после последнего входа пользователя
                        if (TextBox2.Text == user[0].password)
                        {
                            Console.WriteLine("password ok");
                            if (user[0].date != null)
                            {
                                // вычисляем количество дней, прошедших после последнего входапользователя
                                 DateTime d1 = DateTime.Now;
                                DateTime d2 = Convert.ToDateTime(user[0].date);
                                TimeSpan d = d1 - d2;
                                // если прошло более 30 дней, блокируем запись
                                if (Convert.ToInt32(d.ToString("dd")) > 30)
                                {
                                    Console.WriteLine("DATE");
                                    user[0].active = false;
                                    db.SaveChanges();
                                }
                            }
                            // проверяем статус активности пользователя
                            if (user[0].active == true)
                            {
                                Console.WriteLine(1);
                                switch (user[0].role2)
                                {
                                    // организуем вход в соответствии с ролью пользователя
                                    case 2:
                                        Console.WriteLine("1/2");
                                        MessageBox.Show("Добро пожаловать. Вы успешно авторизировались как администратор " + user[0].surname,
                                            "Уведомление", MessageBoxButton.OK, MessageBoxImage.Information);
                                        Window1 window = new Window1();
                                        window.Show();
                                        break;

                                    case 3:
                                        if (user[0].date == null)
                                        {
                                            Console.WriteLine("1/3");
                                            MessageBox.Show("Добро пожаловать. При первом входев систему необходимо изменить пароль" ,
                                            "Уведомление", MessageBoxButton.OK,
                                            MessageBoxImage.Information);
                                            usID = user[0].ID;
                                            UpdatePass window3 = new UpdatePass(usID);
                                            window3.Show();
                                        }
                                        else
                                        {
                                            Console.WriteLine("2/3");
                                            MessageBox.Show("Добро пожаловать. Вы успешноавторизировались как пользователь " + user[0].surname, 
                                            "Уведомление", MessageBoxButton.OK,MessageBoxImage.Information);
                                            Window2 window1 = new Window2(usID);
                                            window1.Show();
                                        }
                                        break;
                                    default:
                                        Console.WriteLine("1/d");
                                        MessageBox.Show("Данные не обнаружены", "Уведомление",
                                            MessageBoxButton.OK, MessageBoxImage.Information);
                                        break;
                                }
                                Console.WriteLine("1/end");
                                // записываем текущую дату входа
                                user[0].date = DateTime.Now;
                                user[0].count = 0;
                                db.SaveChanges();

                            }
                            else
                            {
                                Console.WriteLine("2");
                                MessageBox.Show("Вы заблокированы. Обратитесь к администратору сисетмы.",
                                    "Уведомление", MessageBoxButton.OK, MessageBoxImage.Information);
                            }
                        }
                        else
                        {
                            // проверяем количество неправильных вводов пароля
                            if (user[0].count > 2)
                            {
                                Console.WriteLine("Count");
                                user[0].active = false;
                                db.SaveChanges();
                                MessageBox.Show("Вы заблокированы. Обратитесь к администратору систем",
                                    "Уведомление", MessageBoxButton.OK, MessageBoxImage.Information);
                            }
                            else
                            {
                                MessageBox.Show("Вы ввели неверный логин или пароль", "Пожалуйста проверьте ещё раз введенные данные", MessageBoxButton.OK, MessageBoxImage.Error);
                                user[0].count++;
                                db.SaveChanges();
                            }
                        }
                    }
                }
            }


            catch (SystemException ex)
            {
                Console.WriteLine(ex);
                MessageBox.Show("Ошибка системы", "Ошибка",
                    MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void Button2_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}