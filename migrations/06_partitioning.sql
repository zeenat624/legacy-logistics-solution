create table truck_telemetry_partitioned (
    id SERIAL not null,
    truck_license_plate VARCHAR(20) not null,
    latitude double precision not null,
    longitude double precision not null,
    elevation double precision,
    speed double precision ,
    engine_temp double precision ,
    fuel_level double precision ,
    timestamp timestamp not null 
) partition by range (timestamp);

create table truck_telemetry_2025_01 partition of truck_telemetry_partitioned
for values from ('2025-01-01') to ('2025-02-01');

create table truck_telemetry_2025_02 partition of truck_telemetry_partitioned
for values from ('2025-02-01') to ('2025-03-01');

create table truck_telemetry_2025_03 partition of truck_telemetry_partitioned
for values from ('2025-03-01') to ('2025-04-01');

create table truck_telemetry_2025_04 partition of truck_telemetry_partitioned
for values from ('2025-04-01') to ('2025-05-01');

create table truck_telemetry_2025_05 partition of truck_telemetry_partitioned
for values from ('2025-05-01') to ('2025-06-01');

create table truck_telemetry_2025_06 partition of truck_telemetry_partitioned
for values from ('2025-06-01') to ('2025-07-01');

create table truck_telemetry_2025_07 partition of truck_telemetry_partitioned
for values from ('2025-07-01') to ('2025-08-01');

create table truck_telemetry_2025_08 partition of truck_telemetry_partitioned
for values from ('2025-08-01') to ('2025-09-01');

create table truck_telemetry_2025_09 partition of truck_telemetry_partitioned
for values from ('2025-09-01') to ('2025-10-01');

create table truck_telemetry_2025_10 partition of truck_telemetry_partitioned
for values from ('2025-10-01') to ('2025-11-01');

create table truck_telemetry_2025_11 partition of truck_telemetry_partitioned
for values from ('2025-11-01') to ('2025-12-01');

insert into truck_telemetry_partitioned
select * from truck_telemetry
where timestamp >= '2025-01-01' and timestamp < '2025-02-01';

insert into truck_telemetry_partitioned
select * from truck_telemetry
where timestamp >= '2025-02-01' and timestamp < '2025-03-01';

create index idx_2025_01 on truck_telemetry_2025_01 (truck_license_plate, timestamp );
create index idx_2025_02 on truck_telemetry_2025_02 (truck_license_plate, timestamp );
create index idx_2025_03 on truck_telemetry_2025_03 (truck_license_plate, timestamp );
create index idx_2025_04 on truck_telemetry_2025_04 (truck_license_plate, timestamp );
create index idx_2025_05 on truck_telemetry_2025_05 (truck_license_plate, timestamp );









