create database sp;
use sp;

CREATE TABLE Products (
 ProductID INT PRIMARY KEY,
 ProductName VARCHAR(100),
 Category VARCHAR(50),
 UnitPrice DECIMAL(10,2),
 StockQty INT
);

CREATE TABLE Customers (
 CustomerID INT PRIMARY KEY,
 CustomerName VARCHAR(100),
 City VARCHAR(50)
);

CREATE TABLE Orders (
 OrderID INT PRIMARY KEY,
 CustomerID INT,
 OrderDate DATE,
 FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
 OrderDetailID INT PRIMARY KEY,
 OrderID INT,
 ProductID INT,
 Quantity INT,
 FOREIGN KEY(OrderID) REFERENCES Orders(OrderID),
 FOREIGN KEY(ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Products VALUES
(101,'Laptop','Electronics',55000,50),
(102,'Mouse','Electronics',800,150),
(103,'Keyboard','Electronics',1200,100),
(104,'Monitor','Electronics',15000,40),
(105,'Printer','Electronics',12000,30);

INSERT INTO Customers VALUES
(1,'Ravi','Chennai'),
(2,'Priya','Bangalore'),
(3,'Arun','Hyderabad'),
(4,'Sneha','Mumbai');

INSERT INTO Orders VALUES
(1001,1,'2026-01-10'),
(1002,2,'2026-01-15'),
(1003,3,'2026-01-20'),
(1004,1,'2026-02-05');

INSERT INTO OrderDetails VALUES
(1,1001,101,2),
(2,1001,102,3),
(3,1002,103,5),
(4,1003,104,1),
(5,1004,105,2);

-- 1. Create procedure to display products by category.


-- CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProductsByCategory`(
--     IN p_Category VARCHAR(50)
-- )
-- BEGIN
-- SELECT *
--     FROM Products
--     WHERE Category = p_Category;
-- END

call GetProductsByCategory('Electronics');

-- 2. Create procedure to delete an order.


-- CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteOrder`(
--     IN p_OrderID INT
-- )
-- BEGIN

--     DELETE FROM OrderDetails
--     WHERE OrderID = p_OrderID;

--     DELETE FROM Orders
--     WHERE OrderID = p_OrderID;
-- END
call DeleteOrder(1004);

select * from orders;

-- 3. Create function to calculate average order value.


CREATE DEFINER=`root`@`localhost` FUNCTION `AvgOrderValue`() RETURNS decimal(12,2)
--     DETERMINISTIC
-- BEGIN

--     DECLARE AvgValue DECIMAL(12,2);

--     SELECT AVG(OrderTotal)
--     INTO AvgValue
--     FROM
--     (
--         SELECT od.OrderID,
--                SUM(od.Quantity * p.UnitPrice) AS OrderTotal
--         FROM OrderDetails od
--         JOIN Products p
--           ON od.ProductID = p.ProductID
--         GROUP BY od.OrderID
--     ) X;

--     RETURN AvgValue;
-- END


select AvgOrderValue();

-- 4. Create function to count customer orders.


-- CREATE DEFINER=`root`@`localhost` FUNCTION `CountCustomerOrders`(
--     p_CustomerID INT
-- ) RETURNS int
--     DETERMINISTIC
-- BEGIN

--     DECLARE TotalOrders INT;

--     SELECT COUNT(*)
--     INTO TotalOrders
--     FROM Orders
--     WHERE CustomerID = p_CustomerID;

--     RETURN TotalOrders;
-- END
-- select CountCustomerOrders(6);

-- 5. Create procedure to display top-selling products.
-- CREATE DEFINER=`root`@`localhost` PROCEDURE `TopSellingProducts`()
-- BEGIN

--     SELECT
--         p.ProductID,
--         p.ProductName,
--         SUM(od.Quantity) AS TotalQuantitySold
--     FROM Products p
--     JOIN OrderDetails od
--       ON p.ProductID = od.ProductID
--     GROUP BY
--         p.ProductID,
--         p.ProductName
--     ORDER BY TotalQuantitySold DESC;

-- END

call TopSellingProducts();