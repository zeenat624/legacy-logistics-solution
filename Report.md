Technical Report 
Indexing Optimization (Removing Sequential Scans)
Identified slow queries using EXPLAIN ANALYZE.


Found that most queries were performing Sequential Scans on large tables.


Applied B-Tree indexes on frequently searched columns such as shipment status and shipment date.


Created composite indexes for queries using multiple conditions.


Converted sequential scans into Index Scans.


Reduced query execution time significantly.


Database Normalization (Removing Redundancy)
Identified repeated data such as driver name, phone number, and vehicle details.


Created separate tables for drivers and trucks.


Migrated unique driver and truck data into new tables.


Updated the shipments table to use foreign keys instead of text fields.


Create new foreign keys driver_id and truck_id into shipments


Handling Unstructured Data (JSONB Optimization)
Converted invoice data column from TEXT to JSONB format.


Enabled structured querying of invoice information.


Created GIN indexes on JSONB columns.


Improved search performance for invoice-related queries.


Reduced query execution time for financial data lookups.


Handling Large Data (Table Partitioning)
Identified telemetry table as a major performance bottleneck.


Implemented declarative partitioning on telemetry data using timestamps.


Ensured queries scanned only relevant partitions.


Reduced full table scans on large telemetry data.



Advanced Caching (Materialized Views)
Identified frequently used dashboard queries.


Created materialized views for aggregated data such as total sales.


Reduced repeated calculation overhead.


Improved dashboard loading speed.


Achieved consistent low-latency responses for executive reports.
