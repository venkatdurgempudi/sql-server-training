# SQL Server Assignment: Data Types, Constraints, DDL, and DML

## Objective:
To gain hands-on experience with SQL Server data types, constraints, and executing DDL and DML operations.

---

### 1. **Data Types**

1. **Create a table named `Employees` with the following columns and appropriate data types:**
    - `EmployeeID` (Primary Key, Integer)
    - `FirstName` (Variable character with a max length of 50)
    - `LastName` (Variable character with a max length of 50)
    - `BirthDate` (Date)
    - `Salary` (Decimal with 18 digits total and 2 decimal places)

    ```sql
    CREATE TABLE Employees (
        EmployeeID INT PRIMARY KEY,
        FirstName VARCHAR(50),
        LastName VARCHAR(50),
        BirthDate DATE,
        Salary DECIMAL(18, 2)
    );
    ```

2. **What data type would you use to store a large block of text such as a blog post? Create a table `BlogPosts` with a `Content` column for this purpose.**

    ```sql
    CREATE TABLE BlogPosts (
        PostID INT PRIMARY KEY,
        Title VARCHAR(255),
        Content TEXT
    );
    ```

3. **Create a table named `Products` with the following columns and appropriate data types:**
    - `ProductID` (Primary Key, Integer)
    - `ProductName` (Variable character with a max length of 100)
    - `Price` (Decimal with 10 digits total and 2 decimal places)
    - `StockQuantity` (Integer)

    ```sql
    CREATE TABLE Products (
        ProductID INT PRIMARY KEY,
        ProductName VARCHAR(100),
        Price DECIMAL(10, 2),
        StockQuantity INT
    );
    ```

4. **Create a table named `Orders` with an `OrderID` column as the primary key, which should be auto-incremented. What data type should you use?**

    ```sql
    CREATE TABLE Orders (
        OrderID INT IDENTITY(1,1) PRIMARY KEY,
        CustomerID INT,
        OrderDate DATE
    );
    ```

5. **How would you define a column in a table to store a fixed-length character string, such as a two-letter country code? Provide an example by creating a `Countries` table with a `CountryCode` column.**

    ```sql
    CREATE TABLE Countries (
        CountryID INT PRIMARY KEY,
        CountryCode CHAR(2),
        CountryName VARCHAR(100)
    );
    ```

6. **Create a table named `Customers` with the following columns and appropriate data types:**
    - `CustomerID` (Primary Key, Integer)
    - `FullName` (Variable character with a max length of 100)
    - `EmailAddress` (Variable character with a max length of 100)
    - `PhoneNumber` (Variable character with a max length of 15)

    ```sql
    CREATE TABLE Customers (
        CustomerID INT PRIMARY KEY,
        FullName VARCHAR(100),
        EmailAddress VARCHAR(100),
        PhoneNumber VARCHAR(15)
    );
    ```

7. **What data type would you use to store a timestamp for recording the exact time an event occurred? Create a table named `EventLogs` with a `Timestamp` column for this purpose.**

    ```sql
    CREATE TABLE EventLogs (
        EventID INT PRIMARY KEY,
        EventName VARCHAR(255),
        Timestamp DATETIME
    );
    ```

8. **Create a table named `Inventory` with the following columns:**
    - `InventoryID` (Primary Key, Integer)
    - `ProductID` (Integer, Foreign Key referencing `Products`)
    - `QuantityInStock` (Integer)

    ```sql
    CREATE TABLE Inventory (
        InventoryID INT PRIMARY KEY,
        ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
        QuantityInStock INT
    );
    ```

9. **Create a `Payments` table with a `PaymentAmount` column that can store values up to $999,999.99 with exactly 2 decimal places. What data type should you use?**

    ```sql
    CREATE TABLE Payments (
        PaymentID INT PRIMARY KEY,
        PaymentAmount DECIMAL(8, 2)
    );
    ```

10. **Create a `Users` table with a `Username` column that should not exceed 20 characters. What data type is appropriate?**

    ```sql
    CREATE TABLE Users (
        UserID INT PRIMARY KEY,
        Username VARCHAR(20)
    );
    ```

### 2. **Constraints**

11. **Create a table `Departments` with the following constraints:**
    - `DepartmentID` as the primary key
    - `DepartmentName` with a unique constraint

    ```sql
    CREATE TABLE Departments (
        DepartmentID INT PRIMARY KEY,
        DepartmentName VARCHAR(100) UNIQUE
    );
    ```

12. **Create a `Products` table with a check constraint on the `Price` column ensuring that it cannot be less than zero.**

    ```sql
    CREATE TABLE Products (
        ProductID INT PRIMARY KEY,
        ProductName VARCHAR(100),
        Price DECIMAL(10, 2) CHECK (Price >= 0),
        StockQuantity INT
    );
    ```

13. **Create a `Salaries` table where the `Amount` column must be greater than 0 and cannot exceed $100,000.**

    ```sql
    CREATE TABLE Salaries (
        SalaryID INT PRIMARY KEY,
        Amount DECIMAL(10, 2) CHECK (Amount > 0 AND Amount <= 100000)
    );
    ```

14. **Create a table `Enrollments` with the following columns and constraints:**
    - `EnrollmentID` as the primary key
    - `StudentID` as a foreign key referencing a `Students` table
    - `CourseID` as a foreign key referencing a `Courses` table
    - Ensure that a student can only enroll in the same course once (composite unique constraint on `StudentID` and `CourseID`).

    ```sql
    CREATE TABLE Enrollments (
        EnrollmentID INT PRIMARY KEY,
        StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
        CourseID INT FOREIGN KEY REFERENCES Courses(CourseID),
        CONSTRAINT UQ_StudentCourse UNIQUE (StudentID, CourseID)
    );
    ```

15. **Create a `Vehicles` table with a `VIN` (Vehicle Identification Number) that is exactly 17 characters long.**

    ```sql
    CREATE TABLE Vehicles (
        VIN CHAR(17) PRIMARY KEY,
        Make VARCHAR(50),
        Model VARCHAR(50)
    );
    ```

16. **Create a `Loans` table where the `LoanAmount` must be between $1,000 and $100,000 (inclusive).**

    ```sql
    CREATE TABLE Loans (
        LoanID INT PRIMARY KEY,
        LoanAmount DECIMAL(10, 2) CHECK (LoanAmount BETWEEN 1000 AND 100000)
    );
    ```

17. **Create a `Sales` table where the `SaleDate` column cannot be a future date.**

    ```sql
    CREATE TABLE Sales (
        SaleID INT PRIMARY KEY,
        SaleDate DATE CHECK (SaleDate <= GETDATE())
    );
    ```

18. **Create a table `Inventory` with a default value of 0 for the `QuantityInStock` column.**

    ```sql
    CREATE TABLE Inventory (
        InventoryID INT PRIMARY KEY,
        ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
        QuantityInStock INT DEFAULT 0
    );
    ```

19. **Create a `BankAccounts` table where the `Balance` column cannot be negative.**

    ```sql
    CREATE TABLE BankAccounts (
        AccountID INT PRIMARY KEY,
        Balance DECIMAL(15, 2) CHECK (Balance >= 0)
    );
    ```

20. **Create a `JobApplications` table where the `ApplicationDate` cannot be null.**

    ```sql
    CREATE TABLE JobApplications (
        ApplicationID INT PRIMARY KEY,
        ApplicantName VARCHAR(100),
        ApplicationDate DATE NOT NULL
    );
    ```

### 3. **DDL Operations**

21. **Write a SQL statement to create a database named `SalesDB`.**

    ```sql
    CREATE DATABASE SalesDB;
    ```

22. **Create a table `Invoices` in the `SalesDB` database with the following columns:**
    - `InvoiceID` (Primary Key, Integer)
    - `CustomerID` (Foreign Key, Integer)
    - `InvoiceDate` (Date)
    - `TotalAmount` (Decimal with 10 digits total and 2 decimal places)

    ```sql
    USE SalesDB;

    CREATE TABLE Invoices (
        InvoiceID INT PRIMARY KEY,
        CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
        InvoiceDate DATE,
        TotalAmount DECIMAL(10, 2)
    );
    ```

23. **Create an index on the `LastName` column of the `Employees` table.**

    ```sql
    CREATE INDEX IX_Employees_LastName ON Employees (LastName);
    ```

24. **Alter the `Products` table to add a new column `Category` (Variable character with a max length of 50).**

    ```sql
    ALTER TABLE Products
    ADD Category VARCHAR(50);
    ```

25. **Drop the `Orders` table from the database.**

    ```sql
    DROP TABLE Orders;
    ```

26. **Rename the `Customers` table to `Clientele`.**

    ```sql
    EXEC sp_rename 'Customers', 'Clientele';
    ```

27. **Add a new column `MiddleName` (Variable character with a max length of 50) to the `Employees` table, and ensure it can accept null values.**

    ```sql
    ALTER TABLE Employees
    ADD MiddleName VARCHAR(50) NULL;
    ```

28. **Alter the `Orders` table to make the `OrderDate` column mandatory (not null).**

    ```sql
    ALTER TABLE Orders
    ALTER COLUMN OrderDate DATE NOT NULL;
    ```

29. **Create a unique constraint on the `EmailAddress` column in the `Clientele` table.**

    ```sql
    ALTER TABLE Clientele
    ADD CONSTRAINT UQ_Clientele_EmailAddress UNIQUE (EmailAddress);
    ```

30. **Drop the index on the `LastName` column of the `Employees` table.**

    ```sql
    DROP INDEX IX_Employees_LastName ON Employees;
    ```

### 4. **DML Operations**

31. **Insert a new record into the `Employees` table with the following details:**
    - `EmployeeID`: 101
    - `FirstName`: 'John'
    - `LastName`: 'Doe'
    - `BirthDate`: '1985-05-15'
    - `Salary`: 60000

    ```sql
    INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, Salary)
    VALUES (101, 'John', 'Doe', '1985-05-15', 60000);
    ```

32. **Update the `Salary` of the employee with `EmployeeID` 101 to $65,000.**

    ```sql
    UPDATE Employees
    SET Salary = 65000
    WHERE EmployeeID = 101;
    ```

33. **Delete the employee record from the `Employees` table where `EmployeeID` is 101.**

    ```sql
    DELETE FROM Employees
    WHERE EmployeeID = 101;
    ```

34. **Insert multiple records into the `Products` table with the following details:**
    - `ProductID`: 201, `ProductName`: 'Mountain Bike', `Price`: 1200.00, `StockQuantity`: 50
    - `ProductID`: 202, `ProductName`: 'Road Bike', `Price`: 1500.00, `StockQuantity`: 30

    ```sql
    INSERT INTO Products (ProductID, ProductName, Price, StockQuantity)
    VALUES
    (201, 'Mountain Bike', 1200.00, 50),
    (202, 'Road Bike', 1500.00, 30);
    ```

35. **Update the `Price` of all products in the `Products` table by increasing it by 10%.**

    ```sql
    UPDATE Products
    SET Price = Price * 1.10;
    ```

36. **Delete all products from the `Products` table where `StockQuantity` is 0.**

    ```sql
    DELETE FROM Products
    WHERE StockQuantity = 0;
    ```

37. **Insert a new order into the `Orders` table with the following details:**
    - `OrderID`: 301
    - `CustomerID`: 401
    - `OrderDate`: '2024-08-29'

    ```sql
    INSERT INTO Orders (OrderID, CustomerID, OrderDate)
    VALUES (301, 401, '2024-08-29');
    ```

38. **Update the `OrderDate` of the order with `OrderID` 301 to '2024-09-01'.**

    ```sql
    UPDATE Orders
    SET OrderDate = '2024-09-01'
    WHERE OrderID = 301;
    ```

39. **Delete the order from the `Orders` table where `OrderID` is 301.**

    ```sql
    DELETE FROM Orders
    WHERE OrderID = 301;
    ```

40. **Insert a new customer into the `Clientele` table with the following details:**
    - `CustomerID`: 501
    - `FullName`: 'Alice Smith'
    - `EmailAddress`: 'alice.smith@example.com'
    - `PhoneNumber`: '123-456-7890'

    ```sql
    INSERT INTO Clientele (CustomerID, FullName, EmailAddress, PhoneNumber)
    VALUES (501, 'Alice Smith', 'alice.smith@example.com', '123-456-7890');
    ```

### 5. **Advanced DDL/DML Operations**

41. **Create a table `Suppliers` with a foreign key constraint referencing the `Vendors` table.**

    ```sql
    CREATE TABLE Suppliers (
        SupplierID INT PRIMARY KEY,
        VendorID INT FOREIGN KEY REFERENCES Vendors(VendorID),
        SupplierName VARCHAR(100)
    );
    ```

42. **Insert data into the `Orders` table and simultaneously insert related records into the `OrderDetails` table using a transaction.**

    ```sql
    BEGIN TRANSACTION;

    INSERT INTO Orders (OrderID, CustomerID, OrderDate)
    VALUES (302, 402, '2024-08-30');

    INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity)
    VALUES (1, 302, 201, 2);

    COMMIT TRANSACTION;
    ```

43. **Alter the `Employees` table to drop the `MiddleName` column.**

    ```sql
    ALTER TABLE Employees
    DROP COLUMN MiddleName;
    ```

44. **Create a view `ActiveProducts` that lists all products from the `Products` table where `StockQuantity` is greater than 0.**

    ```sql
    CREATE VIEW ActiveProducts AS
    SELECT * FROM Products
    WHERE StockQuantity > 0;
    ```

45. **Create a stored procedure `spGetEmployeeByID` that takes an `EmployeeID` as a parameter and returns the corresponding employee's details.**

    ```sql
    CREATE PROCEDURE spGetEmployeeByID
        @EmployeeID INT
    AS
    BEGIN
        SELECT * FROM Employees
        WHERE EmployeeID = @EmployeeID;
    END;
    ```

46. **Create a trigger that automatically updates the `LastUpdated` column of a `Products` table whenever a product’s details are modified.**

    ```sql
    CREATE TRIGGER trgUpdateLastUpdated
    ON Products
    AFTER UPDATE
    AS
    BEGIN
        UPDATE Products
        SET LastUpdated = GETDATE()
        FROM Products
        INNER JOIN inserted ON Products.ProductID = inserted.ProductID;
    END;
    ```

47. **Write a query to transfer all products from the `OldProducts` table to the `Products` table and delete them from `OldProducts` afterwards.**

    ```sql
    BEGIN TRANSACTION;

    INSERT INTO Products (ProductID, ProductName, Price, StockQuantity)
    SELECT ProductID, ProductName, Price, StockQuantity
    FROM OldProducts;

    DELETE FROM OldProducts;

    COMMIT TRANSACTION;
    ```

48. **Create a function `fnCalculateDiscount` that calculates a discount on a product based on its price.**

    ```sql
    CREATE FUNCTION fnCalculateDiscount(@Price DECIMAL(10, 2), @DiscountRate DECIMAL(5, 2))
    RETURNS DECIMAL(10, 2)
    AS
    BEGIN
        RETURN @Price * (1 - @DiscountRate / 100);
    END;
    ```

49. **Use a CTE (Common Table Expression) to retrieve all employees who earn more than $50,000.**

    ```sql
    WITH HighEarners AS (
        SELECT * FROM Employees
        WHERE Salary > 50000
    )
    SELECT * FROM HighEarners;
    ```

50. **Create a sequence named `OrderNumberSeq` that starts from 1000 and increments by 1. Use this sequence to generate order numbers in the `Orders` table.**

    ```sql
    CREATE SEQUENCE OrderNumberSeq
    START WITH 1000
    INCREMENT BY 1;

    -- Example of using the sequence to insert an order
    INSERT INTO Orders (OrderID, CustomerID, OrderDate)
    VALUES (NEXT VALUE FOR OrderNumberSeq, 403, '2024-08-31');
    ```
