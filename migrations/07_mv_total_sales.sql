CREATE MATERIALIZED VIEW mv_total_sales AS
SELECT
    SUM((raw_invoice_data->>'amount_cents')::INT) AS total_sales_cents
FROM finance_invoices;


CREATE INDEX idx_mv_total_sales ON mv_total_sales (total_sales_cents);

REFRESH MATERIALIZED VIEW mv_total_sales;
