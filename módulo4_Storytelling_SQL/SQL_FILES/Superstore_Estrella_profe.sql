-- D_Customer

CREATE TABLE `d_customer` (
  `id_customer` int NOT NULL AUTO_INCREMENT,
  `customername` varchar(80) NOT NULL,
  `segment` varchar(45) NOT NULL,
  PRIMARY KEY (`id_customer`)
) ENGINE=InnoDB AUTO_INCREMENT=2047 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Esta es mi tabla de maestro de clientes';

insert into d_customer (segment, customername)
select distinct segment as campo1, customername as campo2
from stagingsuperstore order by 1,2;

select * from d_customer;

-- D_Product
CREATE TABLE `superstore`.`d_product` (
  `id_product` INT NOT NULL AUTO_INCREMENT,
  `productname` VARCHAR(80) NOT NULL,
  `manufacturer` VARCHAR(45) NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  `subcategory` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_product`));

insert into d_product(productname, manufacturer, category, subcategory) 
select distinct productname, manufacturer, category, subcategory
from stagingsuperstore order by 1;

select * from d_product;

-- D_Shipmode
CREATE TABLE `superstore`.`d_shipmode` (
  `id_shipmode` INT NOT NULL AUTO_INCREMENT,
  `shipmode` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_shipmode`));

insert into d_shipmode (shipmode)
select distinct shipmode from stagingsuperstore order by 1;

select * from d_shipmode;
-- D_Geo
CREATE TABLE `superstore`.`d_geo` (
  `id_geo` INT NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_geo`));
  
  insert into d_geo (country, city)
  select distinct country, city from stagingsuperstore
  order by 1,2;
  
  select * from d_geo;
  
  -- F_Ventas
  CREATE TABLE `superstore`.`f_ventas` (
  `id_order` VARCHAR(25) NOT NULL,
  `id_customer` INT NOT NULL,
  `id_geo` INT NOT NULL,
  `id_product` INT NOT NULL,
  `id_shipmode` INT NOT NULL,
  `orderdate` DATE NOT NULL,
  `shipdate` DATE NOT NULL,
  `sales` INT NOT NULL DEFAULT 0,
  `costs` INT NOT NULL DEFAULT 0,
  `margin` INT NOT NULL DEFAULT 0,
  `duracion` FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_order`));
  
  insert into f_ventas 
  select orderid, c.id_customer, g.id_geo, p.id_product, sm.id_shipmode, 
  orderdate, shipdate, sales, cost, sales-cost as margin,  datediff(shipdate, orderdate) as duracion
  from stagingsuperstore sss
  join d_customer c on sss.customername=c.customername and sss.segment=c.segment
  join d_geo g on sss.city=g.city and sss.country=g.country
  join d_product p on sss.productname=p.productname
  join d_shipmode sm on sss.shipmode=sm.shipmode;
  
  select * from f_ventas;
  
  select * from f_ventas v join d_customer c on v.id_customer=c.id_customer;
  
  select c.segment, sum(sales) from f_ventas v join d_customer c on v.id_customer=c.id_customer
  group by c.segment
  ;