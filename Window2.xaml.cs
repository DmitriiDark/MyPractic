using System;
using System.Collections.Generic;
using System.Data;
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
using Shadrin_new;

namespace Shadrin_new
{
    public partial class Window2 : Window
    {
        SHADRINEntities db = new SHADRINEntities();
        private int usID;
        public Window2(int userId)
        {
            InitializeComponent();
            usID = userId;
            LoadCategories();
        }

        private void LoadCategories()
        {
            try
            {
                var categories = db.Category.Select(c => new { c.ID, c.category1 }).ToList();

                if (categories.Count == 0)
                {
                    MessageBox.Show("Категории номеров не найдены!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }

                comboCategories.ItemsSource = categories;
                comboCategories.DisplayMemberPath = "category1";
                comboCategories.SelectedValuePath = "ID";
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка загрузки категорий: " + ex.Message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }

        }

        private void LoadRooms(int categoryId)
        {
            var rooms = (from r in db.Room_stock
                         join c in db.Category on r.category2 equals c.ID
                         where r.category2 == categoryId
                         select new { r.number, c.category1 }).ToList();

            comboRooms.ItemsSource = rooms;
            comboRooms.DisplayMemberPath = "number";
            comboRooms.SelectedValuePath = "number";
        }
        private void comboCategories_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (comboCategories.SelectedValue != null)
            {
                int selectedCategoryId = (int)comboCategories.SelectedValue;
                LoadRooms(selectedCategoryId);
                comboRooms.IsEnabled = true;
            }
        }

        private void CalculateCost_Click(object sender, RoutedEventArgs e)
        {
            if (comboRooms.SelectedValue == null || dateEntry.SelectedDate == null || dateExit.SelectedDate == null)
            {
                MessageBox.Show("Выберите дату и номер", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            DateTime entryDate = dateEntry.SelectedDate.Value;
            DateTime exitDate = dateExit.SelectedDate.Value;
            int days = (exitDate - entryDate).Days;
            if (days <= 0)
            {
                MessageBox.Show("Дата выезда должна быть позже даты въезда", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            int roomNumber = (int)comboRooms.SelectedValue;
            var roomCategory = (from r in db.Room_stock
                                join c in db.Category on r.category2 equals c.ID
                                where r.number == roomNumber
                                select c.category1).FirstOrDefault();

            int pricePerDay = 1000;
            if (roomCategory == "Люкс с 2 двуспальными кроватями") pricePerDay = 4500;
            else if (roomCategory == "Одноместный стандарт") pricePerDay = 2520;
            else if (roomCategory == "Стандарт двухместный с 2 раздельными кроватями") pricePerDay = 2970;
            else if (roomCategory == "Эконом двухместный с 2 раздельными кроватями") pricePerDay = 2700;
            else if (roomCategory == "3-местный бюджет") pricePerDay = 3150;
            else if (roomCategory == "Бизнес с 1 или 2 кроватями") pricePerDay = 3780;
            else if (roomCategory == "Одноместный эконом") pricePerDay = 2250;
            else if (roomCategory == "Двухкомнатный двухместный стандарт с 1 или 2 кроватями") pricePerDay = 3600;
            else if (roomCategory == "Студия") pricePerDay = 4050;
            int totalCost = days * pricePerDay;
            if (cbBreakfast.IsChecked == true)
            {
                totalCost += 750;
            }
            if (cbDinner.IsChecked == true)
            {
                totalCost += 1100;
            }
            int parkingDays = 0;
            if (!string.IsNullOrEmpty(txtParking.Text) && int.TryParse(txtParking.Text, out parkingDays))
            {
                totalCost += parkingDays * 750;
            }
            textCost.Text = totalCost.ToString();
        }

        private void BookRoom_Click(object sender, RoutedEventArgs e)
        {
            if (comboRooms.SelectedValue == null || dateEntry.SelectedDate == null || dateExit.SelectedDate == null || string.IsNullOrEmpty(textCost.Text))
            {
                MessageBox.Show("Заполните все поля!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            int roomNumber = (int)comboRooms.SelectedValue;
            DateTime entryDate = dateEntry.SelectedDate.Value;
            DateTime exitDate = dateExit.SelectedDate.Value;
            int days = (exitDate - entryDate).Days;

            if (days <= 0)
            {
                MessageBox.Show("Дата выезда должна быть позже даты въезда", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            // Проверяем, существует ли гость
            var existingGuest = db.Guests.FirstOrDefault(g => g.client == usID);

            // Если гостя нет - создаем нового
            if (existingGuest == null)
            {
                var newGuest = new Guests
                {
                    number1 = roomNumber,
                    client = usID,
                    date_of_entry = entryDate,
                    departure_date = exitDate
                };

                db.Guests.Add(newGuest);
                db.SaveChanges(); // Сохраняем, чтобы получить ID
                existingGuest = newGuest; // Теперь у нас есть ID
            }

            // Расчет стоимости
            var roomCategory = (from r in db.Room_stock
                                join c in db.Category on r.category2 equals c.ID
                                where r.number == roomNumber
                                select c.category1).FirstOrDefault();

            int pricePerDay = 1000;
            if (roomCategory == "Люкс с 2 двуспальными кроватями") pricePerDay = 4500;
            else if (roomCategory == "Одноместный стандарт") pricePerDay = 2520;
            else if (roomCategory == "Стандарт двухместный с 2 раздельными кроватями") pricePerDay = 2970;
            else if (roomCategory == "Эконом двухместный с 2 раздельными кроватями") pricePerDay = 2700;
            else if (roomCategory == "3-местный бюджет") pricePerDay = 3150;
            else if (roomCategory == "Бизнес с 1 или 2 кроватями") pricePerDay = 3780;
            else if (roomCategory == "Одноместный эконом") pricePerDay = 2250;
            else if (roomCategory == "Двухкомнатный двухместный стандарт с 1 или 2 кроватями") pricePerDay = 3600;
            else if (roomCategory == "Студия") pricePerDay = 4050;

            int totalCost = days * pricePerDay;
            if (cbBreakfast.IsChecked == true) totalCost += 750;
            if (cbDinner.IsChecked == true) totalCost += 1100;

            int parkingDays = 0;
            if (!string.IsNullOrEmpty(txtParking.Text) && int.TryParse(txtParking.Text, out parkingDays))
            {
                totalCost += parkingDays * 750;
            }

            // Создаем заказ
            Zakaz newZakaz = new Zakaz
            {
                number = roomNumber,
                client = usID,
                days = days,
                Price = totalCost.ToString(),
                guest = existingGuest.ID // Используем ID существующего гостя
            };

            db.Zakaz.Add(newZakaz);
            db.SaveChanges();

            MessageBox.Show("Номер успешно забронирован!", "Поздравляем!", MessageBoxButton.OK, MessageBoxImage.Information);
        }

        private void LogoutButton_Click(object sender, RoutedEventArgs e)
            {
                MessageBox.Show("Вы вышли из системы.");
                this.Close();
            }
            private void txtParking_PreviewTextInput(object sender, TextCompositionEventArgs e)
            {
                e.Handled = !char.IsDigit(e.Text, 0);
            }
        }
    }
