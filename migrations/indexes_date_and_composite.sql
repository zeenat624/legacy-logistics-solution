create index idx_shipments_date on shipments (created_at);

create index idx_shipments_date_status on shipments (created_at, status);


