-- Ejercicio 2 - PK talon
-- Comprobamos cero repeticiones
select talon, referencia, count(*) from venta
group by talon, referencia
having count(*)>1
;

select talon, count(*) from venta
group by talon
having count(*)>1
;

-- Ejercicio 3 - Artículos sin venta
select distinct a.referencia from articulo a left join venta v on a.referencia=v.referencia
where v.talon is null;

select * from articulo where referencia not in (select distinct referencia from venta);

-- Ejercicio 4 - Artículos no en campañas de 2015
select * from articulo where referencia not in (
select distinct referencia from campanias ca 
join depto_campania dc on ca.id_campania=dc.id_campania
join articulo a on dc.id_dpto=a.id_dpto
where year(fecha_camp)=2015);

-- Ejercicio 5 - Clasificación de ventas

select *,
case when precio between 0 and 15 then 'Importe bajo'
when precio between 15 and 80 then 'Importe medio'
when precio>80 then 'Importe alto'
else 'Importe negativo'
end as clasificacion
 from venta;
 
 -- Ejercicio 6 - Clasificación de ventas 2
 select *, case when precio>media then 'Mayor' else 'Menor' end as clasificacion from venta cross join 
 (select avg(precio) as media from venta) t1;
 
 -- Ejercicio 7 - Media por referencia + global
 
select referencia, avg(precio) as media from venta group by referencia
union
select 'Total', avg(precio) as media from venta;

-- Ejercicio 8 - Variación respecto al máximo
select *, precio-maxprecio as diferencia from venta v join 
(select referencia, max(precio) as maxprecio from venta group by referencia) t1 on v.referencia=t1.referencia;

-- Ejercicio 9 - Clasificación de campañas
select *,
case when month(fecha_camp) between 3 and 8 then concat('PV', year(fecha_camp))
when month(fecha_camp)>8 then concat('OI', year(fecha_camp))
else concat('OI', year(fecha_camp)-1) end as temporada
 from campanias;
 
 -- Ejercicio 10 - Comparativa anual
 select *,
 round(100*case when t2.ventas is null then 0 
 when t2.ventas=0 then 0
 else 
 (t1.ventas-t2.ventas)/t2.ventas end, 2) as variacion
 from 
 (select year(fecha_venta) as anio, sum(precio) as ventas from venta group by year(fecha_venta)) t1
 left join
  (select year(fecha_venta) as anio, sum(precio) as ventas from venta group by year(fecha_venta)) t2
  on t1.anio=t2.anio+1 order by 1;