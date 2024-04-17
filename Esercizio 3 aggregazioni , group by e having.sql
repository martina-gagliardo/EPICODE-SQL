-- Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria.
select count(*)
from dimproduct
group by productkey
having count(*)<1


-- Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK

select f.salesordernumber, count(*) as conta 
from factresellersales f  
group by f.salesordernumber 
having count(*)>0

select f.salesorderlinenumber, count(*) as conta 
from factresellersales f  
group by f.salesorderlinenumber 
having count(*)>0 



-- Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.
select 
count( salesorderlinenumber) as transazioni, orderdate
from factresellersales 
group by Orderdate
having Orderdate >= '2020-01-01'


-- Calcola il fatturato totale (FactResellerSales.SalesAmount), la quantità totale venduta (FactResellerSales.OrderQuantity) e
-- il prezzo medio di vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct) a partire dal 1 Gennaio 2020. 
-- Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita.


select  dp.englishproductname, orderdate,
sum(salesamount) as fatturato_totale, 
sum(orderquantity) as quantità_venduta,
avg(unitprice) as mediavendita
from factresellersales as frs
inner join dimproduct as dp
on frs.productkey = dp.productkey
where  Orderdate >= '2020-01-01'
group by dp.englishproductname

-- Calcola il fatturato totale (FactResellerSales.SalesAmount) e la quantità totale venduta (FactResellerSales.OrderQuantity) per Categoria prodotto (DimProductCategory).
 -- Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale venduta. 
 

select dpc.ProductCategoryKey, dpc.englishproductcategoryname,
sum(f.SalesAmount) as TotaleFatturato, 
sum(f.OrderQuantity) as QuantitaVenduta 
from factresellersales f  
inner join dimproduct d  
on f.ProductKey = d.ProductKey 
inner join dimproductcategory dpc 
on d.ProductSubcategoryKey = dpc.ProductCategoryKey  
where 1 =1 
group by dpc.ProductCategoryKey, dpc.englishproductcategoryname 


-- Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020
-- Il result set deve esporre l’elenco delle città con fatturato realizzato superiore a 60K. 


select g.City,
sum(f.SalesAmount) as fatturatototale
from factresellersales as f
inner join dimgeography as g
on f.salesterritorykey = g.salesterritorykey
where Orderdate >= '2020-01-01'
group by g.city
having sum(f.salesamount) >60000
order by sum(f.salesamount) desc



 
 

 








