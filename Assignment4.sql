Select * from(
Select StoreZip, TimeMonth, sum(salesdollar) as sumsales, min(SalesDollar) as minsales, count(*) as rowcount 
from Store natural join Sales natural join TimeDim 
where TimeYear = 2014 and storenation in ('USA', 'UK')
group by StoreZip,TimeMonth order by StoreZip)as a
where a.rowcount>1;


Select * from(
Select StoreZip, TimeMonth, sum(salesdollar) as sumsales, min(SalesDollar) as minsales, count(*) as rowcount 
from Store natural join Sales natural join TimeDim 
where TimeYear = 2015 and storenation in('UK', 'Canada')
group by cube(StoreZip,TimeMonth) order by StoreZip,timemonth)as a
where a.rowcount>1;

Select StoreZip, TimeMonth, sum(salesdollar) as sumsales
from Store natural join Sales natural join TimeDim 
where TimeYear = 2016 and storenation in('USA', 'Canada')
group by cube(StoreZip),TimeMonth order by StoreZip,timemonth;


Select StoreZip, TimeMonth, sum(salesdollar) as sumsales
from Store natural join Sales natural join TimeDim 
where TimeYear = 2016 and storenation in('USA', 'UK')
group by grouping sets(StoreZip,timemonth,()) order by StoreZip,timemonth;


Select timeyear, TimeMonth, sum(salesdollar) as sumsales, min(SalesDollar) as minsales, count(*) as rowcount 
from Store natural join Sales natural join TimeDim 
where TimeYear in(2016, 2017) and storenation in('USA', 'Canada')
group by rollup(timeyear,TimeMonth) order by timeyear,timemonth;


Select StoreZip, Timeyear, sum(salesdollar) as sumsales, sum(sum(salesdollar)) over (order by storezip, timeyear rows unbounded preceding) as cumsales
from Store natural join Sales natural join TimeDim 
group by storezip,timeyear order by StoreZip,timeyear;

Select StoreZip, Timeyear, sum(salesdollar) as sumsales, sum(sum(salesdollar)) over (partition by storezip rows unbounded preceding) as cumsales
from Store natural join Sales natural join TimeDim 
group by storezip,timeyear order by StoreZip,timeyear;


Select StoreZip, Timeyear, sum(salesdollar) as sumsales, avg(sum(salesdollar)) over (order by storezip, timeyear rows between 1 preceding and 1 following) as centermovavgsumsales
from Store natural join Sales natural join TimeDim 
group by storezip,timeyear order by StoreZip,timeyear;


Select StoreZip, Timeyear, sum(salesdollar) as sumsales, avg(sum(salesdollar)) over (partition by storezip rows between 1 preceding and 1 following) as centermovavgsumsales
from Store natural join Sales natural join TimeDim 
group by storezip,timeyear order by StoreZip,timeyear;


Select custstate, custname,sum(salesdollar) as sumsales, 
rank() over(partition by custstate order by sum(salesdollar) desc) 
from customer natural join sales group by custstate, custname;


Select itemid, itembrand, itemunitprice, 
rank() over(order by itemunitprice asc) 
from Item group by itemid, itembrand, itemunitprice;

Select custzip, sum(salesunits) as sumsalesunits,
rank() over(order by sum(salesunits) desc) as surank,
dense_rank() over(order by sum(salesunits) desc) as sudenserank,
ntile(4) over(order by sum(salesunits) desc) as suntile,
row_number() over(order by sum(salesunits) desc) as surownum
from customer natural join sales group by custzip;


Create view item_time_sales as
select * from item natural join sales natural join timedim;

Select itembrand,salesunits,salesdollar,salescost,timeyear from item_time_sales where itembrand = 'Connex' and Timeyear between 2014 and 2016 group by itembrand,salesunits,salesdollar,salescost, timeyear order by timeyear;