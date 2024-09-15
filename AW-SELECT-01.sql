# Advanced SQL Data Retrieval Assignment (Person Schema Only)

## Objective
This assignment focuses on practicing advanced SQL queries using the `Person` schema in the AdventureWorks2022 database.

---

## DDL and DML Scripts

### DDL and DML for `Person` Table

```sql
-- DDL for Person table
CREATE TABLE Person (
    BusinessEntityID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50)
);

-- DML for Person table (Sample 10 records)
INSERT INTO Person (BusinessEntityID, FirstName, LastName) VALUES 
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Emily', 'Johnson'),
(4, 'Michael', 'Brown'),
(5, 'Sarah', 'Williams'),
(6, 'David', 'Jones'),
(7, 'Laura', 'Garcia'),
(8, 'James', 'Martinez'),
(9, 'Olivia', 'Hernandez'),
(10, 'Daniel', 'Wilson');
```

### DDL and DML for `EmailAddress` Table

```sql
-- DDL for EmailAddress table
CREATE TABLE EmailAddress (
    BusinessEntityID INT PRIMARY KEY,
    EmailAddress NVARCHAR(100),
    FOREIGN KEY (BusinessEntityID) REFERENCES Person(BusinessEntityID)
);

-- DML for EmailAddress table (Sample 10 records)
INSERT INTO EmailAddress (BusinessEntityID, EmailAddress) VALUES 
(1, 'john.doe@example.com'),
(2, 'jane.smith@example.com'),
(3, 'emily.johnson@example.com'),
(4, 'michael.brown@example.com'),
(5, 'sarah.williams@example.com'),
(6, 'david.jones@example.com'),
(7, 'laura.garcia@example.com'),
(8, 'james.martinez@example.com'),
(9, 'olivia.hernandez@example.com'),
(10, 'daniel.wilson@example.com');
```

---

## Assignment Questions

### 1. Find Persons who have either a NULL Email Address or a BusinessEntityID greater than 5
- **Tables to be used**: `Person`, `EmailAddress`

### 2. Retrieve Persons who have the same LastName as any other Person with a different BusinessEntityID
- **Tables to be used**: `Person`

### 3. List all distinct combinations of FirstName and LastName for Persons where the FirstName contains 'a' and LastName ends with 'n'
- **Tables to be used**: `Person`

### 4. Find the Person with the highest BusinessEntityID and their email address, if available
- **Tables to be used**: `Person`, `EmailAddress`

### 5. Retrieve Persons whose LastName is between 'G' and 'M' and have a BusinessEntityID not in the set of 2, 4, 6
- **Tables to be used**: `Person`

### 6. List Persons who have an email address that does not end with 'example.com' and have a LastName starting with 'J'
- **Tables to be used**: `Person`, `EmailAddress`

### 7. Find the count of distinct LastNames for Persons whose FirstName starts with 'J'
- **Tables to be used**: `Person`

### 8. Retrieve Persons whose BusinessEntityID is in the range of 3 to 8 and whose LastName contains the substring 'son'
- **Tables to be used**: `Person`

### 9. Find Persons with a LastName that starts with 'D' and their corresponding email addresses where the email address contains 'jones'
- **Tables to be used**: `Person`, `EmailAddress`

### 10. List Persons with FirstNames that have more than 4 characters and their LastNames are not 'Smith'
- **Tables to be used**: `Person`

### 11. Find Persons who have an email address with a domain that is neither 'gmail.com' nor 'yahoo.com'
- **Tables to be used**: `EmailAddress`

### 12. Retrieve Persons whose BusinessEntityID is not equal to any BusinessEntityID found in the subquery selecting IDs of Persons with LastNames 'Johnson' or 'Williams'
- **Tables to be used**: `Person`

### 13. List Persons whose FirstName and LastName are both more than 5 characters long
- **Tables to be used**: `Person`

### 14. Retrieve Persons whose BusinessEntityID is greater than the average BusinessEntityID in the table
- **Tables to be used**: `Person`

### 15. Find Persons with LastNames that are the same as any LastName in the set of BusinessEntityIDs 1 through 5
- **Tables to be used**: `Person`

### 16. Retrieve the Person(s) with the most common LastName
- **Tables to be used**: `Person`

### 17. Find Persons with LastNames ending with 'es' and their FirstNames starting with 'L'
- **Tables to be used**: `Person`

### 18. List all Persons where the LastName starts with 'G' and the email address is either NULL or does not contain 'example.com'
- **Tables to be used**: `Person`, `EmailAddress`

### 19. Retrieve Persons with BusinessEntityIDs between 2 and 10 where the LastName contains 'e' or 'a'
- **Tables to be used**: `Person`

### 20. Find Persons whose email addresses are neither NULL nor end with '.org'
- **Tables to be used**: `EmailAddress`

### 21. Retrieve Persons where the FirstName is either 'John' or 'Jane' and the LastName is distinct within this subset
- **Tables to be used**: `Person`

### 22. List Persons whose BusinessEntityID is not in the top 50% by value
- **Tables to be used**: `Person`

### 23. Find Persons whose LastName does not contain the letters 'a' or 'e'
- **Tables to be used**: `Person`

### 24. Retrieve Persons whose BusinessEntityID is in the set of (SELECT BusinessEntityID FROM Person WHERE LastName LIKE '%son%')
- **Tables to be used**: `Person`

### 25. List Persons with LastNames that appear more than once in the database
- **Tables to be used**: `Person`

---

## Answers

### 1. Find Persons who have either a NULL Email Address or a BusinessEntityID greater than 5

```sql
SELECT p.FirstName, p.LastName
FROM Person p
LEFT JOIN EmailAddress e ON p.BusinessEntityID = e.BusinessEntityID
WHERE e.EmailAddress IS NULL
   OR p.BusinessEntityID > 5;
```

### 2. Retrieve Persons who have the same LastName as any other Person with a different BusinessEntityID

```sql
SELECT p1.FirstName, p1.LastName
FROM Person p1
JOIN Person p2 ON p1.LastName = p2.LastName AND p1.BusinessEntityID != p2.BusinessEntityID;
```

### 3. List all distinct combinations of FirstName and LastName for Persons where the FirstName contains 'a' and LastName ends with 'n'

```sql
SELECT DISTINCT FirstName, LastName
FROM Person
WHERE FirstName LIKE '%a%'
  AND LastName LIKE '%n';
```

### 4. Find the Person with the highest BusinessEntityID and their email address, if available

```sql
SELECT p.FirstName, p.LastName, e.EmailAddress
FROM Person p
LEFT JOIN EmailAddress e ON p.BusinessEntityID = e.BusinessEntityID
WHERE p.BusinessEntityID = (SELECT MAX(BusinessEntityID) FROM Person);
```

### 5. Retrieve Persons whose LastName is between 'G' and 'M' and have a BusinessEntityID not in the set of 2, 4, 6

```sql
SELECT FirstName, LastName
FROM Person
WHERE LastName BETWEEN 'G' AND 'M'
  AND BusinessEntityID NOT IN (2, 4, 6);
```

### 6. List Persons who have an email address that does not end with 'example.com' and have a LastName starting with 'J'

```sql
SELECT p.FirstName, p.LastName
FROM Person p
JOIN EmailAddress e ON p.BusinessEntityID = e.BusinessEntityID
WHERE e.EmailAddress NOT LIKE '%@example.com'
  AND p.LastName LIKE 'J%';
```

### 7. Find the count of distinct LastNames for Persons whose FirstName starts with 'J'

```sql
SELECT COUNT(DISTINCT LastName) AS DistinctLastNameCount
FROM Person
WHERE FirstName LIKE 'J%';
```

### 8. Retrieve Persons whose BusinessEntityID is in the range of 3 to 8 and whose LastName contains the substring 'son'

```sql
SELECT FirstName, LastName
FROM Person
WHERE BusinessEntityID BETWEEN 3 AND 8
  AND LastName LIKE '%son%';
```

### 9. Find Persons with a LastName that starts with 'D' and their corresponding email addresses where the email address contains 'jones'

```sql
SELECT p.FirstName, p.LastName, e.EmailAddress
FROM Person p
JOIN EmailAddress e ON p.BusinessEntityID = e.BusinessEntityID
WHERE p.LastName LIKE 'D%'
  AND e.EmailAddress LIKE '%jones%';
```

### 10.

 List Persons with FirstNames that have more than 4 characters and their LastNames are not 'Smith'

```sql
SELECT FirstName, LastName
FROM Person
WHERE LEN(FirstName) > 4
  AND LastName != 'Smith';
```

### 11. Find Persons who have an email address with a domain that is neither 'gmail.com' nor 'yahoo.com'

```sql
SELECT EmailAddress
FROM EmailAddress
WHERE EmailAddress NOT LIKE '%@gmail.com'
  AND EmailAddress NOT LIKE '%@yahoo.com';
```

### 12. Retrieve Persons whose BusinessEntityID is not equal to any BusinessEntityID found in the subquery selecting IDs of Persons with LastNames 'Johnson' or 'Williams'

```sql
SELECT FirstName, LastName
FROM Person
WHERE BusinessEntityID NOT IN (
    SELECT BusinessEntityID
    FROM Person
    WHERE LastName IN ('Johnson', 'Williams')
);
```

### 13. List Persons whose FirstName and LastName are both more than 5 characters long

```sql
SELECT FirstName, LastName
FROM Person
WHERE LEN(FirstName) > 5
  AND LEN(LastName) > 5;
```

### 14. Retrieve Persons whose BusinessEntityID is greater than the average BusinessEntityID in the table

```sql
SELECT FirstName, LastName
FROM Person
WHERE BusinessEntityID > (SELECT AVG(BusinessEntityID) FROM Person);
```

### 15. Find Persons with LastNames that are the same as any LastName in the set of BusinessEntityIDs 1 through 5

```sql
SELECT FirstName, LastName
FROM Person
WHERE LastName IN (
    SELECT LastName
    FROM Person
    WHERE BusinessEntityID BETWEEN 1 AND 5
);
```

### 16. Retrieve the Person(s) with the most common LastName

```sql
SELECT FirstName, LastName
FROM Person
WHERE LastName = (
    SELECT TOP 1 LastName
    FROM Person
    GROUP BY LastName
    ORDER BY COUNT(*) DESC
);
```

### 17. Find Persons with LastNames ending with 'es' and their FirstNames starting with 'L'

```sql
SELECT FirstName, LastName
FROM Person
WHERE LastName LIKE '%es'
  AND FirstName LIKE 'L%';
```

### 18. List all Persons where the LastName starts with 'G' and the email address is either NULL or does not contain 'example.com'

```sql
SELECT p.FirstName, p.LastName
FROM Person p
LEFT JOIN EmailAddress e ON p.BusinessEntityID = e.BusinessEntityID
WHERE p.LastName LIKE 'G%'
  AND (e.EmailAddress IS NULL OR e.EmailAddress NOT LIKE '%@example.com');
```

### 19. Retrieve Persons with BusinessEntityIDs between 2 and 10 where the LastName contains 'e' or 'a'

```sql
SELECT FirstName, LastName
FROM Person
WHERE BusinessEntityID BETWEEN 2 AND 10
  AND (LastName LIKE '%e%' OR LastName LIKE '%a%');
```

### 20. Find Persons whose email addresses are neither NULL nor end with '.org'

```sql
SELECT EmailAddress
FROM EmailAddress
WHERE EmailAddress IS NOT NULL
  AND EmailAddress NOT LIKE '%.org';
```

### 21. Retrieve Persons where the FirstName is either 'John' or 'Jane' and the LastName is distinct within this subset

```sql
SELECT DISTINCT LastName
FROM Person
WHERE FirstName IN ('John', 'Jane');
```

### 22. List Persons whose BusinessEntityID is not in the top 50% by value

```sql
SELECT FirstName, LastName
FROM Person
WHERE BusinessEntityID <= (
    SELECT MAX(BusinessEntityID) * 0.5
    FROM Person
);
```

### 23. Find Persons whose LastName does not contain the letters 'a' or 'e'

```sql
SELECT FirstName, LastName
FROM Person
WHERE LastName NOT LIKE '%a%'
  AND LastName NOT LIKE '%e%';
```

### 24. Retrieve Persons whose BusinessEntityID is in the set of (SELECT BusinessEntityID FROM Person WHERE LastName LIKE '%son%')

```sql
SELECT FirstName, LastName
FROM Person
WHERE BusinessEntityID IN (
    SELECT BusinessEntityID
    FROM Person
    WHERE LastName LIKE '%son%'
);
```

### 25. List Persons with LastNames that appear more than once in the database

```sql
SELECT LastName
FROM Person
GROUP BY LastName
HAVING COUNT(*) > 1;
```

