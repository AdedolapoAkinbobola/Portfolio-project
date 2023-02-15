/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [UniqueID ]
      ,[ParcelID]
      ,[LandUse]
      ,[PropertyAddress]
      ,[SaleDate]
      ,[SalePrice]
      ,[LegalReference]
      ,[SoldAsVacant]
      ,[OwnerName]
      ,[OwnerAddress]
      ,[Acreage]
      ,[TaxDistrict]
      ,[LandValue]
      ,[BuildingValue]
      ,[TotalValue]
      ,[YearBuilt]
      ,[Bedrooms]
      ,[FullBath]
      ,[HalfBath]
  FROM [portofolio project].[dbo].[Housing]

  Cleaning Data In SQL Queries

  Select *
  From [portofolio project]..Housing

  ----Standardise Date Format

  Select SaleDateConverted, Convert (Date,SaleDate)
  From [portofolio project]..Housing

  Update Housing
  SET SaleDate = Convert (Date,SaleDate)

  ALTER TABLE Housing
  Add SaleDateConverted Date;

  Update Housing
  SET SaleDateConverted = Convert (Date,SaleDate)

  ---- Populate Property Address data

  Select *
  From [portofolio project]..Housing
  Where PropertyAddress is null

  Select PropertyAddress
  From [portofolio project]..Housing
  Where PropertyAddress is null

  Select *
  From [portofolio project]..Housing
  order by ParcelID

  Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
  From [portofolio project]..Housing a
  JOIN [portofolio project]..Housing b
  on a.ParcelID = b.ParcelID
  AND a.UniqueID <> b.UniqueID
  Where a.PropertyAddress is null

  Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
  From [portofolio project]..Housing a
  JOIN [portofolio project]..Housing b
  on a.ParcelID = b.ParcelID
  AND a.UniqueID <> b.UniqueID
  Where a.PropertyAddress is null

  Update a
  SET propertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
  From [portofolio project]..Housing a
  JOIN [portofolio project]..Housing b
  on a.ParcelID = b.ParcelID
  AND a.UniqueID <> b.UniqueID
  Where a.PropertyAddress is null

  Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
  From [portofolio project]..Housing a
  JOIN [portofolio project]..Housing b
  on a.ParcelID = b.ParcelID
  AND a.UniqueID <> b.UniqueID
  Where a.PropertyAddress is null

  -----Breaking out Address into Individual Columns (Address, City, State)

  Select PropertyAddress
  From [portofolio project]..Housing
  
  SELECT 
  SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)) as Address,
  CHARINDEX(',', PropertyAddress)
  From [portofolio project]..Housing

  SELECT 
  SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
  From [portofolio project]..Housing

  SELECT 
  SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
  SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN( PropertyAddress))as City
  From [portofolio project]..Housing

  ALTER TABLE Housing
  Add PropertySplitAddress varchar(255);

  Update Housing
  SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) 

ALTER TABLE Housing
  Add PropertySplitCity varchar(255);

  Update Housing
  SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN( PropertyAddress))

  Select *
  From [portofolio project]..Housing


Select OwnerAddress
  From [portofolio project]..Housing

  Select 
  PARSENAME (REPLACE(OwnerAddress,',','.'), 1) 
  From [portofolio project]..Housing

  Select 
  PARSENAME (REPLACE(OwnerAddress,',','.'), 3),PARSENAME (REPLACE(OwnerAddress,',','.'), 2), PARSENAME (REPLACE(OwnerAddress,',','.'), 1)
  From [portofolio project]..Housing

  ALTER TABLE Housing
  Add OwnerSplitAddress varchar(255);

  Update Housing
  SET OwnerSplitAddress = PARSENAME (REPLACE(OwnerAddress,',','.'), 3)

ALTER TABLE Housing
  Add OwnerSplitCity varchar(255);

  Update Housing
  SET OwnerSplitCity =PARSENAME (REPLACE(OwnerAddress,',','.'), 2)

  ALTER TABLE Housing
  Add OwnerSplitState varchar(255);

  Update Housing
  SET OwnerSplitState =PARSENAME (REPLACE(OwnerAddress,',','.'), 1)

 
 ----Change Y and N to YES and NO in "Sold as Vacant" field

 Select Distinct(SoldAsVacant), Count(SoldAsVacant)
 From [portofolio project]..Housing
 Group by SoldAsVacant
 order by 2

 Select SoldAsVacant,
CASE when SoldAsVacant = 'Y' THEN 'YES' when SoldAsVacant = 'N' THEN 'NO'
ELSE SoldAsVacant
END
 From [portofolio project]..Housing

 Update Housing
 SET SoldAsVacant = CASE when SoldAsVacant = 'Y' THEN 'YES' when SoldAsVacant = 'N' THEN 'NO'
ELSE SoldAsVacant
END

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
 From [portofolio project]..Housing
 Group by SoldAsVacant
 order by 2


 -----Remove Duplicates

 WITH RowNumCTE AS(
 Select *, 
    ROW_NUMBER() OVER( PARTITION BY ParcelID, PropertyAddress,SalePrice,SaleDate,LegalReference
	     ORDER BY UniqueID) row_num                     
 From [portofolio project]..Housing
 )
 SELECT *
 From RowNumCTE
 where row_num > 1
 order by PropertyAddress

 WITH RowNumCTE AS(
 Select *, 
    ROW_NUMBER() OVER( PARTITION BY ParcelID, PropertyAddress,SalePrice,SaleDate,LegalReference
	     ORDER BY UniqueID) row_num                     
 From [portofolio project]..Housing
 )
 DELETE
 From RowNumCTE
 where row_num > 1

 WITH RowNumCTE AS(
 Select *, 
    ROW_NUMBER() OVER( PARTITION BY ParcelID, PropertyAddress,SalePrice,SaleDate,LegalReference
	     ORDER BY UniqueID) row_num                     
 From [portofolio project]..Housing
 )
 SELECT *
 From RowNumCTE
 where row_num > 1
 order by PropertyAddress

 ---Delete Unused Columns

 Select *
  From [portofolio project]..Housing

  ALTER TABLE [portofolio project]..Housing
  DROP COLUMN OwnerAddress,TaxDistrict, PropertyAddress

ALTER TABLE [portofolio project]..Housing
  DROP COLUMN SaleDate

  Select *
  From [portofolio project]..Housing

