SELECT NationalIDNumber
FROM HumanResources.Employee

SELECT NationalIDNumber, JobTitle
FROM HumanResources.Employee

SELECT TOP 20 PERCENT NationalIDNumber, JobTitle, BirthDate 
FROM HumanResources.Employee

SELECT TOP 500 
    NationalIDNumber AS "SSN" , 
	JobTitle AS "Job Title", 
	BirthDate
FROM HumanResources.Employee

SELECT *
FROM Sales.SalesOrderHeader

SELECT TOP 50 *
FROM Sales.Customer

SELECT 
 Name AS "Product's Name"
FROM Production.vProductAndDescription

SELECT *
FROM HumanResources.Department

SELECT *
FROM Production.BillOfMaterials

SELECT TOP 1500 *
FROM Sales.vPersonDemographics

SELECT FirstName, LastName
FROM Person.Person
WHERE FirstName = 'Mark'

SELECT TOP 100 *
FROM Production.Product
WHERE ListPrice <> 0.00

SELECT *
FROM HumanResources.vEmployee
WHERE LastName <'D%'

SELECT * 
FROM Person.StateProvince
WHERE CountryRegionCode = 'CA'

SELECT FirstName AS "Customer First Name", LastName AS "Customer Last Name"
FROM Sales.vIndividualCustomer
WHERE LastName = 'smith'

SELECT *
FROM Sales.vIndividualCustomer
WHERE CountryRegionName = 'Australia' OR 
(PhoneNumberType = 'Cell' AND EmailPromotion = 0)

SELECT *
FROM HumanResources.vEmployeeDepartment
WHERE Department IN ('Exective', 'ToolDesign', 'Engineering')

SELECT *
FROM HumanResources.vEmployeeDepartment
WHERE Department = 'Exective' OR Department = 'Tool Design' OR Department ='Engineering'

SELECT *
FROM HumanResources.vEmployeeDepartment
WHERE StartDate BETWEEN '7/1/2000' AND '6/30/2002'

SELECT *
FROM HumanResources.vEmployeeDepartment
WHERE StartDate >= '7/1/2000' AND StartDate <= '6/30/2002'

SELECT *
FROM Sales.vIndividualCustomer
WHERE LastName LIKE 'R%'

SELECT *
FROM Sales.vIndividualCustomer
WHERE LastName LIKE '%r'

SELECT *
FROM Sales.vIndividualCustomer
WHERE LastName IN ('Lopez','Martin', 'Wood') AND FirstName LIKE '[C-L ]%'

SELECT *
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL

SELECT SalesPersonID, TotalDue
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL AND TotalDue > 70000

SELECT FirstName, LastName, JobTitle
FROM HumanResources.vEmployeeDepartment
ORDER BY FirstName ASC


SELECT FirstName, LastName, JobTitle
FROM HumanResources.vEmployeeDepartment
ORDER BY FirstName ASC, LastName DESC

SELECT FirstName, LastName, CountryRegionName
FROM Sales.vIndividualCustomer
ORDER BY 3

SELECT FirstName, LastName, CountryRegionName
FROM Sales.vIndividualCustomer
WHERE CountryRegionName IN ('United States' , 'France')
ORDER BY CountryRegionName

SELECT 
   Name, AnnualSales, YearOpened, SquareFeet AS [Store Size], NumberEmployees AS [Total Employees]
FROM Sales.vStoreWithDemographics
WHERE AnnualSales > 1000000 AND NumberEmployees >= 45
ORDER BY [Store Size] DESC, [Total Employees] DESC

