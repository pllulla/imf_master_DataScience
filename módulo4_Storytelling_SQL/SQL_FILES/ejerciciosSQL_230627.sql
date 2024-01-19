select country, sales,
case when country='United Kingdom' then 'Habla inglés' else 'No habla inglés' end as idioma,
case when sales>50 and sales<100 then 'Buena venta' else 'mala venta' end as evalventa,

case when country='France' then
	case when sales>50 then 'Oh la la!' else 'Mon dieu!' end
    else 'No parle française' end as evalventa2,
    
case when country='United Kingdom' then 'Habla inglés'
	when country='France' then 'Habla francés'
    when country='Spain' then 'Habla español'
    else 'Habla otro idioma'
    end as idioma

 from stagingsuperstore;
 
 select * from stagingsuperstore;
 
 update stagingsuperstore
 set country='UK', city='London'
 where country='United Kingdom' and CP='66666';
 
 select orderdate, year(orderdate), month(orderdate), day(orderdate),
 makedate(year(orderdate), (month(orderdate)*30)+day(orderdate))
 from stagingsuperstore;
 
 select substring(customername, 1, 5) as nombre,
 concat(country, city, '000000') as geo
 from stagingsuperstore;
 
