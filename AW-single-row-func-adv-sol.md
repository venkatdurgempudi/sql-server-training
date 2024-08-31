
### **1.**
```sql
-- Solution 1: Calculate absolute difference, round to 2 decimal places, concatenate with ProductNumber
SELECT 
    ProductNumber, 
    CONCAT(ProductNumber, ' - ', CAST(ROUND(ABS(ListPrice - StandardCost), 2) AS VARCHAR(10))) AS Result
FROM 
    Production.Product;
```

---

### **2.**
```sql
-- Solution 2: Calculate days between OrderDate and DueDate, add 5 days, check if still earlier than today
SELECT 
    OrderDate, 
    DueDate, 
    CASE 
        WHEN DATEADD(DAY, 5, DueDate) < GETDATE() THEN 'DueDate Still Earlier'
        ELSE 'DueDate Passed'
    END AS DueStatus
FROM 
    Sales.SalesOrderHeader;
```

---

### **3.**
```sql
-- Solution 3: Concatenate FirstName, LastName, EmailAddress, convert to uppercase, find length
SELECT 
    FirstName, 
    LastName, 
    EmailAddress, 
    LEN(UPPER(CONCAT(FirstName, LastName, EmailAddress))) AS StringLength
FROM 
    Person.Person;
```

---

### **4.**
```sql
-- Solution 4: Convert OrderDate to string, extract year and month, concatenate with SalesOrderID
SELECT 
    SalesOrderID, 
    OrderDate, 
    CONCAT(SalesOrderID, '_', CAST(YEAR(OrderDate) AS VARCHAR(4)), CAST(MONTH(OrderDate) AS VARCHAR(2))) AS NewID
FROM 
    Sales.SalesOrderHeader;
```

---

### **5.**
```sql
-- Solution 5: Add 10% to StandardCost, round to 2 decimal places, convert to string, concatenate with ProductNumber
SELECT 
    ProductNumber, 
    CONCAT(ProductNumber, ' - ', CAST(ROUND(StandardCost * 1.1, 2) AS VARCHAR(10))) AS NewPrice
FROM 
    Production.Product;
```

---

### **6.**
```sql
-- Solution 6: Calculate months since ModifiedDate, check if > 12 months, append "Outdated" or "Current" to BusinessEntityID
SELECT 
    BusinessEntityID, 
    ModifiedDate, 
    CONCAT(BusinessEntityID, ' - ', 
        CASE 
            WHEN DATEDIFF(MONTH, ModifiedDate, GETDATE()) > 12 THEN 'Outdated'
            ELSE 'Current'
        END
    ) AS Status
FROM 
    Person.Person;
```

---

### **7.**
```sql
-- Solution 7: Find position of first hyphen in ProductNumber, extract part before hyphen, concatenate with ListPrice
SELECT 
    ProductNumber, 
    CONCAT(SUBSTRING(ProductNumber, 1, CHARINDEX('-', ProductNumber) - 1), ' - ', CAST(ListPrice AS VARCHAR(10))) AS ProductPrice
FROM 
    Production.Product;
```

---

### **8.**
```sql
-- Solution 8: Calculate difference in days, add 3 days to OrderDate, convert both dates to strings
SELECT 
    SalesOrderID, 
    OrderDate, 
    ShipDate, 
    DATEDIFF(DAY, OrderDate, ShipDate) AS DaysBetween, 
    CAST(DATEADD(DAY, 3, OrderDate) AS VARCHAR(10)) AS NewOrderDate
FROM 
    Sales.SalesOrderHeader;
```

---

### **9.**
```sql
-- Solution 9: If Title is not null, concatenate with LastName, otherwise display LastName in uppercase
SELECT 
    FirstName, 
    LastName, 
    ISNULL(CONCAT(Title, ' ', LastName), UPPER(LastName)) AS FormalName
FROM 
    Person.Person;
```

---

### **10.**
```sql
-- Solution 10: Add 5% to TotalDue, round, convert to string with two decimal places, concatenate with OrderDate year
SELECT 
    SalesOrderID, 
    OrderDate, 
    CONCAT(CAST(YEAR(OrderDate) AS VARCHAR(4)), ' - ', CAST(ROUND(TotalDue * 1.05, 2) AS VARCHAR(10))) AS UpdatedTotalDue
FROM 
    Sales.SalesOrderHeader;
```

---

### **11.**
```sql
-- Solution 11: Convert ModifiedDate to date-only format, extract year, concatenate with BusinessEntityID
SELECT 
    BusinessEntityID, 
    ModifiedDate, 
    CONCAT(BusinessEntityID, ' - ', CAST(YEAR(CAST(ModifiedDate AS DATE)) AS VARCHAR(4))) AS ModifiedYear
FROM 
    Person.Person;
```

---

### **12.**
```sql
-- Solution 12: If Weight is null, display "Weight Unavailable"; otherwise, convert to string and append " kg"
SELECT 
    ProductNumber, 
    ISNULL(CONCAT(CAST(Weight AS VARCHAR(10)), ' kg'), 'Weight Unavailable') AS DisplayWeight
FROM 
    Production.Product;
```

---

### **13.**
```sql
-- Solution 13: Calculate months between OrderDate and ShipDate, convert TotalDue to integer, concatenate with months
SELECT 
    SalesOrderID, 
    OrderDate, 
    ShipDate, 
    CONCAT(CAST(DATEDIFF(MONTH, OrderDate, ShipDate) AS VARCHAR(3)), ' Months - ', CAST(CAST(TotalDue AS INT) AS VARCHAR(10))) AS Summary
FROM 
    Sales.SalesOrderHeader;
```

---

### **14.**
```sql
-- Solution 14: Convert BirthDate to string, find first 3 characters of FirstName, concatenate with LastName and year of BirthDate
SELECT 
    FirstName, 
    LastName, 
    CONCAT(SUBSTRING(FirstName, 1, 3), LastName, CAST(YEAR(BirthDate) AS VARCHAR(4))) AS UniqueIdentifier
FROM 
    Person.Person;
```

---

### **15.**
```sql
-- Solution 15: Extract last 3 characters of ProductNumber, find length, concatenate with reversed ProductNumber
SELECT 
    ProductNumber, 
    CONCAT(RIGHT(ProductNumber, 3), '-', LEN(ProductNumber), '-', REVERSE(ProductNumber)) AS NewCode
FROM 
    Production.Product;
```

---

### **16.**
```sql
-- Solution 16: Subtract 7 days from OrderDate, convert to string, append to SalesOrderID
SELECT 
    SalesOrderID, 
    OrderDate, 
    CONCAT(SalesOrderID, '_', CAST(DATEADD(DAY, -7, OrderDate) AS VARCHAR(10))) AS AdjustedOrder
FROM 
    Sales.SalesOrderHeader;
```

---

### **17.**
```sql
-- Solution 17: If StandardCost < 50, multiply by 2, round, concatenate with ProductNumber
SELECT 
    ProductNumber, 
    CONCAT(ProductNumber, ' - ', 
        CAST(ROUND(CASE WHEN StandardCost < 50 THEN StandardCost * 2 ELSE StandardCost END, 2) AS VARCHAR(10))) AS CostCalculation
FROM 
    Production.Product;
```

---

### **18.**
```sql
-- Solution 18: Calculate percentage of TotalDue relative to highest TotalDue, round to 2 decimal places, append to SalesOrderID
WITH MaxTotalDue AS (
    SELECT MAX(TotalDue) AS MaxDue FROM Sales.SalesOrderHeader
)
SELECT 
    SalesOrderID, 
    CONCAT(SalesOrderID, '_', 
        CAST(ROUND((TotalDue / MaxDue) * 100, 2) AS VARCHAR(5)), '%') AS TotalDuePercentage
FROM 
    Sales.SalesOrderHeader, MaxTotalDue;
```

---

### **19.**
```sql
-- Solution 19: Subtract 5% from ListPrice, convert to money data type, concatenate with ProductNumber
SELECT 
    ProductNumber, 
    CONCAT(ProductNumber, ' - ', CAST(CAST(ListPrice * 0.95 AS MONEY) AS VARCHAR(10))) AS DiscountedPrice
FROM 
    Production.Product;
```

---

### **20.**
```sql
-- Solution 20: If MiddleName is null, display initials of FirstName and LastName; otherwise, display initials of FirstName, MiddleName, and LastName
SELECT 
    FirstName, 
    MiddleName, 
    LastName, 
    CONCAT(SUBSTRING(FirstName, 1, 1), '.', 
        ISNULL(CONCAT(SUBSTRING(MiddleName, 1, 1), '.'), ''), 
        SUBSTRING(LastName, 1, 1), '.') AS Initials
FROM 
    Person.Person;
```

---

### **21.**
```sql
-- Solution 21: Calculate total number of days from OrderDate to ShipDate, concatenate with SalesOrderID
SELECT 
    SalesOrderID, 
    OrderDate, 
    ShipDate, 
    CONCAT(SalesOrderID, ' - ', CAST(DATEDIFF(DAY, OrderDate, ShipDate) AS VARCHAR(5)), ' Days') AS DeliveryTime
FROM 
    Sales.SalesOrderHeader;
```

---

### **22.**
```sql
-- Solution 22: Increase ListPrice by 20%, round to 2 decimal places, append to ProductNumber
SELECT 
    ProductNumber, 
    CONCAT(ProductNumber, ' - ', CAST(ROUND(ListPrice * 1.2, 2) AS VARCHAR(10))) AS NewListPrice


FROM 
    Production.Product;
```

---

### **23.**
```sql
-- Solution 23: Extract first 5 characters of FirstName, reverse, concatenate with length of LastName
SELECT 
    FirstName, 
    LastName, 
    CONCAT(REVERSE(SUBSTRING(FirstName, 1, 5)), '-', LEN(LastName)) AS Identifier
FROM 
    Person.Person;
```

---

### **24.**
```sql
-- Solution 24: Subtract 10% from TotalDue, convert to money, append to SalesOrderID
SELECT 
    SalesOrderID, 
    CONCAT(SalesOrderID, ' - ', CAST(CAST(TotalDue * 0.9 AS MONEY) AS VARCHAR(10))) AS AdjustedTotalDue
FROM 
    Sales.SalesOrderHeader;
```

---

### **25.**
```sql
-- Solution 25: If DueDate is before today, display "Overdue" with days since due; otherwise, display "On Time"
SELECT 
    SalesOrderID, 
    DueDate, 
    CASE 
        WHEN DueDate < GETDATE() THEN CONCAT('Overdue by ', CAST(DATEDIFF(DAY, DueDate, GETDATE()) AS VARCHAR(5)), ' days')
        ELSE 'On Time'
    END AS Status
FROM 
    Sales.SalesOrderHeader;
```

---

### **26.**
```sql
-- Solution 26: Reverse ProductNumber, find its length, concatenate with Name
SELECT 
    ProductNumber, 
    Name, 
    CONCAT(REVERSE(ProductNumber), '-', LEN(ProductNumber), '-', Name) AS Identifier
FROM 
    Production.Product;
```

---

### **27.**
```sql
-- Solution 27: Calculate difference in days between OrderDate and ShipDate, add 3 days to ShipDate, convert to string
SELECT 
    OrderDate, 
    ShipDate, 
    DATEDIFF(DAY, OrderDate, ShipDate) AS DaysBetween, 
    CAST(DATEADD(DAY, 3, ShipDate) AS VARCHAR(10)) AS AdjustedShipDate
FROM 
    Sales.SalesOrderHeader;
```

---

### **28.**
```sql
-- Solution 28: If EmailPromotion is 1, display "Yes"; otherwise, display "No" with LastName
SELECT 
    FirstName, 
    LastName, 
    CASE 
        WHEN EmailPromotion = 1 THEN 'Yes'
        ELSE CONCAT('No - ', LastName)
    END AS PromotionStatus
FROM 
    Person.Person;
```

---

### **29.**
```sql
-- Solution 29: If ListPrice > 100, subtract 10, convert to string, concatenate with ProductNumber
SELECT 
    ProductNumber, 
    ListPrice, 
    CONCAT(ProductNumber, ' - ', 
        CAST(CASE WHEN ListPrice > 100 THEN ListPrice - 10 ELSE ListPrice END AS VARCHAR(10))) AS AdjustedPrice
FROM 
    Production.Product;
```

---

### **30.**
```sql
-- Solution 30: Calculate absolute difference between TotalDue and Freight, round, concatenate with SalesOrderID
SELECT 
    SalesOrderID, 
    TotalDue, 
    Freight, 
    CONCAT(SalesOrderID, ' - ', 
        CAST(ROUND(ABS(TotalDue - Freight), 2) AS VARCHAR(10))) AS TotalDueDifference
FROM 
    Sales.SalesOrderHeader;
```

---

### **31.**
```sql
-- Solution 31: Multiply StandardCost by 1.1, round to 2 decimal places, convert to money, concatenate with ProductNumber
SELECT 
    ProductNumber, 
    StandardCost, 
    CONCAT(ProductNumber, ' - ', 
        CAST(CAST(ROUND(StandardCost * 1.1, 2) AS MONEY) AS VARCHAR(10))) AS UpdatedCost
FROM 
    Production.Product;
```

---

### **32.**
```sql
-- Solution 32: Calculate number of days between OrderDate and ShipDate, display with first 5 characters of SalesOrderID
SELECT 
    SalesOrderID, 
    OrderDate, 
    ShipDate, 
    CONCAT(SUBSTRING(SalesOrderID, 1, 5), ' - ', 
        CAST(DATEDIFF(DAY, OrderDate, ShipDate) AS VARCHAR(5)), ' Days') AS Summary
FROM 
    Sales.SalesOrderHeader;
```

---

### **33.**
```sql
-- Solution 33: If Title is null, convert LastName to uppercase; otherwise, display the original LastName
SELECT 
    FirstName, 
    LastName, 
    ISNULL(UPPER(LastName), LastName) AS DisplayName
FROM 
    Person.Person;
```

---

### **34.**
```sql
-- Solution 34: Calculate square root of ListPrice, round to 2 decimal places, convert to string for display
SELECT 
    ProductNumber, 
    ListPrice, 
    CONCAT(ProductNumber, ' - ', 
        CAST(ROUND(SQRT(ListPrice), 2) AS VARCHAR(10))) AS SquareRootPrice
FROM 
    Production.Product;
```

---

### **35.**
```sql
-- Solution 35: Subtract 15 days from OrderDate, convert to string, append to first 4 characters of SalesOrderID
SELECT 
    SalesOrderID, 
    OrderDate, 
    CONCAT(SUBSTRING(SalesOrderID, 1, 4), '_', 
        CAST(DATEADD(DAY, -15, OrderDate) AS VARCHAR(10))) AS AdjustedOrderID
FROM 
    Sales.SalesOrderHeader;
```

---

### **36.**
```sql
-- Solution 36: If StandardCost > 100, divide by 2, round to 2 decimal places, concatenate with ProductNumber
SELECT 
    ProductNumber, 
    StandardCost, 
    CONCAT(ProductNumber, ' - ', 
        CAST(ROUND(CASE WHEN StandardCost > 100 THEN StandardCost / 2 ELSE StandardCost END, 2) AS VARCHAR(10))) AS CostAdjustment
FROM 
    Production.Product;
```

---

### **37.**
```sql
-- Solution 37: Calculate ceiling value of TotalDue, convert to string, concatenate with SalesOrderID
SELECT 
    SalesOrderID, 
    TotalDue, 
    CONCAT(SalesOrderID, ' - ', 
        CAST(CEILING(TotalDue) AS VARCHAR(10))) AS RoundedTotalDue
FROM 
    Sales.SalesOrderHeader;
```

---

### **38.**
```sql
-- Solution 38: If StandardCost is null, display "N/A"; otherwise, convert to money format, concatenate with ProductNumber
SELECT 
    ProductNumber, 
    ISNULL(CONCAT(ProductNumber, ' - ', CAST(CAST(StandardCost AS MONEY) AS VARCHAR(10))), 'N/A') AS CostDisplay
FROM 
    Production.Product;
```

---

### **39.**
```sql
-- Solution 39: Calculate number of months between OrderDate and ShipDate, concatenate with year part of OrderDate
SELECT 
    SalesOrderID, 
    OrderDate, 
    ShipDate, 
    CONCAT(CAST(DATEDIFF(MONTH, OrderDate, ShipDate) AS VARCHAR(5)), ' Months - ', 
        CAST(YEAR(OrderDate) AS VARCHAR(4))) AS DeliverySummary
FROM 
    Sales.SalesOrderHeader;
```

---

### **40.**
```sql
-- Solution 40: If MiddleName is not null, concatenate first character of FirstName, MiddleName, and LastName as initials
SELECT 
    FirstName, 
    LastName, 
    ISNULL(MiddleName, '') AS MiddleInitial, 
    CONCAT(SUBSTRING(FirstName, 1, 1), '.', 
        ISNULL(CONCAT(SUBSTRING(MiddleName, 1, 1), '.'), ''), 
        SUBSTRING(LastName, 1, 1), '.') AS Initials
FROM 
    Person.Person;
```

---

### **41.**
```sql
-- Solution 41: Convert first 3 characters of ProductNumber to uppercase, find its position in Name, concatenate both
SELECT 
    ProductNumber, 
    Name, 
    CONCAT(UPPER(SUBSTRING(ProductNumber, 1, 3)), '-', 
        CHARINDEX(UPPER(SUBSTRING(ProductNumber, 1, 3)), Name)) AS ProductInfo
FROM 
    Production.Product;
```

---

### **42.**
```sql
-- Solution 42: If OrderDate is greater than ShipDate, subtract 10 days from ShipDate, convert to string
SELECT 
    SalesOrderID, 
    OrderDate, 
    ShipDate, 
    CASE 
        WHEN OrderDate > ShipDate THEN CONCAT('Adjusted: ', CAST(DATEADD(DAY, -10, ShipDate) AS VARCHAR(10)))
        ELSE 'No Adjustment'
    END AS ShippingAdjustment
FROM 
    Sales.SalesOrderHeader;
```

---

### **43.**
```sql
-- Solution 43: Convert ListPrice to integer, append to first 5 characters of ProductNumber
SELECT 
    ProductNumber, 
    ListPrice, 
    CONCAT(SUBSTRING(ProductNumber, 1, 5), ' - ', 
        CAST(CAST(ListPrice AS INT) AS VARCHAR(10))) AS DisplayPrice
FROM 
    Production.Product;
```

---

### **44.**
```sql
-- Solution 44: Multiply TotalDue by 1.15, round to 2 decimal places, convert to money format, concatenate with SalesOrderID
SELECT 
    SalesOrderID, 
    TotalDue, 
    CONCAT(SalesOrder

ID, ' - ', 
        CAST(CAST(ROUND(TotalDue * 1.15, 2) AS MONEY) AS VARCHAR(10))) AS NewTotalDue
FROM 
    Sales.SalesOrderHeader;
```

---

### **45.**
```sql
-- Solution 45: Extract first 2 characters of FirstName and LastName, concatenate with BusinessEntityID
SELECT 
    BusinessEntityID, 
    FirstName, 
    LastName, 
    CONCAT(SUBSTRING(FirstName, 1, 2), SUBSTRING(LastName, 1, 2), '-', BusinessEntityID) AS UniqueCode
FROM 
    Person.Person;
```

---

### **46.**
```sql
-- Solution 46: Convert ListPrice to money format, subtract 5%, concatenate with ProductNumber
SELECT 
    ProductNumber, 
    ListPrice, 
    CONCAT(ProductNumber, ' - ', 
        CAST(CAST(ListPrice * 0.95 AS MONEY) AS VARCHAR(10))) AS DiscountedListPrice
FROM 
    Production.Product;
```

---

### **47.**
```sql
-- Solution 47: Calculate square root of StandardCost, round to 2 decimal places, concatenate with ProductNumber
SELECT 
    ProductNumber, 
    StandardCost, 
    CONCAT(ProductNumber, ' - ', 
        CAST(ROUND(SQRT(StandardCost), 2) AS VARCHAR(10))) AS SquareRootCost
FROM 
    Production.Product;
```

---

### **48.**
```sql
-- Solution 48: Calculate difference between TotalDue and SubTotal, round, convert to string, concatenate with SalesOrderID
SELECT 
    SalesOrderID, 
    TotalDue, 
    SubTotal, 
    CONCAT(SalesOrderID, ' - ', 
        CAST(ROUND(TotalDue - SubTotal, 2) AS VARCHAR(10))) AS Difference
FROM 
    Sales.SalesOrderHeader;
```

---

### **49.**
```sql
-- Solution 49: If Title is "Mr." or "Ms.", display LastName in uppercase; otherwise, display normally
SELECT 
    FirstName, 
    LastName, 
    Title, 
    CASE 
        WHEN Title IN ('Mr.', 'Ms.') THEN UPPER(LastName)
        ELSE LastName
    END AS FormalLastName
FROM 
    Person.Person;
```

---

### **50.**
```sql
-- Solution 50: Multiply StandardCost by 1.25, convert to money, concatenate with ProductNumber
SELECT 
    ProductNumber, 
    StandardCost, 
    CONCAT(ProductNumber, ' - ', 
        CAST(CAST(StandardCost * 1.25 AS MONEY) AS VARCHAR(10))) AS AdjustedCost
FROM 
    Production.Product;
```
