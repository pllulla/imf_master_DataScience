 -- F_Ventas
  CREATE TABLE `superstore`.`f_ventas` (
  `id_order` VARCHAR(25) NOT NULL,
  `id_customer` INT NOT NULL,
  `id_region` INT NOT NULL,
  `id_product` INT NOT NULL,
  `id_shipment` INT NOT NULL,
  `orderdate` DATE NOT NULL,
  `shipdate` DATE NOT NULL,
  `sales` INT NOT NULL DEFAULT 0,
  `costs` INT NOT NULL DEFAULT 0,
  `margin` INT NOT NULL DEFAULT 0,
  `duracion` FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_order`));
  
  
  insert into f_ventas 
  select orderid, c.id_customer, r.id_region, p.id_product, sm.id_shipment, 
  orderdate, shipdate, sales, cost, sales-cost as margin,  datediff(shipdate, orderdate) as duracion
  from stagingsuperstore sss
  join d_customer c on sss.customername=c.customer_name and sss.segment=c.segment
  join d_region r on sss.city=r.city and sss.country=r.country
  join d_product p on sss.productname=p.productname
  join d_shipment sm on sss.shipmode=sm.shipmode
  -- order by 1, 2
  ;
  
  select * from f_ventas;