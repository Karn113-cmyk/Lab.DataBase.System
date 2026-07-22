select * from Catagories
select * from Details
select * from Employees
select * from Products
select * from Receipts
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    CustomerNumber varchar(15) unique
)
select * from Customers
insert into Customers
    (CustomerID,FirstName,LastName,
    CustomerNumber)
values
    (123456789,'KARN','UPACHAI',
    0805049040)
insert into Customers
    (CustomerID,FirstName,LastName,
    CustomerNumber)
values
    (987654321,'qweqwewqe','sadafsdsd',
    0626462971)
select *
from information_schema.tables
where table_type = 'BASE TABLE';
--คำสั่ง sp (store procedure) 
EXEC sp_help 'dbo.Products'
select ProductID,ProductName,UnitPrice
from dbo.Products
select ProductName AS ชื่อสินค้า,
       UnitPrice AS ราคา
from dbo.Products
--ใช้ distinct สำหรับลดการแสดงข้อมูลที่ซ้ำกัน
select distinct position from Employees
--top(5) ใช้สำหรับเลือกข้อมูล 5 รายการแรก
select top(5)
    ProductID,
    ProductName,
    UnitPrice
from dbo.Products
--การแก้ไขข้อมูลในตารางสินค้าให้สินค้าชื่อดินสอ จากราคา 15 ==> 12 บาท
update Products
set UnitPrice = 12
where ProductID = 1
--------------------------
update Products
set UnitPrice = 15
where ProductName = 'ดินสอ'
--ปรับปรุงราคา ยางลบ ให้มีราคา 10 บาท และจำนวนคงเหลือ 250
update dbo.Products
set UnitPrice = 10,
    UnitsInStock = 250
where ProductName = 'ยางลบ'
select * from Products
--ปรับปรุงจำนวนคงเหลือของ ดินสอ เพิ่มขึ้น 100 ชิ้น
update Products
set UnitsInStock += 100
where ProductName = 'ดินสอ'
--ขึ้นราคาสินค้า 5 เปอร์เซ็นทุกรายการ
update Products
set UnitPrice *= 1.05
----------------------------
select * from Products
--ต้องการลบสินค้ารหัส 3
delete from Products where productID = 3
----------------------------
SELECT
    ProductID,
    ProductName,
    UnitPrice
FROM dbo.Products
WHERE UnitPrice < 20;
--ต้องการ ชื่อ-สกุล พนักงานที่เป็น sale manager
select firstname,lastname from Employees
--ต้องการ รหัสสินค้า ของชาเขียว
select productID
from Products
where ProductName = 'ชาเขียว'
--ต้องการสินค้าที่มีจำนวนในสต็อก ต่ำกว่า 400
select * from Products where UnitsInStock < 400
--ข้อมูลสินค้าที่รหัสหมวดหมู่ 1 และราคาไม่เกิน 20
select * from Products
where CategoryID =1 and UnitPrice <=20
--ข้อมูลสินค้าที่รหัสหมวดหมู่ 1 หรือราคาไม่เกิน 20
select * from Products
where CategoryID =1 or UnitPrice <=20
----------------------------------
select * from dbo.Products
where not Discontinued = 1
----------------------------------
SELECT
    ProductID,
    ProductName,
    UnitPrice
FROM dbo.Products
WHERE UnitPrice BETWEEN 10 AND 20;
----------------------------------
SELECT
    ProductID,
    ProductName,
    CategoryID
FROM dbo.Products
WHERE CategoryID IN (1, 2, 4);
--ข้อมูลสินค้าที่ชื่อสินค้าขึ้นต้นด้วยคำว่าน้ำ
SELECT
    ProductID,
    ProductName
FROM dbo.Products
WHERE ProductName LIKE N'น้ำ%'; 
--ชื่อ-สกุล พนักงานที่มีนามสกุลต่อท้ายด้วยคำว่าคำ
SELECT *
FROM dbo.Employees
WHERE LastName like '%คำ'
--ชื่อสินค้า ราคา สินค้าที่มีคำว่า ส้ม
select * from Products where ProductName like '%ส้ม%'
--wildcard คืออะไร?

--เตรียมข้อมูลที่มีค่า null
insert into Employees(FirstName, UserName, Password)
values ('เตวิช', 'tevit', '1234')

insert into Employees(FirstName, LastName, UserName, Password)
values ('เตวิช', '', 'tevit', '1234')
--ต้องการข้อมูลของพนักงานที่ยังไม่ทราบนามสกุล
select * from Employees
where LastName is null
-- ต้องการคำนำหน้า ชื่อ-สกุล พนักงานทุกคน และอยู่ในช่องเดียวกัน
select title+FirstName+' '+LastName as ชื่อนามสกุลพนักงาน
from Employees

select FirstName+' '+LastName as ชื่อนามสกุลพนักงาน
from Employees
-------------------------------------
--กรณีเงื่อนไขเป็นวันที่
select * from Receipts
where ReceiptDate = '2013/02/10' --ตรงตามวัน

select * from Receipts
where ReceiptDate < '2013/02/10' --ก่อนวันที่ระบุ

select * from Receipts
where ReceiptDate >= '2013/02/10' --ตั้งแต่วันนี้ไป

select * from Receipts
where ReceiptDate between '2013-02-01' and '2013-02-07'
--ใช้ function year(), month() มาช่วยในเงื่อนไข
select * from Receipts
where year(ReceiptDate) = 2013 --ปี 2013 ทั้งหมด

select * from Receipts
where year(ReceiptDate) = 2013 and month(ReceiptDate) = 2
-- asscending ASC น้อยไปมาก
-- Descending DESC มากไปน้อย
SELECT
    ProductID,
    ProductName,
    UnitPrice
FROM dbo.Products
ORDER BY UnitPrice ASC;
----------------------------------
SELECT
    ProductID,
    ProductName,
    UnitPrice
FROM dbo.Products
ORDER BY UnitPrice DESC;
--order by ใช้สำรหับเรียงลำดับ จะใส่ตอนท้ายของคำสั่ง SQL
select productID, ProductName, UnitPrice, UnitsInStock
from Products
order by ProductName asc

select productID, ProductName, UnitPrice, UnitsInStock
from Products
order by UnitPrice desc

select top(3) * from Products
order by UnitsInStock desc