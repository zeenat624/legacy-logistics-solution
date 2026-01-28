CREATE MATERIALIZED VIEW mv_high_value_invoices AS
SELECT
    id,
    shipment_uuid,
    issued_date,
    CAST(raw_invoice_data->>'amount_cents' AS INT) AS amount_cents,
    raw_invoice_data
FROM finance_invoices
WHERE CAST(raw_invoice_data->>'amount_cents' AS INT) > 50000;

CREATE INDEX idx_mv_high_value_amount ON mv_high_value_invoices (amount_cents DESC);

SELECT * FROM mv_high_value_invoices ORDER by amount_cents desc LIMIT 100;
