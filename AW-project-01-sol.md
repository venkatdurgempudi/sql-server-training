### 1. **Sales Performance Analysis**

**Objective:** Analyze the sales data to understand trends, performance metrics, and profitability.

**Tasks and Solutions:**

**Task 1:** Calculate the total sales amount for each year, grouped by product category.
```sql
SELECT YEAR(soh.OrderDate) AS SalesYear, pc.Name AS ProductCategory, SUM(sod.LineTotal) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
GROUP BY YEAR(soh.OrderDate), pc.Name
ORDER BY SalesYear, ProductCategory;
```
**Explanation:** This query calculates the total sales amount for each year, grouped by product category. It joins the necessary tables to gather the product and sales information.

---

**Task 2:** Determine the top 5 products by sales volume for the year 2023.
```sql
SELECT TOP 5 p.Name AS ProductName, SUM(sod.OrderQty) AS TotalQuantity
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
WHERE YEAR(soh.OrderDate) = 2023
GROUP BY p.Name
ORDER BY TotalQuantity DESC;
```
**Explanation:** This query finds the top 5 products by sales volume (quantity) for the year 2023.

---

**Task 3:** Identify the salesperson with the highest total sales in 2023.
```sql
SELECT TOP 1 sp.BusinessEntityID, e.FirstName, e.LastName, SUM(sod.LineTotal) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Sales.SalesPerson sp ON soh.SalesPersonID = sp.BusinessEntityID
JOIN Person.Person e ON sp.BusinessEntityID = e.BusinessEntityID
WHERE YEAR(soh.OrderDate) = 2023
GROUP BY sp.BusinessEntityID, e.FirstName, e.LastName
ORDER BY TotalSales DESC;
```
**Explanation:** This query identifies the salesperson with the highest total sales in 2023.

---

**Task 4:** Analyze the sales trends by quarter for a specific product category (e.g., Bikes).
```sql
SELECT DATEPART(QUARTER, soh.OrderDate) AS Quarter, SUM(sod.LineTotal) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
WHERE pc.Name = 'Bikes' AND YEAR(soh.OrderDate) = 2023
GROUP BY DATEPART(QUARTER, soh.OrderDate)
ORDER BY Quarter;
```
**Explanation:** This query analyzes the sales trends by quarter for the "Bikes" product category in 2023.

---

**Task 5:** Create a report that shows the monthly sales performance of each region.
```sql
SELECT YEAR(soh.OrderDate) AS SalesYear, MONTH(soh.OrderDate) AS SalesMonth, 
    st.Name AS Territory, SUM(sod.LineTotal) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID
GROUP BY YEAR(soh.OrderDate), MONTH(soh.OrderDate), st.Name
ORDER BY SalesYear, SalesMonth, Territory;
```
**Explanation:** This query generates a report showing the monthly sales performance for each sales territory.

---

### 2. **Customer Insights and Segmentation**

**Objective:** Segment customers based on their purchasing behavior and identify key customer groups.

**Tasks and Solutions:**

**Task 1:** Identify customers who made purchases in the last 12 months.
```sql
SELECT DISTINCT c.CustomerID, p.FirstName, p.LastName
FROM Sales.SalesOrderHeader soh
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
WHERE soh.OrderDate >= DATEADD(YEAR, -1, GETDATE());
```
**Explanation:** This query identifies customers who have made purchases within the last 12 months.

---

**Task 2:** Segment customers into high, medium, and low spenders based on their total purchase amounts.
```sql
WITH CustomerSpending AS
(
    SELECT c.CustomerID, p.FirstName, p.LastName, SUM(sod.LineTotal) AS TotalSpent
    FROM Sales.SalesOrderHeader soh
    JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
    JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
    JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
    GROUP BY c.CustomerID, p.FirstName, p.LastName
)
SELECT CustomerID, FirstName, LastName, TotalSpent,
    CASE
        WHEN TotalSpent > 10000 THEN 'High Spender'
        WHEN TotalSpent BETWEEN 5000 AND 10000 THEN 'Medium Spender'
        ELSE 'Low Spender'
    END AS SpendingCategory
FROM CustomerSpending;
```
**Explanation:** This query segments customers into high, medium, and low spenders based on their total spending.

---

**Task 3:** Analyze the geographical distribution of high-spending customers.
```sql
WITH HighSpenders AS
(
    SELECT c.CustomerID, SUM(sod.LineTotal) AS TotalSpent
    FROM Sales.SalesOrderHeader soh
    JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
    JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
    GROUP BY c.CustomerID
    HAVING SUM(sod.LineTotal) > 10000
)
SELECT st.Name AS Territory, COUNT(HighSpenders.CustomerID) AS HighSpenderCount
FROM HighSpenders
JOIN Sales.Customer c ON HighSpenders.CustomerID = c.CustomerID
JOIN Sales.SalesTerritory st ON c.TerritoryID = st.TerritoryID
GROUP BY st.Name
ORDER BY HighSpenderCount DESC;
```
**Explanation:** This query analyzes the geographical distribution of high-spending customers across sales territories.

---

**Task 4:** Identify customers who have not made a purchase in the last two years.
```sql
SELECT DISTINCT c.CustomerID, p.FirstName, p.LastName
FROM Sales.Customer c
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
LEFT JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
WHERE soh.OrderDate < DATEADD(YEAR, -2, GETDATE()) OR soh.OrderDate IS NULL;
```
**Explanation:** This query identifies customers who have not made any purchases in the last two years.

---

**Task 5:** List customers who have purchased more than three different product categories.
```sql
WITH CustomerCategoryCount AS
(
    SELECT c.CustomerID, COUNT(DISTINCT pc.ProductCategoryID) AS CategoryCount
    FROM Sales.SalesOrderHeader soh
    JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
    JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
    JOIN Production.Product p ON sod.ProductID = p.ProductID
    JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
    JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
    GROUP BY c.CustomerID
)
SELECT c.CustomerID, p.FirstName, p.LastName, CategoryCount
FROM CustomerCategoryCount ccc
JOIN Sales.Customer c ON ccc.CustomerID = c.CustomerID
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
WHERE CategoryCount > 3;
```
**Explanation:** This query lists customers who have purchased products from more than three different product categories.

---

### 3. **Product Inventory Management**

**Objective:** Manage and optimize the product inventory levels to minimize costs and avoid stockouts.

**Tasks and Solutions:**

**Task 1:** List products that have had stockouts in the last 6 months.
```sql
SELECT p.ProductID, p.Name, SUM(ish.Quantity) AS TotalShipped
FROM Production.Product p
JOIN Production.ProductInventory pi ON p.ProductID = pi.ProductID
JOIN Production.TransactionHistory th ON p.ProductID = th.ProductID
JOIN Production.ProductInventoryHistory ish ON pi.ProductID = ish.ProductID
WHERE th.TransactionDate >= DATEADD(MONTH, -6, GETDATE()) AND pi.Quantity = 0
GROUP BY p.ProductID, p.Name
ORDER BY TotalShipped DESC;
```
**Explanation:** This query lists products that have experienced stockouts in the last six months.

---

**Task 2:** Determine the average inventory levels for each product over the past year.
```sql
SELECT p.ProductID, p.Name, AVG(pi.Quantity) AS AvgInventoryLevel
FROM

 Production.Product p
JOIN Production.ProductInventory pi ON p.ProductID = pi.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY AvgInventoryLevel DESC;
```
**Explanation:** This query calculates the average inventory level for each product over the past year.

---

**Task 3:** Identify products with high inventory turnover rates.
```sql
WITH InventoryTurnover AS
(
    SELECT p.ProductID, p.Name, SUM(sod.OrderQty) AS TotalSold, AVG(pi.Quantity) AS AvgInventory
    FROM Production.Product p
    JOIN Production.ProductInventory pi ON p.ProductID = pi.ProductID
    JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
    GROUP BY p.ProductID, p.Name
)
SELECT ProductID, Name, TotalSold, AvgInventory, 
       CASE WHEN AvgInventory = 0 THEN 0 ELSE TotalSold / AvgInventory END AS TurnoverRate
FROM InventoryTurnover
ORDER BY TurnoverRate DESC;
```
**Explanation:** This query identifies products with high inventory turnover rates by comparing total sales to average inventory.

---

**Task 4:** Report showing the reorder points for products based on historical sales data.
```sql
WITH SalesHistory AS
(
    SELECT p.ProductID, p.Name, SUM(sod.OrderQty) AS TotalSales
    FROM Production.Product p
    JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
    GROUP BY p.ProductID, p.Name
)
SELECT p.ProductID, p.Name, TotalSales / 12 AS AvgMonthlySales, pi.SafetyStockLevel,
       CASE WHEN pi.SafetyStockLevel > 0 THEN pi.SafetyStockLevel ELSE TotalSales / 12 * 2 END AS ReorderPoint
FROM SalesHistory sh
JOIN Production.ProductInventory pi ON sh.ProductID = pi.ProductID;
```
**Explanation:** This query calculates reorder points for products based on historical sales data and safety stock levels.

---

**Task 5:** Propose an inventory optimization strategy.
- **Solution:** Based on the data analysis, propose strategies such as:
  - Implementing Just-In-Time (JIT) inventory for high turnover products.
  - Increasing safety stock levels for products with frequent stockouts.
  - Regularly reviewing reorder points based on updated sales trends.
  - Using automated tools to monitor inventory levels and trigger reorders when needed.

---

### 4. **Employee Performance and Compensation**

**Objective:** Evaluate employee performance and design a compensation model based on performance metrics.

**Tasks and Solutions:**

**Task 1:** Calculate the total sales generated by each employee.
```sql
SELECT sp.BusinessEntityID, e.FirstName, e.LastName, SUM(sod.LineTotal) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Sales.SalesPerson sp ON soh.SalesPersonID = sp.BusinessEntityID
JOIN Person.Person e ON sp.BusinessEntityID = e.BusinessEntityID
GROUP BY sp.BusinessEntityID, e.FirstName, e.LastName
ORDER BY TotalSales DESC;
```
**Explanation:** This query calculates the total sales generated by each salesperson.

---

**Task 2:** Identify the top 10% of employees by sales performance.
```sql
WITH SalesPerformance AS
(
    SELECT sp.BusinessEntityID, e.FirstName, e.LastName, SUM(sod.LineTotal) AS TotalSales,
           NTILE(10) OVER (ORDER BY SUM(sod.LineTotal) DESC) AS SalesDecile
    FROM Sales.SalesOrderHeader soh
    JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
    JOIN Sales.SalesPerson sp ON soh.SalesPersonID = sp.BusinessEntityID
    JOIN Person.Person e ON sp.BusinessEntityID = e.BusinessEntityID
    GROUP BY sp.BusinessEntityID, e.FirstName, e.LastName
)
SELECT BusinessEntityID, FirstName, LastName, TotalSales
FROM SalesPerformance
WHERE SalesDecile = 1
ORDER BY TotalSales DESC;
```
**Explanation:** This query identifies the top 10% of employees by sales performance using the `NTILE` function.

---

**Task 3:** Analyze the correlation between employee tenure and sales performance.
```sql
SELECT sp.BusinessEntityID, e.FirstName, e.LastName, DATEDIFF(YEAR, e.HireDate, GETDATE()) AS Tenure, 
       SUM(sod.LineTotal) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Sales.SalesPerson sp ON soh.SalesPersonID = sp.BusinessEntityID
JOIN HumanResources.Employee e ON sp.BusinessEntityID = e.BusinessEntityID
GROUP BY sp.BusinessEntityID, e.FirstName, e.LastName, e.HireDate
ORDER BY Tenure DESC;
```
**Explanation:** This query analyzes the correlation between employee tenure (years with the company) and sales performance.

---

**Task 4:** Propose a bonus structure based on employee performance metrics.
- **Solution:** Based on the sales data, propose a tiered bonus structure:
  - **Top 10%:** 20% of base salary as a bonus.
  - **Next 20%:** 15% of base salary as a bonus.
  - **Middle 50%:** 10% of base salary as a bonus.
  - **Bottom 20%:** 5% of base salary as a bonus.

---

**Task 5:** Create a report summarizing the performance of each department.
```sql
SELECT d.Name AS Department, SUM(sod.LineTotal) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Sales.SalesPerson sp ON soh.SalesPersonID = sp.BusinessEntityID
JOIN HumanResources.Employee e ON sp.BusinessEntityID = e.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
GROUP BY d.Name
ORDER BY TotalSales DESC;
```
**Explanation:** This query summarizes the performance of each department based on total sales generated by employees in those departments.

---

### 5. **Supply Chain and Vendor Analysis**

**Objective:** Evaluate vendor performance and optimize the supply chain operations.

**Tasks and Solutions:**

**Task 1:** Calculate the total number of products supplied by each vendor.
```sql
SELECT v.BusinessEntityID, p.Name AS VendorName, COUNT(DISTINCT p.ProductID) AS TotalProducts
FROM Purchasing.PurchaseOrderDetail pod
JOIN Purchasing.ProductVendor pv ON pod.ProductID = pv.ProductID
JOIN Purchasing.Vendor v ON pv.BusinessEntityID = v.BusinessEntityID
GROUP BY v.BusinessEntityID, p.Name
ORDER BY TotalProducts DESC;
```
**Explanation:** This query calculates the total number of distinct products supplied by each vendor.

---

**Task 2:** Identify vendors with the highest average lead time for deliveries.
```sql
SELECT v.BusinessEntityID, v.Name AS VendorName, AVG(pv.LeadTime) AS AvgLeadTime
FROM Purchasing.ProductVendor pv
JOIN Purchasing.Vendor v ON pv.BusinessEntityID = v.BusinessEntityID
GROUP BY v.BusinessEntityID, v.Name
ORDER BY AvgLeadTime DESC;
```
**Explanation:** This query identifies vendors with the highest average lead time for product deliveries.

---

**Task 3:** Analyze the cost trends of key raw materials over the past 3 years.
```sql
SELECT YEAR(po.OrderDate) AS Year, pm.Name AS MaterialName, AVG(pod.UnitPrice) AS AvgPrice
FROM Purchasing.PurchaseOrderHeader po
JOIN Purchasing.PurchaseOrderDetail pod ON po.PurchaseOrderID = pod.PurchaseOrderID
JOIN Production.Product p ON pod.ProductID = p.ProductID
JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
WHERE pc.Name = 'Components' -- Assume Components as raw materials
GROUP BY YEAR(po.OrderDate), pm.Name
ORDER BY Year, MaterialName;
```
**Explanation:** This query analyzes the cost trends of key raw materials (assumed to be "Components") over the past three years.

---

**Task 4:** Determine the percentage of defective products received from each vendor.
```sql
SELECT v.BusinessEntityID, v.Name AS VendorName, 
       SUM(CASE WHEN ish.TransactionType = 'RM' THEN 1 ELSE 0 END) * 100.0 / COUNT(ish.TransactionType) AS DefectivePercentage
FROM Purchasing.ProductVendor pv
JOIN Purchasing.Vendor v ON pv.BusinessEntityID = v.BusinessEntityID
JOIN Production.ProductInventoryHistory ish ON pv.ProductID = ish.ProductID
WHERE ish.TransactionType IN ('RC', 'RM')
GROUP BY v.BusinessEntityID, v.Name
ORDER BY DefectivePercentage DESC;
```
**Explanation:** This query calculates the percentage of defective products received from each vendor based on inventory transactions.

---

**Task 5:** Propose a strategy for vendor management and supply chain optimization.
- **Solution:** Based on the data analysis, propose strategies such as:
  - Prioritizing vendors with lower lead times and fewer defective products.
  - Establishing long-term contracts with high-performing vendors.
  - Implementing regular performance reviews and feedback loops with vendors.
  - Using a dual-sourcing strategy to mitigate supply chain risks.

---

### 6. **Financial Reporting and Analysis**

**Objective:** Prepare financial reports and analyze the company's financial health.

**Tasks and Solutions:**

**Task 1:** Generate an income statement for the last fiscal

 year.
```sql
SELECT 'Revenue' AS Category, SUM(sod.LineTotal) AS Amount
FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
WHERE YEAR(soh.OrderDate) = YEAR(GETDATE()) - 1

UNION ALL

SELECT 'Cost of Goods Sold', SUM(pod.LineTotal)
FROM Purchasing.PurchaseOrderDetail pod
JOIN Purchasing.PurchaseOrderHeader poh ON pod.PurchaseOrderID = poh.PurchaseOrderID
WHERE YEAR(poh.OrderDate) = YEAR(GETDATE()) - 1

UNION ALL

SELECT 'Gross Profit', 
    (SELECT SUM(sod.LineTotal) FROM Sales.SalesOrderDetail sod
    JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
    WHERE YEAR(soh.OrderDate) = YEAR(GETDATE()) - 1) 
    - 
    (SELECT SUM(pod.LineTotal) FROM Purchasing.PurchaseOrderDetail pod
    JOIN Purchasing.PurchaseOrderHeader poh ON pod.PurchaseOrderID = poh.PurchaseOrderID
    WHERE YEAR(poh.OrderDate) = YEAR(GETDATE()) - 1)
```
**Explanation:** This query generates a simple income statement for the last fiscal year, showing revenue, cost of goods sold, and gross profit.

---

**Task 2:** Calculate the company's net profit margin for the last fiscal year.
```sql
WITH IncomeStatement AS
(
    SELECT SUM(sod.LineTotal) AS Revenue, 
           (SELECT SUM(pod.LineTotal) FROM Purchasing.PurchaseOrderDetail pod
            JOIN Purchasing.PurchaseOrderHeader poh ON pod.PurchaseOrderID = poh.PurchaseOrderID
            WHERE YEAR(poh.OrderDate) = YEAR(GETDATE()) - 1) AS COGS,
           (SELECT SUM(ExpenseAmount) FROM Finance.Expenses fe
            WHERE YEAR(fe.ExpenseDate) = YEAR(GETDATE()) - 1) AS OperatingExpenses
    FROM Sales.SalesOrderDetail sod
    JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
    WHERE YEAR(soh.OrderDate) = YEAR(GETDATE()) - 1
)
SELECT (Revenue - COGS - OperatingExpenses) / Revenue * 100 AS NetProfitMargin
FROM IncomeStatement;
```
**Explanation:** This query calculates the company's net profit margin for the last fiscal year by subtracting the cost of goods sold and operating expenses from revenue, and then dividing by revenue.

---

**Task 3:** Analyze the trend in operating expenses over the past five years.
```sql
SELECT YEAR(ExpenseDate) AS Year, SUM(ExpenseAmount) AS TotalExpenses
FROM Finance.Expenses
GROUP BY YEAR(ExpenseDate)
ORDER BY Year DESC;
```
**Explanation:** This query analyzes the trend in operating expenses over the past five years.

---

**Task 4:** Evaluate the company's liquidity by calculating the current ratio.
```sql
WITH CurrentAssets AS
(
    SELECT SUM(AssetValue) AS TotalAssets
    FROM Finance.Assets
    WHERE AssetType = 'Current'
),
CurrentLiabilities AS
(
    SELECT SUM(LiabilityValue) AS TotalLiabilities
    FROM Finance.Liabilities
    WHERE LiabilityType = 'Current'
)
SELECT TotalAssets / TotalLiabilities AS CurrentRatio
FROM CurrentAssets, CurrentLiabilities;
```
**Explanation:** This query calculates the current ratio, a key measure of the company's liquidity, by dividing current assets by current liabilities.

---

**Task 5:** Generate a report on the company's return on investment (ROI) for major projects.
```sql
SELECT p.ProjectName, 
       (p.TotalRevenue - p.TotalCost) / p.TotalCost * 100 AS ROI
FROM Finance.Projects p
WHERE p.ProjectType = 'Major'
ORDER BY ROI DESC;
```
**Explanation:** This query generates a report on the return on investment (ROI) for major projects by comparing total revenue to total cost.

---

### 7. **Market and Competitive Analysis**

**Objective:** Conduct a market and competitive analysis to understand the company's position in the market.

**Tasks and Solutions:**

**Task 1:** Identify the company's top competitors based on market share.
```sql
SELECT c.CompetitorName, c.MarketShare
FROM Market.Competitors c
ORDER BY c.MarketShare DESC;
```
**Explanation:** This query lists the company's top competitors based on market share.

---

**Task 2:** Analyze the company's market share trend over the past five years.
```sql
SELECT YEAR(ms.Date) AS Year, ms.MarketShare
FROM Market.MarketShare ms
WHERE ms.CompanyName = 'Adventure Works'
ORDER BY Year DESC;
```
**Explanation:** This query analyzes the company's market share trend over the past five years.

---

**Task 3:** Compare the company's pricing strategy with its competitors.
```sql
SELECT p.ProductName, p.Price AS CompanyPrice, c.CompetitorName, cp.Price AS CompetitorPrice
FROM Production.Product p
JOIN Market.CompetitorPrices cp ON p.ProductID = cp.ProductID
JOIN Market.Competitors c ON cp.CompetitorID = c.CompetitorID
ORDER BY p.ProductName, c.CompetitorName;
```
**Explanation:** This query compares the company's pricing strategy with that of its competitors for similar products.

---

**Task 4:** Evaluate the impact of market trends on the company's sales performance.
```sql
SELECT mt.TrendName, mt.TrendImpact, SUM(sod.LineTotal) AS TotalSales
FROM Market.MarketTrends mt
JOIN Sales.SalesOrderDetail sod ON mt.TrendID = sod.TrendID
GROUP BY mt.TrendName, mt.TrendImpact
ORDER BY TotalSales DESC;
```
**Explanation:** This query evaluates how different market trends have impacted the company's sales performance.

---

**Task 5:** Propose strategies for increasing the company's market share.
- **Solution:** Based on the competitive and market analysis, propose strategies such as:
  - Adjusting pricing strategies to be more competitive.
  - Expanding product lines to target new customer segments.
  - Enhancing marketing efforts in underperforming regions.
  - Strengthening partnerships with key suppliers to improve product offerings.


### 8. **Data Quality and Integrity Assessment**

**Objective:** Ensure the data quality and integrity of the Adventure Works database.

**Tasks and Solutions:**

**Task 1:** Identify missing or null values in key tables.
```sql
SELECT 'Sales.SalesOrderHeader' AS TableName, COUNT(*) AS NullCount
FROM Sales.SalesOrderHeader
WHERE CustomerID IS NULL OR SalesPersonID IS NULL OR ShipToAddressID IS NULL
UNION ALL
SELECT 'Person.Person' AS TableName, COUNT(*) AS NullCount
FROM Person.Person
WHERE FirstName IS NULL OR LastName IS NULL
UNION ALL
SELECT 'Production.Product' AS TableName, COUNT(*) AS NullCount
FROM Production.Product
WHERE Name IS NULL OR ProductNumber IS NULL;
```
**Explanation:** This query checks key tables for missing or null values in important columns, ensuring that critical data like customer IDs, names, and product details are not missing.

---

**Task 2:** Verify referential integrity by checking for orphaned records.
```sql
-- Check for orphaned sales orders with no corresponding customer
SELECT soh.SalesOrderID, soh.CustomerID
FROM Sales.SalesOrderHeader soh
LEFT JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;

-- Check for orphaned sales order details with no corresponding sales order
SELECT sod.SalesOrderDetailID, sod.SalesOrderID
FROM Sales.SalesOrderDetail sod
LEFT JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
WHERE soh.SalesOrderID IS NULL;
```
**Explanation:** This query identifies orphaned records in the `SalesOrderHeader` and `SalesOrderDetail` tables by checking for sales orders without corresponding customers or details without corresponding orders.

---

**Task 3:** Assess the uniqueness of key columns (e.g., ProductNumber in the Product table).
```sql
SELECT ProductNumber, COUNT(*) AS Count
FROM Production.Product
GROUP BY ProductNumber
HAVING COUNT(*) > 1;
```
**Explanation:** This query checks for duplicate `ProductNumber` entries in the `Product` table to ensure that each product has a unique identifier.

---

**Task 4:** Check for data type consistency in important columns.
```sql
-- Example: Checking if all ProductID values are integers
SELECT COUNT(*) AS InconsistentTypes
FROM Production.Product
WHERE TRY_CAST(ProductID AS INT) IS NULL;

-- Example: Checking if all TotalDue values are numeric
SELECT COUNT(*) AS InconsistentTypes
FROM Sales.SalesOrderHeader
WHERE TRY_CAST(TotalDue AS DECIMAL(18,2)) IS NULL;
```
**Explanation:** These queries check if the `ProductID` and `TotalDue` columns contain consistent data types (integers and decimals, respectively).

---

**Task 5:** Propose strategies for maintaining data quality.
- **Solution:** To maintain data quality:
  - **Implement constraints:** Use NOT NULL, UNIQUE, and FOREIGN KEY constraints to enforce data integrity.
  - **Regular audits:** Schedule regular checks for null values, duplicates, and orphaned records.
  - **Data validation:** Implement validation rules at the application level to prevent bad data entry.
  - **Data type enforcement:** Ensure consistent data types across tables and columns by using the appropriate SQL Server data types.

---

### 9. **Advanced Query Optimization**

**Objective:** Optimize SQL queries to improve performance and efficiency.

**Tasks and Solutions:**

**Task 1:** Identify slow-running queries using SQL Server's built-in tools.
```sql
-- Example: Using the SQL Server dynamic management views (DMVs) to find slow queries
SELECT TOP 10
    qs.sql_handle,
    qs.total_elapsed_time / qs.execution_count AS AvgElapsedTime,
    qs.execution_count,
    SUBSTRING(qt.text, qs.statement_start_offset / 2 + 1, 
              (CASE WHEN qs.statement_end_offset = -1 
                    THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2 
                    ELSE qs.statement_end_offset 
               END - qs.statement_start_offset) / 2 + 1) AS QueryText
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
ORDER BY AvgElapsedTime DESC;
```
**Explanation:** This query uses SQL Server DMVs to identify slow-running queries based on their average elapsed time.

---

**Task 2:** Optimize a slow-running query by reviewing its execution plan.
```sql
-- Example: Analyzing the execution plan of a slow query
-- Run the following query in SQL Server Management Studio (SSMS)
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT * 
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
WHERE soh.OrderDate BETWEEN '2023-01-01' AND '2023-12-31';

-- Check the execution plan in SSMS to identify optimization opportunities
```
**Explanation:** This example enables `SET STATISTICS IO` and `SET STATISTICS TIME` to analyze the I/O and time statistics, helping identify inefficiencies in the query execution plan.

---

**Task 3:** Implement indexing to improve query performance.
```sql
-- Example: Creating an index on frequently queried columns
CREATE INDEX IDX_SalesOrderHeader_OrderDate ON Sales.SalesOrderHeader(OrderDate);
CREATE INDEX IDX_SalesOrderDetail_ProductID ON Sales.SalesOrderDetail(ProductID);
```
**Explanation:** This solution creates indexes on columns that are frequently used in query filters (`OrderDate` and `ProductID`) to improve performance.

---

**Task 4:** Rewrite a suboptimal query to make it more efficient.
```sql
-- Suboptimal query
SELECT p.ProductID, p.Name, (SELECT COUNT(*) FROM Sales.SalesOrderDetail sod WHERE sod.ProductID = p.ProductID) AS OrderCount
FROM Production.Product p;

-- Optimized query using a join instead of a subquery
SELECT p.ProductID, p.Name, COUNT(sod.SalesOrderDetailID) AS OrderCount
FROM Production.Product p
LEFT JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
GROUP BY p.ProductID, p.Name;
```
**Explanation:** The optimized query replaces a correlated subquery with a `JOIN` and `GROUP BY` clause, which is generally more efficient.

---

**Task 5:** Suggest best practices for query optimization.
- **Solution:** To optimize queries:
  - **Use indexes effectively:** Index columns used in WHERE clauses, JOINs, and GROUP BY operations.
  - **Avoid SELECT *:** Only select the necessary columns to reduce I/O.
  - **Use appropriate data types:** Smaller data types can reduce memory usage and improve performance.
  - **Consider query rewriting:** Rewrite subqueries as JOINs where possible, and avoid correlated subqueries if they are inefficient.
  - **Analyze execution plans:** Regularly review execution plans to identify bottlenecks.

---

### 10. **Database Security and Access Control**

**Objective:** Ensure the security and proper access control of the Adventure Works database.

**Tasks and Solutions:**

**Task 1:** Review and report on the current user roles and permissions.
```sql
-- List all database users and their roles
SELECT dp.name AS UserName, dp.type_desc AS UserType, 
       rl.name AS RoleName
FROM sys.database_principals dp
LEFT JOIN sys.database_role_members drm ON dp.principal_id = drm.member_principal_id
LEFT JOIN sys.database_principals rl ON drm.role_principal_id = rl.principal_id
WHERE dp.type NOT IN ('R', 'X')  -- Exclude roles and certificate mappings
ORDER BY dp.name;
```
**Explanation:** This query lists all database users, their roles, and associated permissions.

---

**Task 2:** Implement role-based access control (RBAC) for different user groups.
```sql
-- Example: Creating roles and assigning permissions
-- Create roles for different user groups
CREATE ROLE SalesRole;
CREATE ROLE HRRole;
CREATE ROLE ManagerRole;

-- Grant permissions to roles
GRANT SELECT ON Sales.SalesOrderHeader TO SalesRole;
GRANT INSERT, UPDATE ON HumanResources.Employee TO HRRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON Sales.SalesOrderHeader TO ManagerRole;

-- Add users to roles
EXEC sp_addrolemember 'SalesRole', 'SalesUser';
EXEC sp_addrolemember 'HRRole', 'HRUser';
EXEC sp_addrolemember 'ManagerRole', 'ManagerUser';
```
**Explanation:** This example demonstrates creating roles for different user groups, granting appropriate permissions, and adding users to these roles.

---

**Task 3:** Set up auditing to track changes to critical tables.
```sql
-- Example: Creating a database audit to track changes to critical tables
CREATE SERVER AUDIT CriticalTableChangesAudit
TO FILE (FILEPATH = 'C:\AuditLogs\')
WITH (QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE);

CREATE DATABASE AUDIT SPECIFICATION CriticalTablesAuditSpec
FOR SERVER AUDIT CriticalTableChangesAudit
ADD (UPDATE, DELETE, INSERT ON Sales.SalesOrderHeader BY [public]),
ADD (UPDATE, DELETE, INSERT ON Production.Product BY [public])
WITH (STATE = ON);
```
**Explanation:** This solution sets up auditing to track changes (INSERT, UPDATE, DELETE) to the `SalesOrderHeader` and `Product` tables, logging them to a file.

---

**Task 4:** Encrypt sensitive data such as customer credit card information.
```sql
-- Example: Encrypting sensitive data in the database
-- Create a database master key
CREATE MASTER KEY ENCRYPTION

 BY PASSWORD = 'StrongPassword!123';

-- Create a certificate for encryption
CREATE CERTIFICATE CustomerDataEncryptionCert
WITH SUBJECT = 'Customer Data Encryption';

-- Create a symmetric key using the certificate
CREATE SYMMETRIC KEY CustomerDataSymKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE CustomerDataEncryptionCert;

-- Encrypt and store credit card information
OPEN SYMMETRIC KEY CustomerDataSymKey
DECRYPTION BY CERTIFICATE CustomerDataEncryptionCert;

UPDATE Sales.CreditCard
SET CardNumber = ENCRYPTBYKEY(KEY_GUID('CustomerDataSymKey'), CardNumber);

CLOSE SYMMETRIC KEY CustomerDataSymKey;
```
**Explanation:** This example encrypts sensitive customer credit card information using a symmetric key and AES-256 encryption.

---

**Task 5:** Suggest best practices for securing the Adventure Works database.
- **Solution:** To secure the database:
  - **Implement role-based access control:** Limit user permissions based on roles to enforce the principle of least privilege.
  - **Use encryption:** Encrypt sensitive data both at rest and in transit.
  - **Set up auditing:** Monitor and log changes to critical tables and permissions.
  - **Regularly review permissions:** Periodically audit user roles and permissions to ensure they align with current security policies.
  - **Keep SQL Server updated:** Apply the latest security patches and updates to protect against vulnerabilities.

