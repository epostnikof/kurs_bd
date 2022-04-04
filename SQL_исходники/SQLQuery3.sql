-- 1. Необходимо создать базу данных для базы отдыха с названием Resdb. И так же мы зададим настройки сортировки. Для этого вводим команду:  
CREATE DATABASE Resdb1
COLLATE Cyrillic_General_CI_AS
GO
--База данных успешно создана. Это можно увидеть в Object explorer. 
-- 1. Необходимо создать таблицы БД. 
-- Будут установленны NULL значения на те поля, которые не обязательны к заполнению. Все ID будут автоинкреминтироваться, для этого пишется ключевое слово IDENTITY. 
--Cледующее поле fullname (ФИО) будет типа nvarchar на 60 символов и поддерживать NUll значения. Потому что клиент может зарегестрироваться, указав только номер телефона.
-- Поля pass_seria nchar(4)(серия паспорта, pass_number nchar (6) (номер паспорта) - имеют фиксированную длинну, 4 и 6 символов соответственно.
-- Поля pass_issued_by nvarchar(100)(кем выдан паспорт) и registr nvarchar(150)(прописка по паспорту) - текстовые и имеют длинну 100 и 150 символов.
-- Для телефона используется тип данных char(12), потому что это константа, которая ограничивается двенадцатью символами.
CREATE TABLE Clients 
(ID int NOT NULL IDENTITY, 
fullname nvarchar(60),
[date] date,
pass_seria nchar(4), 
pass_number nchar (6),
pass_issued_by nvarchar(100),
pass_date_issue date,
registr nvarchar(150), 
phone char(12) NOT NULL
)
GO
-- В таблице Cottage будут храниться только названия коттеджей. Вся остальная информация будет находиться в Cottagedetails.
CREATE TABLE Сottage
(ID int NOT NULL IDENTITY,
[name] nvarchar(60))
GO
--Далее создаётся таблица с сотрудниками с названием Employees. В этой таблице будет находится только основная инфомация о сотрудниках. Развёрнутая информация будет находится в таблице Employeesinfo.
-- Все поля кроме премии указаны, как NOT NULL, потому что предполагается, что остальная информация о сотруднике будет в наличии у сотрудника отдела кадров.
CREATE TABLE Employees
(ID int NOT NULL IDENTITY,
fullname_em nvarchar(60) NOT NULL,
position nvarchar(60) NOT NULL,
wage money NOT NULL,
premium money NULL
)
GO
--Следубщая таблица: Employeesinfo. Здесь будет хранится дополнительная информация о сотрудниках. Такая как: дата рождения, семейное положение, паспортные данные и номер телефона.
CREATE TABLE EmployeesInfo
(ID int NOT NULL,
date_em date NOT NULL,
marial_status nvarchar(15) NOT NULL,
pass_seria_em char(4) NOT NULL,
pass_number_em char(6) NOT NULL,
pass_issued_by_em nvarchar(100) NOT NULL,
pass_date_issue_em date NOT NULL,
registr_em nvarchar(150) NOT NULL,
phone_em char(12) NOT NULL
)
GO
--Таблица CottageDetails содержит дополнительную инфомацию о коттеджах, которые есть на базе отдыха, а именно: стоимость, количество комнат, ванн, кондиционеров, двухспальных кроватей, односпальных кроаватей и показывают общую, максимально возможную вместимость одного коттеджа.

CREATE TABLE CottageDetails
(ID int NOT NULL,
price money NOT NULL,
number_of_rooms char(1) NOT NULL,
bathroom char(1) NOT NULL,
shower char(1) NOT NULL,
conditioning char(1) NOT NULL,
double_beds char(2) NOT NULL,
single_beds char(2) NOT NULL,
capacity char(1) NOT NULL
)
GO
--Таблица Resrvation содержит в себе инфомацию о дате заезда, дате выезда и статусе брони. Статус может быть "Оплачена" или "Не оплачена".
CREATE TABLE Reservation
(ID int IDENTITY NOT NULL,
ID_cot int NOT NULL,
ID_cl int NOT NULL,
ID_em int NOT NULL,
date_start date NOT NULL,
date_end date NOT NULL,
[status] nvarchar(10) NOT NULL 
)
GO
--2 Установка связей между таблицами. Так же при этом необходимо предусмотреть условие ссылочной целостности. 
--Таблицы Employees и Employeesinfo будут связанны как один к одному, по причине того, что была просто вынесена информация в отдельную таблицу. 
--Таблицы Cottage и CottageDetails будут тоже связанны один к одному, по той же причине что и таблицы Employees и Employeesinfo.
--Таблица Reservation хранит в себе такие данные как ID коттеджа, клиента и сотрудника и остальную информацию о брони. 
--Для того, чтобы задать связи между таблицами, необходимо задать первичные внешние ключи. 
--Необходимо изменить таблицу Clients и дать первичный ключ полю ID. 

ALTER TABLE Clients
ADD
PRIMARY KEY(ID)
GO 
-- Таким же образом нужно создать первичные ключи для таблиц Cottage, Reservation и Employees. 
ALTER TABLE Сottage
ADD
PRIMARY KEY(ID)
GO 
ALTER TABLE Reservation
ADD
PRIMARY KEY(ID)
GO 
ALTER TABLE Employees
ADD
PRIMARY KEY(ID)
GO 
-- Таблица Employees и Employeesinfo будут связанны как один к одному, и для обеспечения такого типа связанности неоходимо обеспечить уникальность ID у таблицы EmployeesInfo.То есть будет изменена таблица EmployeesInfo посредством того, что будет добавлено ограничение UNIQUE на поле ID 
ALTER TABLE EmployeesInfo 
ADD
UNIQUE (ID)
GO
-- Теперь можно сзязать таблицы, для этого необходимо снова изменить таблицу EmployeesInfo создать внешний ключ на поле ID, которое будет ссылаться на таблицу Employees (родительскую таблицу) на поле ID. При этом нужно обеспечить ссылочную целостность. Чтобы это сделать, необходимо задать условие ON DELETE CASCADE. Т.е. при каскадном удалении из таблицы Employees каскадно будут удалены данные из EmployeesInfo.
ALTER TABLE EmployeesInfo 
ADD
FOREIGN KEY (ID) REFERENCES Employees (ID)
ON DELETE CASCADE
GO
-- В отношении таблиц Cottage и CottageDetails проделываются аналогичные действия. 
ALTER TABLE CottageDetails
ADD
UNIQUE (ID)
GO
ALTER TABLE CottageDetails 
ADD
FOREIGN KEY (ID) REFERENCES Сottage(ID)
ON DELETE CASCADE
GO
--В таблице Reservation первичный ключ уже указан, осталость только указать внешние ключи с другими таблицами.
ALTER TABLE Reservation
ADD
UNIQUE (ID)
GO

ALTER TABLE Reservation
ADD
FOREIGN KEY (ID_cl) REFERENCES Clients (ID)
ON DELETE CASCADE
GO

ALTER TABLE Reservation
ADD
FOREIGN KEY (ID_em) REFERENCES Employees(ID)
ON DELETE CASCADE
GO
ALTER TABLE Reservation
ADD
FOREIGN KEY (ID_cot) REFERENCES Сottage(ID)
ON UPDATE NO ACTION
GO
-- Таким образом от таблицы Reservation были созданы внешние ключи на таблицы Clients (ID), Employees(ID), Сottage(ID)

-- Необходимо создать таблицу с пользователями, для учёта пользователей базы данных. 
CREATE TABLE users
(ID int NOT NULL IDENTITY,
ID_em int NOT NULL, 
username nvarchar(20))
GO

--Нужно привязать таблицу польвателей базы данных, к таблице сотрудники, перед этим в таблице users необходимо указать первичный ключ. 
ALTER TABLE users 
ADD
PRIMARY KEY(ID)
ALTER TABLE users
ADD
FOREIGN KEY (ID_em) REFERENCES Employees(ID)
ON DELETE CASCADE


--1. Запросы.
-- Вывести всех сотрудников, у которых день рождения в октябре.
-- Состав запроса: 1. Берётся столбец full_name, из таблицы Employees 2. Переименовывается столбец, в столбец "Сотрудник". 3. Соеденяется таблица Employees с Employeesinfo по полю ID, таблица Employeesinfo переименовывается в "ei".
-- 4. Задаётся фильтр, по которому отсеиваются все сотрудники, чьё день рождения не в октябре посредством WHERE MONTH (ei.date_em) = 10.
SELECT fullname_em Сотрудник, ei.date_em Дата_рождения FROM Employees e
JOIN EmployeesInfo ei 
ON e.ID = ei.ID
WHERE MONTH (ei.date_em) = 10
-- Учёт платежей. Необходимо вывести название коттеджа из таблицы Cottage, имя клиента из таблицы Clients на которого был или будет оформлен номер, стоимость номера из таблицы Cottageifno, даты заезда и даты выезда из таблицы 
-- Reservation, статус брони и конечную стоимость, которую нужно посчитать из разницы дат. Вывод результатов для удобства должен быть только за последние три месяца по дате заезда. Сортировка от А до Я по дате заезда.
-- По сути можно изметить вывод результатов от 1 до бесконечности месяцев и задать для каждого отображения отдельные кнопки. Для этого нужно поменять цифру 3 в запросе "WHERE date_start BETWEEN DATEADD(m, -3, GETDATE()) AND GETDATE () ORDER BY date_start" на любую другую цифру, которая бы фильтровала нужное количество месяцев.   на число месяцев от 1 до 12.
-- Запрос №2 удовлетворяет сразу двум условиям: 
--1. Формирование расписания;
--2. Учёт платежей и бронирования.
-- По сути это и были те самые условия, которые было необходимо выполнить посредством SQL-запроса. 
CREATE VIEW Reservation_money AS
SELECT fullname ФИО_клиента, 
date_start Дата_заезда,
date_end Дата_выезда,
name Название_коттеджа,
DATEDIFF (DAY, date_start,date_end) Срок_проживания,
price Суточная_цена,
DATEDIFF (DAY, date_start,date_end)* price AS Стоимость_проживания,
status Статус_брони,
fullname_em Ответственный_сотрудник
FROM Reservation res
JOIN Сottage c
ON c.ID = res.ID_cot
JOIN CottageDetails cd
ON cd.ID = c.ID
JOIN Clients cl
ON cl.ID = res.ID_cl
JOIN Employees em
ON em.ID = res.ID_em

--ORDER BY date_start

--Третий запрос выводит имя пользователя базы данных,его реальное имя и должность. Сортировка от А до Я по столбцу full_name

CREATE VIEW UsersDB AS
SELECT fullname_em ФИО,username Имя_пользователя,position Должность FROM Employees em
JOIN users u
ON u.ID_em = em.ID

--ORDER BY fullname_em

-- Четвёртый запрос будет выводить полную информацию о коттеджах на базе отдыха.
CREATE VIEW Cottage AS
SELECT name Имя_коттеджа,
number_of_rooms Количество_комнат,
bathroom Ванных_комнат,
shower Количество_душевых,
conditioning Кондиционеров,
double_beds Двуспальных_кроватей,
single_beds Односпальных_кроватей,
price Стоимость,
capacity Макс_вместимость
FROM Сottage c
JOIN CottageDetails cd
ON cd.ID = c.ID

-- Пятый запрос выводит полную информацию о сотрудниках. Рядом со столбцом дата рождения будет написан возраст, который вычисялется посредством разности даты рождения и системной даты и времени.

CREATE VIEW FullEM AS
SELECT fullname_em ФИО,
position Должность,
phone_em Номер_телефона,
date_em Дата_рождения,
DATEDIFF( year, date_em, getDate() ) as Возраст,
wage Заработная_плата,
premium Премия,
marial_status Семейное_положение,
pass_seria_em Серия_паспорта,
pass_number_em Номер_паспорта,
pass_issued_by_em Кем_выдан_паспорт,
pass_date_issue_em Дата_выдачи_паспорта
FROM Employees e
JOIN EmployeesInfo em
ON em.ID = e.ID

--ORDER BY fullname_em - сортировка нужна для создания форм