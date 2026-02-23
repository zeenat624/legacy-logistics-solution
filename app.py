from fastapi import FastAPI, Request
import time
import psycopg2
import os

app = FastAPI()
DB_URL = os.getenv("DATABASE_URL")

# --- PERFORMANCE LOGGER MIDDLEWARE ---
@app.middleware("http")
async def add_process_time_header(request: Request, call_next):
    start_time = time.time()
    response = await call_next(request)
    process_time = time.time() - start_time
    response.headers["X-Process-Time"] = str(process_time)
    return response


def get_db_connection():
    return psycopg2.connect(DB_URL)


@app.get("/")
def read_root():
    return {"message": "System Online. Performance: OPTIMIZED."}


# --- WEEK 1-2: INDEXED DATE SEARCH ---
@app.get("/shipments/by-date")
def get_by_date(date: str):
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute(
        """
        SELECT id, created_at, status, driver_id, truck_id
        FROM shipments
        WHERE created_at >= %s
          AND created_at < %s
        ORDER BY created_at
        LIMIT 100
        """,
        (date, date + ' 1 day')
    )

    rows = cur.fetchall()
    cur.close()
    conn.close()
    return rows


# --- WEEK 3: NORMALIZED DRIVER SEARCH ---
@app.get("/shipments/driver/{name}")
def get_by_driver(name: str):
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT s.id, s.created_at, s.status, s.driver_id, s.truck_id
        FROM shipments s
        JOIN drivers d ON s.driver_id = d.driver_id
        WHERE d.driver_name = %s
        LIMIT 100
    """, (name,))

    rows = cur.fetchall()
    cur.close()
    conn.close()
    return rows


# --- WEEK 4: MATERIALIZED VIEW + LIMIT 100 ---
@app.get("/finance/high-value-invoices")
def get_high_value():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT id, shipment_uuid, issued_date, amount_cents
        FROM mv_high_value_invoices
        ORDER BY amount_cents DESC
        LIMIT 100
    """)

    rows = cur.fetchall()
    cur.close()
    conn.close()
    return rows


# --- WEEK 5: PARTITIONED TELEMETRY TABLE ---
@app.get("/telemetry/truck/{plate}")
def get_truck_history(plate: str):
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT id, truck_license_plate, speed, fuel_level, timestamp
        FROM truck_telemetry_partitioned
        WHERE truck_license_plate = %s
        ORDER BY timestamp DESC
        LIMIT 100
    """, (plate,))

    rows = cur.fetchall()
    cur.close()
    conn.close()
    return rows


# --- WEEK 7: CEO DASHBOARD VIA MATERIALIZED VIEW ---
@app.get("/analytics/daily-stats")
def get_stats():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT delivered, avg_speed, revenue
        FROM mv_daily_stats
    """)

    rows = cur.fetchall()
    cur.close()
    conn.close()
    return rows
