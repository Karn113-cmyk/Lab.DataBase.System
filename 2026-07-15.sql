--------------------- สร้าง ฐานข้อมูล ใส่ชื่อ
create database KarnMinimart
-------------------------------------
create table Employees(
	EmployeeID int identity(1,1) Primary key,
	Title varchar(20),
	FirstName varchar(50) not null,
	LastName varchar(50),
	Position varchar(50),
	Username varchar(50) Unique,
	PasswordHash varchar(255) not null,
	IsActive Bit not null Default 1
)
------------------------------------
INSERT INTO Employees 
	(Title, FirstName, LastName,
	Position, Username, PasswordHash)
VALUES
	(N'นางสาว',N'กาญจนา',N'พวงแก้ว',
	'Sale Manager','user1','hashed1')
-- ดูข้อมูลเพิ่มเติม
select * from Employees
-------------------------------------
drop table Employees --คำสั่งอันตราย **
-------------------------------------
ALTER DATABASE KarnMinimart
COLLATE Thai_CI_AS
-------------------------------------
INSERT INTO Employees 
	(Title, FirstName, LastName,
	Position, Username, PasswordHash)
VALUES
	('นาย','เตวิช','แสนโบราณ',
	'Sale Manager','user2','hashed1')
--------------------------------------
Create Table Catagories(
	CategoryID INT Identity(1,1) Primary Key,
	CatagoryName Varchar(50) not null Unique,
	Description varchar(200)
)
----เพิ่มข้อูลหลังสร้างตาราง 5 หมวดหมู่ในสไลด์
INSERT INTO Catagories(CatagoryName) Values('เครื่องปรุง')
INSERT INTO Catagories(CatagoryName) Values('เครื่องดื่มเย็น')
INSERT INTO Catagories(CatagoryName) Values('อาหารสำเร็จรูป')
INSERT INTO Catagories(CatagoryName) Values('เครื่องสำอาง')
INSERT INTO Catagories(CatagoryName) Values('เวชภัณฑ์')
-----------
select * from Catagories
------------------
Create Table Products(
	ProductID varchar(13) primary key,
	ProductName varchar(100) not null,
	UnitPrice Decimal(10,2)not null DEFAULT 0,
	UnitInstock INT not null DEFAULT 0,
	CategoryID INT not null,
	Discontinued BIT not null DEFAULT 0,
	
	CONSTRAINT CK_Products_UnitPrice
		CHECK (UnitPrice >= 0 ),
	CONSTRAINT CK_Products_UnitInstock
		CHECK (UnitInstock >= 0),
	CONSTRAINT FK_Products_Categories
		FOREIGN KEY (CategoryID)
		REFERENCES Catagories(CategoryID)
)
--------------------------------------
INSERT INTO Products
	(ProductID, ProductName, UnitPrice,
	UnitInstock, CategoryID)
Values
	('8858757001948', 'โค้ก', 15.00,
	290, 1)
--------------------------------------
INSERT INTO Products
	(ProductID, ProductName, UnitPrice,
	UnitInstock, CategoryID)
Values
	('8858757001945', 'โค้ก', 10.00,
	20, 1)
--------------------------------------
select * from Products
----------------------------
drop table Catagories --drop ไม่ได้ติดอ้างอิง
---------------------------------------
CREATE TABLE Receipts (
    ReceiptID INT IDENTITY(1,1) PRIMARY KEY,
    ReceiptDate DATETIME NOT NULL 
        DEFAULT GETDATE(),
    EmployeeID INT NOT NULL,
    TotalCash DECIMAL(10,2) NOT NULL DEFAULT 0,

    CONSTRAINT CK_Receipts_TotalCash 
        CHECK (TotalCash >= 0),

    CONSTRAINT FK_Receipts_Employees 
        FOREIGN KEY (EmployeeID) 
        REFERENCES Employees(EmployeeID)
);
---------------------------------------------
INSERT INTO Receipts 
    (EmployeeID, TotalCash)
VALUES 
    (1, 115.00);
---------------------------------------------
INSERT INTO Receipts 
    (EmployeeID, TotalCash)
VALUES 
    (99, 100.00);
---------------------------------------------
select * from Receipts
--------------------------------------------
CREATE TABLE Details (
    ReceiptID INT NOT NULL,
    ProductID VARCHAR(13) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL,

    CONSTRAINT PK_Details
        PRIMARY KEY (ReceiptID, ProductID),

    CONSTRAINT CK_Details_UnitPrice
        CHECK (UnitPrice >= 0),

    CONSTRAINT CK_Details_Quantity
        CHECK (Quantity > 0),

    CONSTRAINT FK_Details_Receipts
        FOREIGN KEY (ReceiptID)
        REFERENCES Receipts(ReceiptID),

    CONSTRAINT FK_Details_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);
-----------------------------------------
INSERT INTO Details
    (ReceiptID, ProductID, UnitPrice, Quantity)
VALUES
    (1, '8858757001948', 15.00, 3);
-------------------------------------------
INSERT INTO Details
    (ReceiptID, ProductID, UnitPrice, Quantity)
VALUES
    (1, '8858757001948', 15.00, 0);
-------------------------------------------
select * from Details
