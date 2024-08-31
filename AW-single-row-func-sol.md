### **Solution: SQL Server Functions Exploration Using Adventure Works**

---

#### **1. Character Functions**

```sql
-- Q1: Convert FirstName to uppercase
SELECT UPPER(FirstName) AS UpperFirstName 
FROM Person.Person;

-- Q2: Convert LastName to lowercase
SELECT LOWER(LastName) AS LowerLastName 
FROM Person.Person;

-- Q3: Concatenate FirstName and LastName with a comma and space
SELECT CONCAT(FirstName, ', ', LastName) AS FullName 
FROM Person.Person;

-- Q4: Extract the first 5 characters of LastName
SELECT LEFT(LastName, 5) AS FirstFiveChars 
FROM Person.Person;

-- Q5: Extract the last 4 characters of EmailAddress
SELECT RIGHT(EmailAddress, 4) AS LastFourChars 
FROM Person.EmailAddress;

-- Q6: Calculate the length of EmailAddress
SELECT LEN(EmailAddress) AS EmailLength 
FROM Person.EmailAddress;

-- Q7: Reverse the FirstName
SELECT REVERSE(FirstName) AS ReversedFirstName 
FROM Person.Person;

-- Q8: Find the position of '@' in EmailAddress
SELECT CHARINDEX('@', EmailAddress) AS AtSymbolPosition 
FROM Person.EmailAddress;

-- Q9: Trim leading spaces from MiddleName
SELECT LTRIM(MiddleName) AS TrimmedMiddleName 
FROM Person.Person;

-- Q10: Trim trailing spaces from Title
SELECT RTRIM(Title) AS TrimmedTitle 
FROM Person.Person;

-- Q11: Trim both leading and trailing spaces from Title
SELECT TRIM(Title) AS FullyTrimmedTitle 
FROM Person.Person;

-- Q12: Replace 'e' with 'E' in FirstName
SELECT REPLACE(FirstName, 'e', 'E') AS ReplacedFirstName 
FROM Person.Person;

-- Q13: Translate 'abc' to 'xyz' in FirstName
SELECT TRANSLATE(FirstName, 'abc', 'xyz') AS TranslatedFirstName 
FROM Person.Person;

-- Q14: Extract the middle 3 characters from LastName starting at position 3
SELECT SUBSTRING(LastName, 3, 3) AS SubstringLastName 
FROM Person.Person;

-- Q15: Display the first half of LastName
SELECT LEFT(LastName, LEN(LastName)/2) AS FirstHalfLastName 
FROM Person.Person;
```

---

#### **2. Numeric Functions**

```sql
-- Q16: Round ListPrice to the nearest whole number
SELECT ROUND(ListPrice, 0) AS RoundedListPrice 
FROM Production.Product;

-- Q17: Round StandardCost to 1 decimal place
SELECT ROUND(StandardCost, 1) AS RoundedStandardCost 
FROM Production.Product;

-- Q18: Calculate the square root of StandardCost
SELECT SQRT(StandardCost) AS SqrtStandardCost 
FROM Production.Product;

-- Q19: Find the absolute value of the difference between ListPrice and StandardCost
SELECT ABS(ListPrice - StandardCost) AS AbsoluteDifference 
FROM Production.Product;

-- Q20: Raise Weight to the power of 2
SELECT POWER(Weight, 2) AS WeightSquared 
FROM Production.Product 
WHERE Weight IS NOT NULL;

-- Q21: Calculate the floor value of Weight
SELECT FLOOR(Weight) AS FloorWeight 
FROM Production.Product 
WHERE Weight IS NOT NULL;

-- Q22: Calculate the ceiling value of Weight
SELECT CEILING(Weight) AS CeilingWeight 
FROM Production.Product 
WHERE Weight IS NOT NULL;

-- Q23: Raise ListPrice to the power of 3
SELECT POWER(ListPrice, 3) AS CubedListPrice 
FROM Production.Product;

-- Q24: Round the square root of StandardCost to 2 decimal places
SELECT ROUND(SQRT(StandardCost), 2) AS RoundedSqrtStandardCost 
FROM Production.Product;

-- Q25: Calculate the absolute value of ProductSubcategoryID minus ProductCategoryID
SELECT ABS(ProductSubcategoryID - ProductCategoryID) AS AbsoluteIDDifference 
FROM Production.Product;
```

---

#### **3. Date Functions**

```sql
-- Q26: Retrieve the current system date and time
SELECT GETDATE() AS CurrentDateTime;

-- Q27: Retrieve the current system date and time using CURRENT_TIMESTAMP
SELECT CURRENT_TIMESTAMP AS CurrentDateTime;

-- Q28: Extract the year from OrderDate
SELECT YEAR(OrderDate) AS OrderYear 
FROM Sales.SalesOrderHeader;

-- Q29: Extract the month from OrderDate
SELECT MONTH(OrderDate) AS OrderMonth 
FROM Sales.SalesOrderHeader;

-- Q30: Extract the day from OrderDate
SELECT DAY(OrderDate) AS OrderDay 
FROM Sales.SalesOrderHeader;

-- Q31: Calculate the number of days between OrderDate and ShipDate
SELECT DATEDIFF(DAY, OrderDate, ShipDate) AS DaysBetween 
FROM Sales.SalesOrderHeader;

-- Q32: Add 1 year to OrderDate
SELECT DATEADD(YEAR, 1, OrderDate) AS OrderDatePlusOneYear 
FROM Sales.SalesOrderHeader;

-- Q33: Add 15 days to OrderDate
SELECT DATEADD(DAY, 15, OrderDate) AS OrderDatePlus15Days 
FROM Sales.SalesOrderHeader;

-- Q34: Check if '2024-08-31' is a valid date
SELECT ISDATE('2024-08-31') AS IsValidDate;

-- Q35: Find the last day of the month for each OrderDate
SELECT EOMONTH(OrderDate) AS EndOfMonth 
FROM Sales.SalesOrderHeader;

-- Q36: Find the first day of the current year using DATETRUNC
SELECT DATETRUNC(YEAR, GETDATE()) AS FirstDayOfYear;

-- Q37: Calculate the number of months between OrderDate and ShipDate
SELECT DATEDIFF(MONTH, OrderDate, ShipDate) AS MonthsBetween 
FROM Sales.SalesOrderHeader;

-- Q38: Subtract 5 hours from OrderDate
SELECT DATEADD(HOUR, -5, OrderDate) AS OrderDateMinus5Hours 
FROM Sales.SalesOrderHeader;

-- Q39: Find the date 100 days from today
SELECT DATEADD(DAY, 100, GETDATE()) AS DateIn100Days;

-- Q40: Check if ShipDate is a valid date
SELECT ISDATE(ShipDate) AS IsValidShipDate 
FROM Sales.SalesOrderHeader;
```

---

#### **4. Data Type Conversion Functions**

```sql
-- Q41: Convert OrderDate to varchar format
SELECT CAST(OrderDate AS VARCHAR(50)) AS OrderDateVarchar 
FROM Sales.SalesOrderHeader;

-- Q42: Convert TotalDue to an integer
SELECT CONVERT(INT, TotalDue) AS TotalDueInt 
FROM Sales.SalesOrderHeader;

-- Q43: Convert ProductNumber to binary data type
SELECT CAST(ProductNumber AS BINARY(10)) AS ProductNumberBinary 
FROM Production.Product;

-- Q44: Replace NULL values in CreditCardApprovalCode with 'Not Available'
SELECT ISNULL(CreditCardApprovalCode, 'Not Available') AS ApprovalCode 
FROM Sales.SalesOrderHeader;

-- Q45: Convert ModifiedDate to date-only format
SELECT CONVERT(VARCHAR(10), ModifiedDate, 111) AS ModifiedDateOnly 
FROM Sales.SalesOrderHeader;

-- Q46: Convert SalesOrderID to char(10) and concatenate with a string
SELECT CAST(SalesOrderID AS CHAR(10)) + ' - Order' AS SalesOrderIDString 
FROM Sales.SalesOrderHeader;

-- Q47: Convert DueDate to a different datetime format
SELECT CONVERT(VARCHAR, DueDate, 113) AS FormattedDueDate 
FROM Sales.SalesOrderHeader;

-- Q48: Replace NULL values in Freight with 0
SELECT ISNULL(Freight, 0) AS FreightWithNoNulls 
FROM Sales.SalesOrderHeader;

-- Q49: Convert TotalDue to money data type
SELECT CAST(TotalDue AS MONEY) AS TotalDueMoney 
FROM Sales.SalesOrderHeader;

-- Q50: Convert StandardCost to decimal with 4 decimal places
SELECT CAST(StandardCost AS DECIMAL(10, 4)) AS StandardCostDecimal 
FROM Production.Product;
```
