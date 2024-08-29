### **Solutions:**

#### **1. Basic Queries:**
1. **List of all products:**
   ```sql
   SELECT ProductID, Name, ProductNumber, ListPrice
   FROM Production.Product;
   ```

2. **List all employees:**
   ```sql
   SELECT BusinessEntityID AS EmployeeID, JobTitle, HireDate
   FROM HumanResources.Employee;
   ```

3. **Display all customers:**
   ```sql
   SELECT CustomerID, p.FirstName, p.LastName, e.EmailAddress
   FROM Sales.Customer c
   JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
   JOIN Person.EmailAddress e ON p.BusinessEntityID = e.BusinessEntityID;
   ```

4. **Find all vendors:**
   ```sql
   SELECT VendorID, Name, CreditRating
   FROM Purchasing.Vendor;
   ```

5. **Show all sales territories:**
   ```sql
   SELECT TerritoryID, Name, CountryRegionCode
   FROM Sales.SalesTerritory;
   ```

#### **2. Filtering and Sorting:**
6. **Products with a `ListPrice` greater than $1000:**
   ```sql
   SELECT ProductID, Name, ListPrice
   FROM Production.Product
   WHERE ListPrice > 1000;
   ```

7. **Employees hired after January 1, 2010:**
   ```sql
   SELECT BusinessEntityID AS EmployeeID, JobTitle, HireDate
   FROM HumanResources.Employee
   WHERE HireDate > '2010-01-01';
   ```

8. **Customers whose `LastName` starts with 'S':**
   ```sql
   SELECT CustomerID, p.FirstName, p.LastName
   FROM Sales.Customer c
   JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
   WHERE p.LastName LIKE 'S%';
   ```

9. **Vendors with a `CreditRating` of 1 or 2, ordered by `Name`:**
   ```sql
   SELECT VendorID, Name, CreditRating
   FROM Purchasing.Vendor
   WHERE CreditRating IN (1, 2)
   ORDER BY Name;
   ```

10. **Sales territories in the United States, ordered by `Name`:**
    ```sql
    SELECT TerritoryID, Name, CountryRegionCode
    FROM Sales.SalesTerritory
    WHERE CountryRegionCode = 'US'
    ORDER BY Name;
    ```

#### **3. Aggregate Functions:**
11. **Average `ListPrice` of all products:**
    ```sql
    SELECT AVG(ListPrice) AS AveragePrice
    FROM Production.Product;
    ```

12. **Total number of sales orders placed:**
    ```sql
    SELECT COUNT(*) AS TotalOrders
    FROM Sales.SalesOrderHeader;
    ```

13. **Maximum `TotalDue` for any single sales order:**
    ```sql
    SELECT MAX(TotalDue) AS MaxTotalDue
    FROM Sales.SalesOrderHeader;
    ```

14. **Sum of all `ListPrice` values for products in the "Bike" category:**
    ```sql
    SELECT SUM(ListPrice) AS TotalListPrice
    FROM Production.Product p
    JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
    WHERE pc.Name = 'Bikes';
    ```

15. **Count the number of employees with a `JobTitle` of 'Sales Representative':**
    ```sql
    SELECT COUNT(*) AS SalesRepCount
    FROM HumanResources.Employee
    WHERE JobTitle = 'Sales Representative';
    ```

#### **4. Grouping and Aggregation:**
16. **Group products by `ProductSubcategoryID` and find the average `ListPrice`:**
    ```sql
    SELECT ProductSubcategoryID, AVG(ListPrice) AS AvgListPrice
    FROM Production.Product
    GROUP BY ProductSubcategoryID;
    ```

17. **Group employees by `JobTitle` and count the number of employees in each title:**
    ```sql
    SELECT JobTitle, COUNT(*) AS EmployeeCount
    FROM HumanResources.Employee
    GROUP BY JobTitle;
    ```

18. **Total `TotalDue` for each customer, grouped by `CustomerID`:**
    ```sql
    SELECT CustomerID, SUM(TotalDue) AS TotalDueSum
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID;
    ```

19. **Group sales orders by `TerritoryID` and sum `TotalDue`:**
    ```sql
    SELECT TerritoryID, SUM(TotalDue) AS TotalDueSum
    FROM Sales.SalesOrderHeader
    GROUP BY TerritoryID;
    ```

20. **Number of products in each product category:**
    ```sql
    SELECT pc.Name AS CategoryName, COUNT(*) AS ProductCount
    FROM Production.Product p
    JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
    GROUP BY pc.Name;
    ```

#### **5. Joining Tables:**
21. **List of sales orders with customer’s `FirstName` and `LastName`:**
    ```sql
    SELECT soh.SalesOrderID, soh.OrderDate, p.FirstName, p.LastName
    FROM Sales.SalesOrderHeader soh
    JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
    JOIN Person.Person p ON c.PersonID = p.BusinessEntityID;
    ```

22. **List all employees with their department names:**
    ```sql
    SELECT e.BusinessEntityID AS EmployeeID, e.JobTitle, d.Name AS DepartmentName
    FROM HumanResources.Employee e
    JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
    JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
    WHERE edh.EndDate IS NULL;
    ```

23. **Find all products with their subcategory and category names:**
    ```sql
    SELECT p.ProductID, p.Name AS ProductName, ps.Name AS SubcategoryName, pc.Name AS CategoryName
    FROM Production.Product p
    JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID;
    ```

24. **Display purchase orders with vendor names:**
    ```sql
    SELECT po.PurchaseOrderID, po.OrderDate, v.Name AS VendorName
    FROM Purchasing.PurchaseOrderHeader po
    JOIN Purchasing.Vendor v ON po.VendorID = v.VendorID;
    ```

25. **List all products and their associated vendors:**
    ```sql
    SELECT p.ProductID, p.Name AS ProductName, v.Name AS VendorName
    FROM Production.Product p
    JOIN Purchasing.ProductVendor pv ON p.ProductID = pv.ProductID
    JOIN Purchasing.Vendor v ON pv.BusinessEntityID = v.BusinessEntityID;
    ```

#### **6. Advanced Joins:**
26. **Customers who have never placed a sales order:**
    ```sql
    SELECT c.CustomerID, p.FirstName, p.LastName
    FROM Sales.Customer c
    JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
    LEFT JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
    WHERE soh.SalesOrderID IS NULL;
    ```

27. **Products that have never been sold:**
    ```sql
    SELECT p.ProductID, p.Name AS ProductName
    FROM Production.Product p
    LEFT JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
    WHERE sod.SalesOrderID IS NULL;
    ```

28. **Employees without any department history:**
    ```sql
    SELECT e.BusinessEntityID AS EmployeeID, e.JobTitle
    FROM HumanResources.Employee e
    LEFT JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
    WHERE edh.BusinessEntityID IS NULL;
    ```

29. **Vendors who have never supplied any products:**
    ```sql
    SELECT v.VendorID, v.Name AS VendorName
    FROM Purchasing.Vendor v
    LEFT JOIN Purchasing.ProductVendor pv ON v.BusinessEntityID = pv.BusinessEntityID
    WHERE pv.ProductID IS NULL;
    ```

30. **Sales territories without any sales representatives assigned:**
    ```sql
    SELECT st.TerritoryID, st.Name AS TerritoryName
    FROM Sales.SalesTerritory st
    LEFT JOIN Sales.SalesPerson sp ON st.TerritoryID = sp.TerritoryID
    WHERE sp.BusinessEntityID IS NULL;
    ```

#### **7. Subqueries:**
31. **Product with the highest `ListPrice`:**
    ```sql
    SELECT ProductID, Name, ListPrice
    FROM Production.Product
    WHERE ListPrice = (SELECT MAX(ListPrice) FROM Production.Product);
    ```

32. **Employee with the earliest `HireDate`:**
    ```sql
    SELECT BusinessEntityID AS EmployeeID, JobTitle, HireDate
    FROM HumanResources.Employee
    WHERE HireDate = (SELECT MIN(HireDate) FROM HumanResources.Employee);
    ```

33. **Customers who have placed more than 10 orders:**
    ```sql
   

 SELECT c.CustomerID, p.FirstName, p.LastName, COUNT(soh.SalesOrderID) AS OrderCount
    FROM Sales.Customer c
    JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
    JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
    GROUP BY c.CustomerID, p.FirstName, p.LastName
    HAVING COUNT(soh.SalesOrderID) > 10;
    ```

34. **Products more expensive than the average `ListPrice`:**
    ```sql
    SELECT ProductID, Name, ListPrice
    FROM Production.Product
    WHERE ListPrice > (SELECT AVG(ListPrice) FROM Production.Product);
    ```

35. **Employees earning more than the average salary in their department:**
    ```sql
    SELECT e.BusinessEntityID AS EmployeeID, p.FirstName, p.LastName, s.Rate AS SalaryRate
    FROM HumanResources.Employee e
    JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
    JOIN HumanResources.EmployeePayHistory s ON e.BusinessEntityID = s.BusinessEntityID
    JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
    WHERE s.Rate > (SELECT AVG(s2.Rate)
                    FROM HumanResources.EmployeePayHistory s2
                    JOIN HumanResources.EmployeeDepartmentHistory edh2 ON s2.BusinessEntityID = edh2.BusinessEntityID
                    WHERE edh2.DepartmentID = edh.DepartmentID);
    ```

#### **8. Complex Queries:**
36. **Top 10 products by `ListPrice`:**
    ```sql
    SELECT TOP 10 ProductID, Name, ListPrice
    FROM Production.Product
    ORDER BY ListPrice DESC;
    ```

37. **Top 5 customers by total `TotalDue`:**
    ```sql
    SELECT TOP 5 c.CustomerID, p.FirstName, p.LastName, SUM(soh.TotalDue) AS TotalDueSum
    FROM Sales.Customer c
    JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
    JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
    GROUP BY c.CustomerID, p.FirstName, p.LastName
    ORDER BY TotalDueSum DESC;
    ```

38. **Top 3 most popular products by the number of times they were sold:**
    ```sql
    SELECT TOP 3 p.ProductID, p.Name AS ProductName, COUNT(sod.SalesOrderID) AS SalesCount
    FROM Production.Product p
    JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
    GROUP BY p.ProductID, p.Name
    ORDER BY SalesCount DESC;
    ```

39. **Top 5 employees with the most sales:**
    ```sql
    SELECT TOP 5 e.BusinessEntityID AS EmployeeID, p.FirstName, p.LastName, COUNT(soh.SalesOrderID) AS SalesCount
    FROM HumanResources.Employee e
    JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
    JOIN Sales.SalesOrderHeader soh ON e.BusinessEntityID = soh.SalesPersonID
    GROUP BY e.BusinessEntityID, p.FirstName, p.LastName
    ORDER BY SalesCount DESC;
    ```

40. **Top 3 vendors by the total number of products supplied:**
    ```sql
    SELECT TOP 3 v.VendorID, v.Name AS VendorName, COUNT(pv.ProductID) AS ProductCount
    FROM Purchasing.Vendor v
    JOIN Purchasing.ProductVendor pv ON v.BusinessEntityID = pv.BusinessEntityID
    GROUP BY v.VendorID, v.Name
    ORDER BY ProductCount DESC;
    ```

#### **9. Date and Time Functions:**
41. **Sales orders placed in the last 30 days:**
    ```sql
    SELECT SalesOrderID, OrderDate, TotalDue
    FROM Sales.SalesOrderHeader
    WHERE OrderDate >= DATEADD(DAY, -30, GETDATE());
    ```

42. **Employees hired in the last year:**
    ```sql
    SELECT BusinessEntityID AS EmployeeID, JobTitle, HireDate
    FROM HumanResources.Employee
    WHERE HireDate >= DATEADD(YEAR, -1, GETDATE());
    ```

43. **Products added to the database in the last 6 months:**
    ```sql
    SELECT ProductID, Name, SellStartDate
    FROM Production.Product
    WHERE SellStartDate >= DATEADD(MONTH, -6, GETDATE());
    ```

44. **Purchase orders placed in the current year:**
    ```sql
    SELECT PurchaseOrderID, OrderDate, TotalDue
    FROM Purchasing.PurchaseOrderHeader
    WHERE YEAR(OrderDate) = YEAR(GETDATE());
    ```

45. **Customers who made a purchase in the last 90 days:**
    ```sql
    SELECT DISTINCT c.CustomerID, p.FirstName, p.LastName
    FROM Sales.Customer c
    JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
    JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
    WHERE soh.OrderDate >= DATEADD(DAY, -90, GETDATE());
    ```

#### **10. String Functions:**
46. **Products with the `Name` in uppercase:**
    ```sql
    SELECT ProductID, UPPER(Name) AS ProductName
    FROM Production.Product;
    ```

47. **Customers whose `EmailAddress` ends with 'adventure-works.com':**
    ```sql
    SELECT CustomerID, p.FirstName, p.LastName, e.EmailAddress
    FROM Sales.Customer c
    JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
    JOIN Person.EmailAddress e ON p.BusinessEntityID = e.BusinessEntityID
    WHERE e.EmailAddress LIKE '%adventure-works.com';
    ```

48. **Employees whose `FirstName` contains the letter 'A':**
    ```sql
    SELECT BusinessEntityID AS EmployeeID, FirstName, LastName
    FROM Person.Person
    WHERE FirstName LIKE '%A%';
    ```

49. **First 5 characters of each product’s `ProductNumber`:**
    ```sql
    SELECT ProductID, Name, LEFT(ProductNumber, 5) AS ProductCode
    FROM Production.Product;
    ```

50. **Concatenate `FirstName` and `LastName` of all employees into a single column called `FullName`:**
    ```sql
    SELECT BusinessEntityID AS EmployeeID, FirstName + ' ' + LastName AS FullName
    FROM Person.Person;
    ```
