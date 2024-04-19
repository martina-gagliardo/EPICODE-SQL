use AdventureWorksDW

-- Esponi l’anagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria (DimProduct, DimProductSubcategory).
select *
from dimproductsubcategory;

select * 
from dimproduct;

select  dp.ProductKey,
		dp.ProductAlternateKey,
        dp.ProductSubcategoryKey,
        dp.SizeUnitMeasureCode,
        dp.EnglishDescription,
        dp.StandardCost,
        dp.FinishedGoodsFlag,
        dp.Color, 
        dp.DealerPrice,
        dp.SafetyStockLevel,
        dps.ProductSubcategoryKey,
        dps.ProductSubcategoryAlternateKey,
        dps.EnglishProductSubcategoryName
 from dimproduct as dp
 inner join dimproductsubcategory as dps 
 on dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
 
-- Esponi l’anagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria (DimProduct, DimProductSubcategory, DimProductCategory).

select dp.productkey as CodiceSeriale, 
dp.WeightUnitMeasureCode,
dp.FinishedGoodsFlag, 
dp.Color as Colore,
dp.listprice,  
dp.DealerPrice as PrezzoDealer, 
dp.SafetyStockLevel, 
dps.ProductSubcategoryKey,
dps.ProductSubcategoryAlternateKey as Sottocategoria, 
dps.EnglishProductSubcategoryName, 
dpc.ProductCategoryAlternateKey, 
dpc.ProductCategoryKey as Categoria 
from dimproduct as dp  
inner join dimproductsubcategory as dps 
on dp.ProductSubcategoryKey = dps.ProductSubcategoryKey 
inner join dimproductcategory dpc  
on dps.productcategorykey = dpc.ProductCategoryKey 

-- Esponi l’elenco dei soli prodotti venduti (DimProduct, FactResellerSales). 


select  frs.ProductKey,
        dp.productkey,
        frs.salesordernumber,
        frs.orderdate 
from dimproduct as dp
inner join factresellersales as frs
on dp.productkey = frs.productkey


-- 3b.Esponi l’elenco dei soli prodotti non venduti (DimProduct, FactResellerSales).  
  
select * 
from dimproduct as dp  
left join factresellersales as frs  
ON dp.ProductKey = frs.ProductKey 
where frs.ProductKey is null   


-- Esponi l’elenco dei prodotti non venduti (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1).

select dp.ProductKey,dp.ProductAlternateKey,dp.ProductLine  
from factresellersales as frs 
right join dimproduct as dp
on  frs.ProductKey = dp.ProductKey
where dp.FinishedGoodsFlag = 1
and frs.Salesordernumber is null

-- altra soluzione subquery  


select dp.ProductKey,dp.ProductAlternateKey,dp.ProductLine  
from dimproduct as dp  
where dp.FinishedGoodsFlag = 1  
and ProductKey  not in ( select ProductKey 
                        from factresellersales as frs 
						where frs.salesordernumber is not null 
                        ) 
                        
		

-- Esponi l’elenco delle transazioni di vendita (FactResellerSales) indicando anche il nome del prodotto venduto (DimProduct)


select dp.modelname, dp.englishproductname as descrizione, SalesOrderNumber as OrdineNumero, frs.OrderDate, frs.OrderQuantity,frs.UnitPrice  
from factresellersales as frs 
inner join dimproduct as dp
on frs.productkey = dp.productkey 
 
 
 -- 7 Esplora la tabella DimReseller. 


select ResellerKey, 
BusinessType,  
ResellerName,  
AddressLine1, 
ResellerAlternateKey  
from dimreseller as dp  
; 

-- Esponi in output l’elenco dei reseller indicando, per ciascun reseller, anche la sua area geografica.

select GeographyKey,
	resellername as nome,
    resellerkey as area
    from dimreseller
    
    -- Esponi l’elenco delle transazioni di vendita. Il result set deve esporre i campi: SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost.
    -- Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e l’area geografica
    
    select f.SalesOrderNumber,
	f.SalesOrderLineNumber,
    f.UnitPrice,
    f.OrderQuantity,
    f.TotalProductCost,
	p.englishproductname,
    d.resellername
    from factresellersales as f
    inner join dimreseller as d
    on f.resellerkey = d.resellerkey 
    inner join dimproduct as p
    on f.productkey = p.productkey 
    
    

