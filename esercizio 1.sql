-- esploro la tabella dimproduct
SELECT *
FROM dimproduct;

-- seleziono i seguenti valori

SELECT
	ProductKey,
    ProductAlternateKey,
    EnglishProductName,
    Color,
    StandardCost,
    FinishedGoodsFlag
FROM dimproduct;

-- seleziono i prodotti finiti
SELECT
	ProductKey,
    ProductAlternateKey,
    EnglishProductName,
    Color,
    StandardCost,
    FinishedGoodsFlag
FROM dimproduct
WHERE FinishedGoodsFlag = 1;

-- prodotti il cui codice modello comincia con 'FR' o 'BK'
SELECT
	ProductKey,
    ProductAlternateKey,
    EnglishProductName,
    StandardCost,
    ListPrice,
    ListPrice - StandardCost AS DiffListPrice_StandardCost
FROM dimproduct
WHERE ProductAlternateKey LIKE 'FR%' OR ProductAlternateKey LIKE 'BK%';


-- prodotti finiti con list price compreso tra 1000 e 2000
SELECT *
FROM dimproduct
WHERE 
	ListPrice between 1000 AND 2000
AND FinishedGoodsFlag = 1
;

-- esploro la tabella DimEmployee
SELECT *
FROM dimemployee;

-- query con i soli agenti
SELECT *
FROM dimemployee
WHERE SalesPersonFlag = 1;

-- queery tabella vendite 
SELECT 
SalesOrderNumber,
SalesOrderLineNumber,
OrderDate,
ShipDate,
ProductKey,
ResellerKey,
PromotionKey,
EmployeeKey,
SalesTerritoryKey,
OrderQuantity,
UnitPrice,
TotalProductCost,
SalesAmount,
SalesAmount - TotalProductCost AS DiffSalesAmount_TotalProductCost
FROM factresellersales

WHERE ShipDate LIKE '%2020%'
 AND ProductKey IN ('597', '598', '477', '214');
 
 
