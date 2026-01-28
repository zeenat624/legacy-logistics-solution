create table drivers (
   driver_id serial primary key,
   driver_name varchar(100),
   driver_phone varchar(50),
   driver_license varchar(20)  
);

create table trucks (
   truck_id serial primary key,
   truck_plate varchar(20),
   truck_model varchar(50),
   truck_capacity varchar(10)
);

insert into drivers (driver_name, driver_phone, driver_license)
select distinct
   split_part(driver_details, ',', 1),
   split_part(driver_details, ',', 2),
   split_part(driver_details, ',', 3)
from shipments;

insert into trucks (truck_plate, truck_model, truck_capacity)
select distinct
   split_part(truck_details, ',', 1) AS truck_plate,
   split_part(truck_details, ',', 2) AS truck_model,
   split_part(truck_details, ',', 3) AS truck_capacity
from shipments;

ALTER TABLE shipments
ADD COLUMN driver_id INT,
ADD COLUMN truck_id INT;

ALTER TABLE shipments
ADD CONSTRAINT fk_shipments_driver
FOREIGN KEY (driver_id)
REFERENCES drivers(driver_id);

ALTER TABLE shipments
ADD CONSTRAINT fk_shipments_truck
FOREIGN KEY (truck_id)
REFERENCES trucks(truck_id);
