-- 2 ¿Cómo comprobaría que para la tabla de ‘VENTA’, la clave primaria formada por ‘TALON, REFERENCIA’ es correcta?
-- Viendo que no tenga nulos o duplicados


-- 2 ¿Qué consulta generaría si quisiéramos modificar la tabla y que la clave primaria fuera solo el campo ‘TALON’?
ALTER TABLE `examensql`.`venta` 
DROP PRIMARY KEY,
ADD PRIMARY KEY (`talon`);
;


-- 3.Genera una consulta que obtenga la lista ordenada de todas las referencias sin venta
SELECT referencia AS referencias_sin_venta
FROM articulo
WHERE referencia NOT IN (SELECT referencia FROM venta)
ORDER BY referencia
;


-- 4.Genera una consulta que obtenga la lista de referencias que no han participado en campañas hechas en el año 2015
SELECT c.id_campania, a.referencia, c.fecha_camp
FROM articulo a
JOIN depto_campania dc ON dc.id_dpto = a.id_dpto
JOIN campanias c ON c.id_campania = dc.id_campania
WHERE c.fecha_camp NOT LIKE '2015%'
ORDER BY 1
;


-- 5.Clasifique las ventas según su importe de acuerdo con el siguiente criterio:
SELECT precio,
       CASE
           WHEN precio >= 0 AND precio <= 15 THEN 'importe bajo'
           WHEN precio > 15 AND precio <= 80 THEN 'importe medio'
           ELSE 'importe alto'
       END AS clasificacion
FROM venta;


-- 6.Clasifique todas las ventas en Mayor, Igual o Menor precio
-- respecto a la media de los precios de todas las ventas realizadas
SELECT talon, precio,
       CASE
           WHEN precio > (SELECT AVG(precio) FROM venta) THEN 'Mayor'
           WHEN precio = (SELECT AVG(precio) FROM venta) THEN 'Igual'
           ELSE 'Menor'
       END AS clasificacion
FROM venta
;


-- 7.Cree una tabla que contenga, para cada referencia, el precio medio de todas sus ventas;
-- además de la media global de importes de todas las ventas.
SELECT referencia, AVG(precio) AS precio_medio
FROM venta
GROUP BY referencia;

SELECT referencia, AVG(precio) AS precio_medio, (SELECT AVG(precio) FROM venta) AS media_global
FROM venta
GROUP BY referencia;

CREATE TABLE tabla_precio_medio AS
SELECT referencia, AVG(precio) AS precio_medio
FROM venta
GROUP BY referencia;

ALTER TABLE tabla_precio_medio ADD COLUMN media_global DECIMAL(10,2);

UPDATE tabla_precio_medio
SET media_global = (SELECT AVG(precio) FROM venta);

SELECT * FROM tabla_precio_medio;


-- 8.A partir de la tabla de venta, genere una query con referencia, fecha_venta, precio
-- y la diferencia entre el precio y el max_precio por referencia.
SELECT referencia, fecha_venta, precio, precio - (
    SELECT MAX(precio)
    FROM venta v2
    WHERE v1.referencia = v2.referencia
) AS diferencia
FROM venta v1;




