-- Normalización customer

insert into d_segment (segment)
select distinct segment from stagingsuperstore
;
select * from d_segment;

insert into d_customer2 (customername, id_segment)
select distinct sss.customername, s.id_segment
from stagingsuperstore sss join d_segment s on sss.segment=s.segment
;
select * from d_customer2;


-- Normalización region



-- Normalización productd_customer



