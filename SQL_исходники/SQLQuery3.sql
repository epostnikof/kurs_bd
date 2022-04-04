-- 1. ���������� ������� ���� ������ ��� ���� ������ � ��������� Resdb. � ��� �� �� ������� ��������� ����������. ��� ����� ������ �������:  
CREATE DATABASE Resdb1
COLLATE Cyrillic_General_CI_AS
GO
--���� ������ ������� �������. ��� ����� ������� � Object explorer. 
-- 1. ���������� ������� ������� ��. 
-- ����� ������������ NULL �������� �� �� ����, ������� �� ����������� � ����������. ��� ID ����� ����������������������, ��� ����� ������� �������� ����� IDENTITY. 
--C�������� ���� fullname (���) ����� ���� nvarchar �� 60 �������� � ������������ NUll ��������. ������ ��� ������ ����� ������������������, ������ ������ ����� ��������.
-- ���� pass_seria nchar(4)(����� ��������, pass_number nchar (6) (����� ��������) - ����� ������������� ������, 4 � 6 �������� ��������������.
-- ���� pass_issued_by nvarchar(100)(��� ����� �������) � registr nvarchar(150)(�������� �� ��������) - ��������� � ����� ������ 100 � 150 ��������.
-- ��� �������� ������������ ��� ������ char(12), ������ ��� ��� ���������, ������� �������������� ����������� ���������.
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
-- � ������� Cottage ����� ��������� ������ �������� ���������. ��� ��������� ���������� ����� ���������� � Cottagedetails.
CREATE TABLE �ottage
(ID int NOT NULL IDENTITY,
[name] nvarchar(60))
GO
--����� �������� ������� � ������������ � ��������� Employees. � ���� ������� ����� ��������� ������ �������� ��������� � �����������. ���������� ���������� ����� ��������� � ������� Employeesinfo.
-- ��� ���� ����� ������ �������, ��� NOT NULL, ������ ��� ��������������, ��� ��������� ���������� � ���������� ����� � ������� � ���������� ������ ������.
CREATE TABLE Employees
(ID int NOT NULL IDENTITY,
fullname_em nvarchar(60) NOT NULL,
position nvarchar(60) NOT NULL,
wage money NOT NULL,
premium money NULL
)
GO
--��������� �������: Employeesinfo. ����� ����� �������� �������������� ���������� � �����������. ����� ���: ���� ��������, �������� ���������, ���������� ������ � ����� ��������.
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
--������� CottageDetails �������� �������������� ��������� � ���������, ������� ���� �� ���� ������, � ������: ���������, ���������� ������, ����, �������������, ������������ ��������, ������������ ��������� � ���������� �����, ����������� ��������� ����������� ������ ��������.

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
--������� Resrvation �������� � ���� ��������� � ���� ������, ���� ������ � ������� �����. ������ ����� ���� "��������" ��� "�� ��������".
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
--2 ��������� ������ ����� ���������. ��� �� ��� ���� ���������� ������������� ������� ��������� �����������. 
--������� Employees � Employeesinfo ����� �������� ��� ���� � ������, �� ������� ����, ��� ���� ������ �������� ���������� � ��������� �������. 
--������� Cottage � CottageDetails ����� ���� �������� ���� � ������, �� ��� �� ������� ��� � ������� Employees � Employeesinfo.
--������� Reservation ������ � ���� ����� ������ ��� ID ��������, ������� � ���������� � ��������� ���������� � �����. 
--��� ����, ����� ������ ����� ����� ���������, ���������� ������ ��������� ������� �����. 
--���������� �������� ������� Clients � ���� ��������� ���� ���� ID. 

ALTER TABLE Clients
ADD
PRIMARY KEY(ID)
GO 
-- ����� �� ������� ����� ������� ��������� ����� ��� ������ Cottage, Reservation � Employees. 
ALTER TABLE �ottage
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
-- ������� Employees � Employeesinfo ����� �������� ��� ���� � ������, � ��� ����������� ������ ���� ����������� ��������� ���������� ������������ ID � ������� EmployeesInfo.�� ���� ����� �������� ������� EmployeesInfo ����������� ����, ��� ����� ��������� ����������� UNIQUE �� ���� ID 
ALTER TABLE EmployeesInfo 
ADD
UNIQUE (ID)
GO
-- ������ ����� ������� �������, ��� ����� ���������� ����� �������� ������� EmployeesInfo ������� ������� ���� �� ���� ID, ������� ����� ��������� �� ������� Employees (������������ �������) �� ���� ID. ��� ���� ����� ���������� ��������� �����������. ����� ��� �������, ���������� ������ ������� ON DELETE CASCADE. �.�. ��� ��������� �������� �� ������� Employees �������� ����� ������� ������ �� EmployeesInfo.
ALTER TABLE EmployeesInfo 
ADD
FOREIGN KEY (ID) REFERENCES Employees (ID)
ON DELETE CASCADE
GO
-- � ��������� ������ Cottage � CottageDetails ������������� ����������� ��������. 
ALTER TABLE CottageDetails
ADD
UNIQUE (ID)
GO
ALTER TABLE CottageDetails 
ADD
FOREIGN KEY (ID) REFERENCES �ottage(ID)
ON DELETE CASCADE
GO
--� ������� Reservation ��������� ���� ��� ������, ��������� ������ ������� ������� ����� � ������� ���������.
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
FOREIGN KEY (ID_cot) REFERENCES �ottage(ID)
ON UPDATE NO ACTION
GO
-- ����� ������� �� ������� Reservation ���� ������� ������� ����� �� ������� Clients (ID), Employees(ID), �ottage(ID)

-- ���������� ������� ������� � ��������������, ��� ����� ������������� ���� ������. 
CREATE TABLE users
(ID int NOT NULL IDENTITY,
ID_em int NOT NULL, 
username nvarchar(20))
GO

--����� ��������� ������� ����������� ���� ������, � ������� ����������, ����� ���� � ������� users ���������� ������� ��������� ����. 
ALTER TABLE users 
ADD
PRIMARY KEY(ID)
ALTER TABLE users
ADD
FOREIGN KEY (ID_em) REFERENCES Employees(ID)
ON DELETE CASCADE


--1. �������.
-- ������� ���� �����������, � ������� ���� �������� � �������.
-- ������ �������: 1. ������ ������� full_name, �� ������� Employees 2. ����������������� �������, � ������� "���������". 3. ����������� ������� Employees � Employeesinfo �� ���� ID, ������� Employeesinfo ����������������� � "ei".
-- 4. ������� ������, �� �������� ����������� ��� ����������, ��� ���� �������� �� � ������� ����������� WHERE MONTH (ei.date_em) = 10.
SELECT fullname_em ���������, ei.date_em ����_�������� FROM Employees e
JOIN EmployeesInfo ei 
ON e.ID = ei.ID
WHERE MONTH (ei.date_em) = 10
-- ���� ��������. ���������� ������� �������� �������� �� ������� Cottage, ��� ������� �� ������� Clients �� �������� ��� ��� ����� �������� �����, ��������� ������ �� ������� Cottageifno, ���� ������ � ���� ������ �� ������� 
-- Reservation, ������ ����� � �������� ���������, ������� ����� ��������� �� ������� ���. ����� ����������� ��� �������� ������ ���� ������ �� ��������� ��� ������ �� ���� ������. ���������� �� � �� � �� ���� ������.
-- �� ���� ����� �������� ����� ����������� �� 1 �� ������������� ������� � ������ ��� ������� ����������� ��������� ������. ��� ����� ����� �������� ����� 3 � ������� "WHERE date_start BETWEEN DATEADD(m, -3, GETDATE()) AND GETDATE () ORDER BY date_start" �� ����� ������ �����, ������� �� ����������� ������ ���������� �������.   �� ����� ������� �� 1 �� 12.
-- ������ �2 ������������� ����� ���� ��������: 
--1. ������������ ����������;
--2. ���� �������� � ������������.
-- �� ���� ��� � ���� �� ����� �������, ������� ���� ���������� ��������� ����������� SQL-�������. 
CREATE VIEW Reservation_money AS
SELECT fullname ���_�������, 
date_start ����_������,
date_end ����_������,
name ��������_��������,
DATEDIFF (DAY, date_start,date_end) ����_����������,
price ��������_����,
DATEDIFF (DAY, date_start,date_end)* price AS ���������_����������,
status ������_�����,
fullname_em �������������_���������
FROM Reservation res
JOIN �ottage c
ON c.ID = res.ID_cot
JOIN CottageDetails cd
ON cd.ID = c.ID
JOIN Clients cl
ON cl.ID = res.ID_cl
JOIN Employees em
ON em.ID = res.ID_em

--ORDER BY date_start

--������ ������ ������� ��� ������������ ���� ������,��� �������� ��� � ���������. ���������� �� � �� � �� ������� full_name

CREATE VIEW UsersDB AS
SELECT fullname_em ���,username ���_������������,position ��������� FROM Employees em
JOIN users u
ON u.ID_em = em.ID

--ORDER BY fullname_em

-- �������� ������ ����� �������� ������ ���������� � ��������� �� ���� ������.
CREATE VIEW Cottage AS
SELECT name ���_��������,
number_of_rooms ����������_������,
bathroom ������_������,
shower ����������_�������,
conditioning �������������,
double_beds �����������_��������,
single_beds ������������_��������,
price ���������,
capacity ����_�����������
FROM �ottage c
JOIN CottageDetails cd
ON cd.ID = c.ID

-- ����� ������ ������� ������ ���������� � �����������. ����� �� �������� ���� �������� ����� ������� �������, ������� ����������� ����������� �������� ���� �������� � ��������� ���� � �������.

CREATE VIEW FullEM AS
SELECT fullname_em ���,
position ���������,
phone_em �����_��������,
date_em ����_��������,
DATEDIFF( year, date_em, getDate() ) as �������,
wage ����������_�����,
premium ������,
marial_status ��������_���������,
pass_seria_em �����_��������,
pass_number_em �����_��������,
pass_issued_by_em ���_�����_�������,
pass_date_issue_em ����_������_��������
FROM Employees e
JOIN EmployeesInfo em
ON em.ID = e.ID

--ORDER BY fullname_em - ���������� ����� ��� �������� ����