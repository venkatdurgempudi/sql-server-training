# SQL Server Assignment Solutions: SELECT Statements with LIKE, BETWEEN, IN, AND, OR, DISTINCT, and REGEX_LIKE

## Objective:
To practice writing SQL `SELECT` queries using various operators and clauses such as `LIKE`, `BETWEEN`, `IN`, `AND`, `OR`, `DISTINCT`, and `REGEX_LIKE` within the AdventureWorks database.

---

### 1. **LIKE Clause**

1. **Retrieve all products whose name starts with 'Mountain':**
    ```sql
    SELECT ProductID, Name
    FROM Production.Product
    WHERE Name LIKE 'Mountain%';
    ```

2. **Find all customers whose last name ends with 'son':**
    ```sql
    SELECT CustomerID, LastName
    FROM Person.Person
    WHERE LastName LIKE '%son';
    ```

3. **List all email addresses that contain 'adventure':**
    ```sql
    SELECT EmailAddress
    FROM Person.EmailAddress
    WHERE EmailAddress LIKE '%adventure%';
    ```

4. **Retrieve employees whose job title includes 'Manager':**
    ```sql
    SELECT BusinessEntityID, JobTitle
    FROM HumanResources.Employee
    WHERE JobTitle LIKE '%Manager%';
    ```

5. **Find vendors whose name contains the word 'Bike':**
    ```sql
    SELECT VendorID, Name
    FROM Purchasing.Vendor
    WHERE Name LIKE '%Bike%';
    ```

### 2. **BETWEEN Clause**

6. **List all products with a `ListPrice` between $500 and $1000:**
    ```sql
    SELECT ProductID, Name, ListPrice
    FROM Production.Product
    WHERE ListPrice BETWEEN 500 AND 1000;
    ```

7. **Retrieve all sales orders placed between January 1, 2020, and December 31, 2020:**
    ```sql
    SELECT SalesOrderID, OrderDate, TotalDue
    FROM Sales.SalesOrderHeader
    WHERE OrderDate BETWEEN '2020-01-01' AND '2020-12-31';
    ```

8. **Find employees hired between January 1, 2015, and January 1, 2020:**
    ```sql
    SELECT BusinessEntityID, JobTitle, HireDate
    FROM HumanResources.Employee
    WHERE HireDate BETWEEN '2015-01-01' AND '2020-01-01';
    ```

9. **List all purchase orders with a total due between $1000 and $5000:**
    ```sql
    SELECT PurchaseOrderID, OrderDate, TotalDue
    FROM Purchasing.PurchaseOrderHeader
    WHERE TotalDue BETWEEN 1000 AND 5000;
    ```

10. **Retrieve all customers with customer IDs between 10000 and 20000:**
    ```sql
    SELECT CustomerID, PersonID
    FROM Sales.Customer
    WHERE CustomerID BETWEEN 10000 AND 20000;
    ```

### 3. **IN Clause**

11. **Find all products in the 'Mountain-100' series:**
    ```sql
    SELECT ProductID, Name
    FROM Production.Product
    WHERE ProductNumber IN ('BK-M82S-38', 'BK-M82S-42', 'BK-M82S-44');
    ```

12. **List all customers who live in the states of 'CA', 'NY', and 'TX':**
    ```sql
    SELECT CustomerID, StateProvince
    FROM Person.Address
    WHERE StateProvince IN ('CA', 'NY', 'TX');
    ```

13. **Retrieve employees who have the job titles 'Sales Representative', 'Sales Manager', or 'Marketing Specialist':**
    ```sql
    SELECT BusinessEntityID, JobTitle
    FROM HumanResources.Employee
    WHERE JobTitle IN ('Sales Representative', 'Sales Manager', 'Marketing Specialist');
    ```

14. **Find vendors with credit ratings of 1, 2, or 3:**
    ```sql
    SELECT VendorID, Name, CreditRating
    FROM Purchasing.Vendor
    WHERE CreditRating IN (1, 2, 3);
    ```

15. **List all sales orders made by customers with IDs 11000, 12000, and 13000:**
    ```sql
    SELECT SalesOrderID, CustomerID, OrderDate
    FROM Sales.SalesOrderHeader
    WHERE CustomerID IN (11000, 12000, 13000);
    ```

### 4. **AND Clause**

16. **Retrieve products that have a `ListPrice` greater than $1000 and are in the 'Components' category:**
    ```sql
    SELECT ProductID, Name, ListPrice
    FROM Production.Product
    WHERE ListPrice > 1000 AND ProductSubcategoryID = (
        SELECT ProductSubcategoryID
        FROM Production.ProductSubcategory
        WHERE Name = 'Components'
    );
    ```

17. **Find customers who live in 'CA' and have a `PersonType` of 'IN':**
    ```sql
    SELECT CustomerID, PersonID
    FROM Sales.Customer c
    JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
    JOIN Person.Address a ON p.BusinessEntityID = a.AddressID
    WHERE a.StateProvince = 'CA' AND p.PersonType = 'IN';
    ```

18. **List employees who are female and have a hire date after January 1, 2010:**
    ```sql
    SELECT BusinessEntityID, JobTitle, Gender, HireDate
    FROM HumanResources.Employee
    WHERE Gender = 'F' AND HireDate > '2010-01-01';
    ```

19. **Retrieve sales orders with a `TotalDue` greater than $5000 and a `ShipDate` within the last 30 days:**
    ```sql
    SELECT SalesOrderID, OrderDate, ShipDate, TotalDue
    FROM Sales.SalesOrderHeader
    WHERE TotalDue > 5000 AND ShipDate >= DATEADD(DAY, -30, GETDATE());
    ```

20. **Find products that have a `StandardCost` between $200 and $500 and a `ListPrice` greater than $1000:**
    ```sql
    SELECT ProductID, Name, StandardCost, ListPrice
    FROM Production.Product
    WHERE StandardCost BETWEEN 200 AND 500 AND ListPrice > 1000;
    ```

### 5. **OR Clause**

21. **Find customers who live in 'WA' or 'OR':**
    ```sql
    SELECT CustomerID, StateProvince
    FROM Person.Address
    WHERE StateProvince IN ('WA', 'OR');
    ```

22. **Retrieve employees who have the job title 'Sales Representative' or 'Sales Manager':**
    ```sql
    SELECT BusinessEntityID, JobTitle
    FROM HumanResources.Employee
    WHERE JobTitle IN ('Sales Representative', 'Sales Manager');
    ```

23. **List products that are either in the 'Bikes' category or have a `ListPrice` greater than $2000:**
    ```sql
    SELECT ProductID, Name, ListPrice
    FROM Production.Product
    WHERE ProductSubcategoryID = (
        SELECT ProductSubcategoryID
        FROM Production.ProductSubcategory
        WHERE Name = 'Bikes'
    ) OR ListPrice > 2000;
    ```

24. **Find vendors with a credit rating of 4 or located in the 'Pacific' region:**
    ```sql
    SELECT VendorID, Name, CreditRating, PurchasingWebServiceURL
    FROM Purchasing.Vendor
    WHERE CreditRating = 4 OR PurchasingWebServiceURL LIKE '%pacific%';
    ```

25. **Retrieve sales orders with a `TotalDue` less than $1000 or placed in the year 2019:**
    ```sql
    SELECT SalesOrderID, OrderDate, TotalDue
    FROM Sales.SalesOrderHeader
    WHERE TotalDue < 1000 OR YEAR(OrderDate) = 2019;
    ```

### 6. **DISTINCT Clause**

26. **List all distinct job titles of employees:**
    ```sql
    SELECT DISTINCT JobTitle
    FROM HumanResources.Employee;
    ```

27. **Retrieve all distinct product categories:**
    ```sql
    SELECT DISTINCT Name
    FROM Production.ProductCategory;
    ```

28. **Find all distinct states where customers are located:**
    ```sql
    SELECT DISTINCT StateProvince
    FROM Person.Address;
    ```

29. **List all distinct sales territories:**
    ```sql
    SELECT DISTINCT Name
    FROM Sales.SalesTerritory;
    ```

30. **Retrieve all distinct product colors available:**
    ```sql
    SELECT DISTINCT Color
    FROM Production.Product
    WHERE Color IS NOT NULL;
    ```

### 7. **Combining LIKE with AND/OR**

31. **Retrieve products whose name starts with 'Touring' and ends with 'Bike':**
    ```sql
    SELECT ProductID, Name
    FROM Production.Product
    WHERE Name LIKE 'Touring%' AND Name LIKE '%Bike';
    ```

32. **Find customers whose first name starts with 'J' and last name ends with 'son':**
    ```sql
    SELECT CustomerID, FirstName, LastName
    FROM Person.Person
    WHERE FirstName LIKE 'J%' AND LastName LIKE '%son';
    ```

33. **List employees whose job

 title contains 'Engineer' or 'Manager':**
    ```sql
    SELECT BusinessEntityID, JobTitle
    FROM HumanResources.Employee
    WHERE JobTitle LIKE '%Engineer%' OR JobTitle LIKE '%Manager%';
    ```

34. **Retrieve vendors whose name contains 'Parts' and is located in 'Canada':**
    ```sql
    SELECT VendorID, Name
    FROM Purchasing.Vendor
    WHERE Name LIKE '%Parts%' AND PurchasingWebServiceURL LIKE '%Canada%';
    ```

35. **Find products whose `ProductNumber` starts with 'BK' and ends with '00':**
    ```sql
    SELECT ProductID, Name, ProductNumber
    FROM Production.Product
    WHERE ProductNumber LIKE 'BK%00';
    ```

### 8. **Combining BETWEEN with AND/OR**

36. **Retrieve sales orders placed between January 1, 2018, and December 31, 2018, and have a `TotalDue` greater than $5000:**
    ```sql
    SELECT SalesOrderID, OrderDate, TotalDue
    FROM Sales.SalesOrderHeader
    WHERE OrderDate BETWEEN '2018-01-01' AND '2018-12-31' AND TotalDue > 5000;
    ```

37. **Find products with a `ListPrice` between $1000 and $2000 or a `StandardCost` between $500 and $1000:**
    ```sql
    SELECT ProductID, Name, ListPrice, StandardCost
    FROM Production.Product
    WHERE ListPrice BETWEEN 1000 AND 2000 OR StandardCost BETWEEN 500 AND 1000;
    ```

38. **List employees hired between January 1, 2010, and January 1, 2015, or whose job title contains 'Manager':**
    ```sql
    SELECT BusinessEntityID, JobTitle, HireDate
    FROM HumanResources.Employee
    WHERE HireDate BETWEEN '2010-01-01' AND '2015-01-01' OR JobTitle LIKE '%Manager%';
    ```

39. **Retrieve purchase orders placed between January 1, 2020, and December 31, 2020, and with a `Freight` cost greater than $100:**
    ```sql
    SELECT PurchaseOrderID, OrderDate, Freight
    FROM Purchasing.PurchaseOrderHeader
    WHERE OrderDate BETWEEN '2020-01-01' AND '2020-12-31' AND Freight > 100;
    ```

40. **Find customers with customer IDs between 10000 and 15000 or live in the state of 'FL':**
    ```sql
    SELECT CustomerID, PersonID
    FROM Sales.Customer c
    JOIN Person.Address a ON c.TerritoryID = a.AddressID
    WHERE CustomerID BETWEEN 10000 AND 15000 OR a.StateProvince = 'FL';
    ```

### 9. **Combining IN with AND/OR**

41. **Retrieve products in the 'Touring-3000', 'Mountain-1000', or 'Road-1500' series and have a `ListPrice` greater than $1000:**
    ```sql
    SELECT ProductID, Name, ListPrice
    FROM Production.Product
    WHERE ProductNumber IN ('BK-T79U-44', 'BK-M98B-48', 'BK-R29B-52') AND ListPrice > 1000;
    ```

42. **Find customers who live in 'TX', 'FL', or 'NY' and have a `PersonType` of 'IN':**
    ```sql
    SELECT CustomerID, PersonID
    FROM Sales.Customer c
    JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
    JOIN Person.Address a ON p.BusinessEntityID = a.AddressID
    WHERE a.StateProvince IN ('TX', 'FL', 'NY') AND p.PersonType = 'IN';
    ```

43. **List employees who have the job titles 'Production Technician', 'Quality Assurance', or 'Maintenance Technician' and were hired after January 1, 2015:**
    ```sql
    SELECT BusinessEntityID, JobTitle, HireDate
    FROM HumanResources.Employee
    WHERE JobTitle IN ('Production Technician', 'Quality Assurance', 'Maintenance Technician') AND HireDate > '2015-01-01';
    ```

44. **Retrieve sales orders made by customers with IDs 11000, 12000, or 13000 and placed within the last 60 days:**
    ```sql
    SELECT SalesOrderID, CustomerID, OrderDate
    FROM Sales.SalesOrderHeader
    WHERE CustomerID IN (11000, 12000, 13000) AND OrderDate >= DATEADD(DAY, -60, GETDATE());
    ```

45. **Find vendors with credit ratings of 2, 3, or 4 and located in 'Europe' or 'Asia':**
    ```sql
    SELECT VendorID, Name, CreditRating, PurchasingWebServiceURL
    FROM Purchasing.Vendor
    WHERE CreditRating IN (2, 3, 4) AND (PurchasingWebServiceURL LIKE '%Europe%' OR PurchasingWebServiceURL LIKE '%Asia%');
    ```

### 10. **REGEX_LIKE Clause**

46. **Find products whose `Name` contains only letters and numbers (no special characters):**
    ```sql
    SELECT ProductID, Name
    FROM Production.Product
    WHERE Name NOT LIKE '%[^a-zA-Z0-9]%';
    ```

47. **Retrieve customers whose `EmailAddress` follows the format 'firstname.lastname@domain.com':**
    ```sql
    SELECT EmailAddress
    FROM Person.EmailAddress
    WHERE EmailAddress LIKE '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}';
    ```

48. **List employees whose `PhoneNumber` matches the format '(XXX) XXX-XXXX':**
    ```sql
    SELECT PhoneNumber
    FROM Person.PersonPhone
    WHERE PhoneNumber LIKE '\([0-9]{3}\) [0-9]{3}-[0-9]{4}';
    ```

49. **Find vendors whose `AccountNumber` starts with '1' and contains exactly 10 digits:**
    ```sql
    SELECT VendorID, Name, AccountNumber
    FROM Purchasing.Vendor
    WHERE AccountNumber LIKE '1[0-9]{9}';
    ```

50. **Retrieve products whose `ProductNumber` starts with two letters followed by three digits:**
    ```sql
    SELECT ProductID, Name, ProductNumber
    FROM Production.Product
    WHERE ProductNumber LIKE '[A-Za-z]{2}[0-9]{3}%';
    ```

---

## Notes:
- Some SQL Server versions may not support `REGEX_LIKE`. If it is not supported, consider using `LIKE` with character classes or regular expressions in a different context or via other SQL-based methods.
- Always test your queries against the AdventureWorks2019 database to ensure they produce the correct results.
