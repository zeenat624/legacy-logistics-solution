alter table finance_invoices 
alter column raw_invoice_data type jsonb
using raw_invoice_data::jsonb;

create index idx_invoice_data on finance_invoices using GIN (raw_invoice_data);

explain analyze select * from finance_invoices where raw_invoice_data @> '{"items": [{"sku": "2554516778901"}]}';

VACUUM ANALYZE finance_invoices;


