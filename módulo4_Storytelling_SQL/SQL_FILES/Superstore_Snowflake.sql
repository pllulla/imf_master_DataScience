-- d_segment + d_customer
CREATE TABLE `superstore`.`d_segment` (
  `id_segment` INT NOT NULL AUTO_INCREMENT,
  `segment` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_segment`));
  
  insert into d_segment (segment)
  select distinct segment from stagingsuperstore;
  
  select * from d_segment;
  
  CREATE TABLE `superstore`.`d_customer` (
  `id_customer` INT NOT NULL AUTO_INCREMENT,
  `customername` VARCHAR(80) NOT NULL,
  `id_segment` INT NOT NULL,
  PRIMARY KEY (`id_customer`));

insert into d_customer (customername, id_segment)
select distinct sss.customername, s.id_segment
from stagingsuperstore sss join d_segment s on sss.segment=s.segment;

select * from d_customer;

-- d_country + d_city
CREATE TABLE `superstore`.`d_country` (
  `id_country` INT NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_country`));
  
  insert into d_country (country)
  select distinct country from stagingsuperstore order by 1;
  
  select * from d_country;
  
  CREATE TABLE `superstore`.`d_city` (
  `id_city` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(45) NOT NULL,
  `id_country` INT NOT NULL,
  PRIMARY KEY (`id_city`));

insert into d_city (city, id_country)
select distinct  sss.city, co.id_country from stagingsuperstore sss
join d_country co on sss.country=co.country
order by 1,2;

select * from d_city;

-- d_product, d_category, d_subcategory, d_manufacturer
CREATE TABLE `superstore`.`d_manufacturer` (
  `id_manufacturer` INT NOT NULL AUTO_INCREMENT,
  `manufacturer` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_manufacturer`));

insert into d_manufacturer (manufacturer)
select distinct manufacturer from stagingsuperstore order by 1;

select * from d_manufacturer;

CREATE TABLE `superstore`.`d_category` (
  `id_category` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_category`));

insert into d_category (category)
select distinct category from stagingsuperstore order by 1;

select * from d_category;

CREATE TABLE `superstore`.`d_subcategory` (
  `id_subcategory` INT NOT NULL AUTO_INCREMENT,
  `subcategory` VARCHAR(45) NOT NULL,
  `id_category` INT NOT NULL,
  PRIMARY KEY (`id_subcategory`));
  
  insert into d_subcategory (subcategory, id_category)
  select distinct subcategory, c.id_category from stagingsuperstore sss
  join d_category c on sss.category=c.category
  ;

select * from d_subcategory;

CREATE TABLE `superstore`.`d_product` (
  `id_product` INT NOT NULL AUTO_INCREMENT,
  `id_subcategory` INT NOT NULL,
  `id_manufacturer` INT NOT NULL,
  `productname` VARCHAR(85) NOT NULL,
  PRIMARY KEY (`id_product`));
  
  insert into d_product (id_subcategory, id_manufacturer, productname)
  select distinct c.id_subcategory, m.id_manufacturer, sss.productname from stagingsuperstore sss
  join d_subcategory c on sss.subcategory=c.subcategory
  join d_manufacturer m on sss.manufacturer=m.manufacturer
  ;
  
  select * from d_product;
  
  -- d_shipmode
CREATE TABLE `superstore`.`d_shipmode` (
  `id_shipmode` INT NOT NULL AUTO_INCREMENT,
  `shipmode` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_shipmode`));

insert into d_shipmode (shipmode)
select distinct shipmode from stagingsuperstore order by 1;

select * from d_shipmode;

-- f_ventas
 CREATE TABLE `superstore`.`f_ventas` (
  `id_order` VARCHAR(25) NOT NULL,
  `id_customer` INT NOT NULL,
  `id_city` INT NOT NULL,
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
  select orderid, c.id_customer, g.id_city, p.id_product, sm.id_shipmode, 
  orderdate, shipdate, sales, cost, sales-cost as margin,  datediff(shipdate, orderdate) as duracion
  from stagingsuperstore sss
  join d_customer c on sss.customername=c.customername 
  join d_city g on sss.city=g.city 
  join d_product p on sss.productname=p.productname
  join d_shipmode sm on sss.shipmode=sm.shipmode;
  
  select * from f_ventas;