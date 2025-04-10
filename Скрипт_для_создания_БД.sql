USE [SHADRIN]
GO
/****** Object:  UserDefinedFunction [dbo].[Col14]    Script Date: 05.04.2025 9:54:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Col14]()
RETURNS FLOAT
AS
BEGIN
DECLARE @ColvoNait AS REAL
SELECT
	@ColvoNait = SUM(Days)
FROM DAYSE
DECLARE @ColvoNumber AS REAL
SELECT
	@ColvoNumber = COUNT(number) 
FROM Room_stock
DECLARE @Zagruzca AS REAL
SELECT
	@Zagruzca = @ColvoNait/(@ColvoNumber*30)*100
RETURN @Zagruzca
END
GO
/****** Object:  UserDefinedFunction [dbo].[Dni]    Script Date: 05.04.2025 9:54:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Dni]
(
	@Date_of_entry AS DATE,
	@Departure_date AS DATE
)
RETURNS INT
AS
BEGIN
DECLARE @Dn AS INT
SET @Dn = DATEDIFF (day, @Date_of_entry, @Departure_date)
RETURN @Dn
END
GO
/****** Object:  UserDefinedFunction [dbo].[Dni5]    Script Date: 05.04.2025 9:54:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Dni5]
(
	@Date_of_entry AS DATE,
	@Departure_date AS DATE
)
RETURNS INT
AS
BEGIN
DECLARE @Dn AS INT
SET @Dn = DATEDIFF (day, @Date_of_entry, @Departure_date)
RETURN @Dn
END
GO
/****** Object:  Table [dbo].[Category]    Script Date: 05.04.2025 9:54:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[ID] [int] NOT NULL,
	[category1] [nvarchar](50) NULL,
 CONSTRAINT [PK_Категория номера] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DAYSE]    Script Date: 05.04.2025 9:54:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DAYSE](
	[number1] [int] NOT NULL,
	[date_of_entry] [date] NULL,
	[departure_date] [date] NULL,
	[days] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Floors]    Script Date: 05.04.2025 9:54:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Floors](
	[ID] [int] NOT NULL,
	[Floor_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Этажи] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Guests]    Script Date: 05.04.2025 9:54:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Guests](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[number1] [int] NOT NULL,
	[client] [int] NOT NULL,
	[date_of_entry] [date] NULL,
	[departure_date] [date] NULL,
 CONSTRAINT [PK_Постояльцы] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 05.04.2025 9:54:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[ID] [int] NOT NULL,
	[role1] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Роли] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Room_status]    Script Date: 05.04.2025 9:54:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room_status](
	[ID] [int] NOT NULL,
	[name_status] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Статус номера] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Room_stock]    Script Date: 05.04.2025 9:54:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room_stock](
	[number] [int] NOT NULL,
	[category2] [int] NOT NULL,
	[floor] [int] NOT NULL,
	[status] [int] NULL,
 CONSTRAINT [PK_Номерной фонд] PRIMARY KEY CLUSTERED 
(
	[number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 05.04.2025 9:54:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[surname] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[otchestvo] [nvarchar](50) NOT NULL,
	[role2] [int] NOT NULL,
	[login] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[count] [int] NULL,
	[active] [bit] NOT NULL,
	[date] [date] NULL,
 CONSTRAINT [PK__Users__3214EC27CE440A9B] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Zakaz]    Script Date: 05.04.2025 9:54:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zakaz](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[number] [int] NULL,
	[client] [int] NULL,
	[days] [int] NULL,
	[Price] [nvarchar](50) NULL,
	[guest] [int] NULL,
 CONSTRAINT [PK_Zakaz] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Category] ([ID], [category1]) VALUES (11, N'Одноместный стандарт')
INSERT [dbo].[Category] ([ID], [category1]) VALUES (12, N'Одноместный эконом')
INSERT [dbo].[Category] ([ID], [category1]) VALUES (13, N'Стандарт двухместный с 2 раздельными кроватями')
INSERT [dbo].[Category] ([ID], [category1]) VALUES (14, N'Эконом двухместный с 2 раздельными кроватями')
INSERT [dbo].[Category] ([ID], [category1]) VALUES (15, N'3-местный бюджет')
INSERT [dbo].[Category] ([ID], [category1]) VALUES (21, N'Бизнес с 1 ил 2 кроватями')
INSERT [dbo].[Category] ([ID], [category1]) VALUES (22, N'Двухкомнатный двухместный стандарт')
INSERT [dbo].[Category] ([ID], [category1]) VALUES (23, N'Одноместный стандарт')
INSERT [dbo].[Category] ([ID], [category1]) VALUES (31, N'Студия')
INSERT [dbo].[Category] ([ID], [category1]) VALUES (32, N'Люкс с 2 двухспальными кроватями')
GO
INSERT [dbo].[DAYSE] ([number1], [date_of_entry], [departure_date], [days]) VALUES (101, CAST(N'2025-02-13' AS Date), CAST(N'2025-03-02' AS Date), 17)
INSERT [dbo].[DAYSE] ([number1], [date_of_entry], [departure_date], [days]) VALUES (102, CAST(N'2025-02-28' AS Date), NULL, NULL)
INSERT [dbo].[DAYSE] ([number1], [date_of_entry], [departure_date], [days]) VALUES (104, CAST(N'2025-02-23' AS Date), CAST(N'2025-02-02' AS Date), -21)
INSERT [dbo].[DAYSE] ([number1], [date_of_entry], [departure_date], [days]) VALUES (105, CAST(N'2023-03-01' AS Date), CAST(N'2025-03-07' AS Date), 737)
INSERT [dbo].[DAYSE] ([number1], [date_of_entry], [departure_date], [days]) VALUES (107, CAST(N'2025-03-27' AS Date), CAST(N'2025-04-22' AS Date), 26)
INSERT [dbo].[DAYSE] ([number1], [date_of_entry], [departure_date], [days]) VALUES (107, CAST(N'2025-02-24' AS Date), CAST(N'2025-03-17' AS Date), 21)
INSERT [dbo].[DAYSE] ([number1], [date_of_entry], [departure_date], [days]) VALUES (108, CAST(N'2025-02-15' AS Date), CAST(N'2025-03-20' AS Date), 33)
INSERT [dbo].[DAYSE] ([number1], [date_of_entry], [departure_date], [days]) VALUES (109, CAST(N'2025-03-27' AS Date), CAST(N'2025-03-12' AS Date), -15)
INSERT [dbo].[DAYSE] ([number1], [date_of_entry], [departure_date], [days]) VALUES (110, CAST(N'2025-02-14' AS Date), CAST(N'2025-02-02' AS Date), -12)
INSERT [dbo].[DAYSE] ([number1], [date_of_entry], [departure_date], [days]) VALUES (201, CAST(N'2025-02-24' AS Date), CAST(N'2025-03-17' AS Date), 21)
INSERT [dbo].[DAYSE] ([number1], [date_of_entry], [departure_date], [days]) VALUES (203, CAST(N'2025-02-25' AS Date), CAST(N'2025-03-07' AS Date), 10)
INSERT [dbo].[DAYSE] ([number1], [date_of_entry], [departure_date], [days]) VALUES (205, CAST(N'2025-03-01' AS Date), CAST(N'2025-03-04' AS Date), 3)
INSERT [dbo].[DAYSE] ([number1], [date_of_entry], [departure_date], [days]) VALUES (206, CAST(N'2025-02-02' AS Date), CAST(N'2025-02-02' AS Date), 0)
INSERT [dbo].[DAYSE] ([number1], [date_of_entry], [departure_date], [days]) VALUES (207, CAST(N'2025-02-25' AS Date), CAST(N'2025-03-04' AS Date), 7)
INSERT [dbo].[DAYSE] ([number1], [date_of_entry], [departure_date], [days]) VALUES (208, CAST(N'2025-02-25' AS Date), CAST(N'2025-03-04' AS Date), 7)
INSERT [dbo].[DAYSE] ([number1], [date_of_entry], [departure_date], [days]) VALUES (209, CAST(N'2025-02-27' AS Date), NULL, NULL)
INSERT [dbo].[DAYSE] ([number1], [date_of_entry], [departure_date], [days]) VALUES (304, CAST(N'2025-02-28' AS Date), CAST(N'2025-03-15' AS Date), 15)
INSERT [dbo].[DAYSE] ([number1], [date_of_entry], [departure_date], [days]) VALUES (306, CAST(N'2025-02-11' AS Date), NULL, NULL)
GO
INSERT [dbo].[Floors] ([ID], [Floor_name]) VALUES (1, N'1 этаж')
INSERT [dbo].[Floors] ([ID], [Floor_name]) VALUES (2, N'2 этаж')
INSERT [dbo].[Floors] ([ID], [Floor_name]) VALUES (3, N'3 этаж')
GO
SET IDENTITY_INSERT [dbo].[Guests] ON 

INSERT [dbo].[Guests] ([ID], [number1], [client], [date_of_entry], [departure_date]) VALUES (1, 306, 25, CAST(N'2025-04-05' AS Date), CAST(N'2025-04-16' AS Date))
INSERT [dbo].[Guests] ([ID], [number1], [client], [date_of_entry], [departure_date]) VALUES (2, 101, 3, CAST(N'2025-02-13' AS Date), CAST(N'2025-03-02' AS Date))
INSERT [dbo].[Guests] ([ID], [number1], [client], [date_of_entry], [departure_date]) VALUES (3, 102, 4, CAST(N'2025-02-28' AS Date), NULL)
INSERT [dbo].[Guests] ([ID], [number1], [client], [date_of_entry], [departure_date]) VALUES (4, 104, 5, CAST(N'2025-02-23' AS Date), CAST(N'2025-02-02' AS Date))
INSERT [dbo].[Guests] ([ID], [number1], [client], [date_of_entry], [departure_date]) VALUES (5, 105, 6, CAST(N'2023-03-01' AS Date), CAST(N'2025-03-07' AS Date))
INSERT [dbo].[Guests] ([ID], [number1], [client], [date_of_entry], [departure_date]) VALUES (6, 107, 7, CAST(N'2025-03-27' AS Date), CAST(N'2025-04-22' AS Date))
INSERT [dbo].[Guests] ([ID], [number1], [client], [date_of_entry], [departure_date]) VALUES (7, 107, 8, CAST(N'2025-02-24' AS Date), CAST(N'2025-03-17' AS Date))
INSERT [dbo].[Guests] ([ID], [number1], [client], [date_of_entry], [departure_date]) VALUES (8, 108, 9, CAST(N'2025-02-15' AS Date), CAST(N'2025-03-20' AS Date))
INSERT [dbo].[Guests] ([ID], [number1], [client], [date_of_entry], [departure_date]) VALUES (9, 109, 10, CAST(N'2025-03-27' AS Date), CAST(N'2025-03-12' AS Date))
INSERT [dbo].[Guests] ([ID], [number1], [client], [date_of_entry], [departure_date]) VALUES (10, 110, 11, CAST(N'2025-02-14' AS Date), CAST(N'2025-02-02' AS Date))
INSERT [dbo].[Guests] ([ID], [number1], [client], [date_of_entry], [departure_date]) VALUES (11, 201, 12, CAST(N'2025-02-24' AS Date), CAST(N'2025-03-17' AS Date))
INSERT [dbo].[Guests] ([ID], [number1], [client], [date_of_entry], [departure_date]) VALUES (12, 203, 13, CAST(N'2025-02-25' AS Date), CAST(N'2025-03-07' AS Date))
INSERT [dbo].[Guests] ([ID], [number1], [client], [date_of_entry], [departure_date]) VALUES (13, 205, 14, CAST(N'2025-03-01' AS Date), CAST(N'2025-03-04' AS Date))
INSERT [dbo].[Guests] ([ID], [number1], [client], [date_of_entry], [departure_date]) VALUES (14, 206, 15, CAST(N'2025-02-02' AS Date), CAST(N'2025-02-02' AS Date))
INSERT [dbo].[Guests] ([ID], [number1], [client], [date_of_entry], [departure_date]) VALUES (15, 207, 16, CAST(N'2025-02-25' AS Date), CAST(N'2025-03-04' AS Date))
INSERT [dbo].[Guests] ([ID], [number1], [client], [date_of_entry], [departure_date]) VALUES (16, 208, 17, CAST(N'2025-02-25' AS Date), CAST(N'2025-03-04' AS Date))
INSERT [dbo].[Guests] ([ID], [number1], [client], [date_of_entry], [departure_date]) VALUES (17, 209, 18, CAST(N'2025-02-27' AS Date), NULL)
INSERT [dbo].[Guests] ([ID], [number1], [client], [date_of_entry], [departure_date]) VALUES (18, 304, 19, CAST(N'2025-02-28' AS Date), CAST(N'2025-03-15' AS Date))
INSERT [dbo].[Guests] ([ID], [number1], [client], [date_of_entry], [departure_date]) VALUES (19, 306, 20, CAST(N'2025-02-11' AS Date), NULL)
SET IDENTITY_INSERT [dbo].[Guests] OFF
GO
INSERT [dbo].[Role] ([ID], [role1]) VALUES (1, N'руководитель')
INSERT [dbo].[Role] ([ID], [role1]) VALUES (2, N'администратор')
INSERT [dbo].[Role] ([ID], [role1]) VALUES (3, N'клиент')
GO
INSERT [dbo].[Room_status] ([ID], [name_status]) VALUES (111, N'чистый')
INSERT [dbo].[Room_status] ([ID], [name_status]) VALUES (222, N'назначен к уборке')
INSERT [dbo].[Room_status] ([ID], [name_status]) VALUES (333, N'грязный')
INSERT [dbo].[Room_status] ([ID], [name_status]) VALUES (444, N'занят')
GO
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (101, 11, 1, 444)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (102, 11, 1, 444)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (103, 12, 1, 111)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (104, 12, 1, 444)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (105, 13, 1, 444)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (106, 13, 1, 111)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (107, 14, 1, 444)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (108, 14, 1, 444)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (109, 15, 1, 444)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (110, 15, 1, 444)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (201, 21, 2, 444)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (202, 21, 2, 111)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (203, 21, 2, 444)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (204, 22, 2, 222)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (205, 22, 2, 444)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (206, 22, 2, 444)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (207, 23, 2, 444)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (208, 23, 2, 444)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (209, 23, 2, 444)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (301, 31, 3, 333)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (302, 31, 3, 333)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (303, 31, 3, 111)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (304, 32, 3, 444)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (305, 32, 3, 111)
INSERT [dbo].[Room_stock] ([number], [category2], [floor], [status]) VALUES (306, 32, 3, 444)
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (1, N'Шевченко', N'Ольга', N'Викторовна', 3, N'3', N'13131313', 0, 1, CAST(N'2025-04-04' AS Date))
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (2, N'Петров', N'Пётр', N'Петрович', 1, N'2', N'22', 0, 1, NULL)
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (3, N'IШадрин', N'Дмитрий', N'Александрович', 2, N'DarkysDark', N'Dark1612', 0, 1, CAST(N'2025-04-04' AS Date))
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (4, N'Мазалова', N'Ирина', N'Львовна', 3, N'4', N'44', 0, 1, CAST(N'2025-04-04' AS Date))
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (5, N'Семеняка', N'Юрий', N'Геннадьевич', 3, N'5', N'45', 0, 1, NULL)
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (6, N'Савельев', N'Олег', N'Иванович', 3, N'6', N'66', 0, 1, CAST(N'2025-03-28' AS Date))
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (7, N'Бунин', N'Эдуард', N'Михайлович', 3, NULL, NULL, 0, 1, NULL)
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (8, N'Бахшиев', N'Павел', N'Иннокентьевич', 3, NULL, NULL, 0, 1, NULL)
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (9, N'Тюренкова', N'Наталья', N'Сергеевна', 3, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (10, N'Любяшква', N'Галина', N'Аркадьевна', 3, NULL, NULL, 0, 1, NULL)
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (11, N'Александров', N'Пётр', N'Константинович', 3, NULL, NULL, 0, 1, NULL)
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (12, N'Мизалова', N'Ольга', N'Николаевна', 3, NULL, NULL, 0, 1, NULL)
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (13, N'Лапшин', N'Виктор', N'Романови', 3, NULL, NULL, 0, 1, NULL)
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (14, N'Гусев', N'Семён', N'Петрович', 3, NULL, NULL, 0, 1, NULL)
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (15, N'Гладилина', N'Вера', N'Михайловна', 3, NULL, NULL, 0, 1, NULL)
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (16, N'Масюк', N'Динара', N'Викторовна', 3, NULL, NULL, 0, 1, NULL)
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (17, N'Лукин', N'Илья', N'Фёдорович', 3, NULL, NULL, 0, 1, NULL)
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (18, N'Петров', N'Станислав', N'Игоревич', 3, NULL, NULL, 0, 1, NULL)
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (19, N'Филь', N'Марина', N'Федоровна', 3, NULL, NULL, 0, 1, NULL)
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (20, N'Михайлов', N'Игорь', N'Вадимович', 3, NULL, NULL, 0, 1, NULL)
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (21, N'Иванов', N'Иван', N'Васильевич', 3, N'234', N'345', 0, 1, NULL)
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (22, N'Матрас', N'Штукатур', N'Александрович', 2, N'Marasik', N'Admin', 0, 1, CAST(N'2025-03-29' AS Date))
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (23, N'Синичкин', N'Валерий', N'Иванович', 3, N'Bobik', N'bob777', 0, 1, CAST(N'2025-03-29' AS Date))
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (24, N'Хлюстов', N'Алехандро', N'Макаревичев', 3, N'hlustov', N'4242564', 0, 1, CAST(N'2025-03-29' AS Date))
INSERT [dbo].[Users] ([ID], [surname], [name], [otchestvo], [role2], [login], [password], [count], [active], [date]) VALUES (25, N'Драгунов', N'Илья', N'Вадимович', 3, N'Rafikongo', N'Raf2025', 0, 1, CAST(N'2025-04-04' AS Date))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_Active]  DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [dbo].[Guests]  WITH CHECK ADD  CONSTRAINT [FK_Guests_Room_stock] FOREIGN KEY([number1])
REFERENCES [dbo].[Room_stock] ([number])
GO
ALTER TABLE [dbo].[Guests] CHECK CONSTRAINT [FK_Guests_Room_stock]
GO
ALTER TABLE [dbo].[Guests]  WITH CHECK ADD  CONSTRAINT [FK_Guests_Users] FOREIGN KEY([client])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Guests] CHECK CONSTRAINT [FK_Guests_Users]
GO
ALTER TABLE [dbo].[Room_stock]  WITH CHECK ADD  CONSTRAINT [FK_Номерной фонд_Категория номера] FOREIGN KEY([category2])
REFERENCES [dbo].[Category] ([ID])
GO
ALTER TABLE [dbo].[Room_stock] CHECK CONSTRAINT [FK_Номерной фонд_Категория номера]
GO
ALTER TABLE [dbo].[Room_stock]  WITH CHECK ADD  CONSTRAINT [FK_Номерной фонд_Статус номера] FOREIGN KEY([status])
REFERENCES [dbo].[Room_status] ([ID])
GO
ALTER TABLE [dbo].[Room_stock] CHECK CONSTRAINT [FK_Номерной фонд_Статус номера]
GO
ALTER TABLE [dbo].[Room_stock]  WITH CHECK ADD  CONSTRAINT [FK_Номерной фонд_Этажи] FOREIGN KEY([floor])
REFERENCES [dbo].[Floors] ([ID])
GO
ALTER TABLE [dbo].[Room_stock] CHECK CONSTRAINT [FK_Номерной фонд_Этажи]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Role] FOREIGN KEY([role2])
REFERENCES [dbo].[Role] ([ID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Role]
GO
ALTER TABLE [dbo].[Zakaz]  WITH CHECK ADD  CONSTRAINT [FK_Zakaz_Guests] FOREIGN KEY([client])
REFERENCES [dbo].[Guests] ([ID])
GO
ALTER TABLE [dbo].[Zakaz] CHECK CONSTRAINT [FK_Zakaz_Guests]
GO
ALTER TABLE [dbo].[Zakaz]  WITH CHECK ADD  CONSTRAINT [FK_Zakaz_Room_stock] FOREIGN KEY([number])
REFERENCES [dbo].[Room_stock] ([number])
GO
ALTER TABLE [dbo].[Zakaz] CHECK CONSTRAINT [FK_Zakaz_Room_stock]
GO
