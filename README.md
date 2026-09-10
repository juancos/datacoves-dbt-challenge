# Datacoves Challenge: Reliable Net Collections

A small dbt project that turns customer, order and payment records into a consistent net collections metric.

## Business question

How much cash have we collected, after refunds, on completed orders?

The model produces one row per completed order. Payments are aggregated before joining to orders to avoid duplicate order rows when an order has multiple payment transactions.

## Data and business rules

All data is synthetic and all amounts are in USD.

- Charges increase net collections.
- Refunds decrease net collections.
- Cancelled orders are excluded.
- Completed orders without payments receive a zero balance.
- Results are attributed to the order date, not the payment date.
- Net collections are not recognized accounting revenue.

## Project contents

- `seeds/customers.csv`: 4 customers.
- `seeds/orders.csv`: 6 orders.
- `seeds/payments.csv`: 8 payment transactions.
- `models/marts/fct_order_net_collections.sql`: completed-order model.
- `models/quality.yml`: documentation and 23 data tests.
- `profiles.yml.example`: configuration without credentials.
- `requirements.txt`: captured Python dependencies.

The default dbt example models are disabled.

## Run locally

Create and activate a Python virtual environment, then install dependencies:

```bash
python -m pip install -r requirements.txt
```

Copy `profiles.yml.example` to a directory of your choice as `profiles.yml`.
If you already have a dbt profile, merge the configuration instead of replacing it.

From the project directory, run:

```bash
dbt debug --profiles-dir /path/to/profile-directory --target local
dbt build --profiles-dir /path/to/profile-directory --target local
```

The local target uses DuckDB and does not require a MotherDuck account.

## Run with MotherDuck

Create a MotherDuck database:

```sql
CREATE DATABASE IF NOT EXISTS datacoves_challenge;
```

Use the `dev` target in the example profile and authenticate when prompted:

```bash
dbt debug --profiles-dir /path/to/profile-directory --target dev
dbt build --profiles-dir /path/to/profile-directory --target dev
```

Keep credentials outside the repository.

## Validation

The MotherDuck build completed successfully:
3 seeds, 1 table model and 23 data tests, with no errors or warnings.

Tests cover unique and non-null identifiers, required fields, accepted
status/payment values, and customer/order relationships.

The following result was also checked manually in MotherDuck:

```sql
SELECT
    COUNT(*) AS completed_orders,
    SUM(net_collected_amount) AS net_collections_usd
FROM datacoves_challenge.main.fct_order_net_collections;
```

Expected result for the supplied fixture: **5 completed orders, USD 610.00**.

The local target is provided for convenience; the demonstrated execution
used MotherDuck.

## Limitations and next steps

This is a small demonstration, not a production payment pipeline.
The 23 tests do not independently verify every financial calculation.
Production use would require agreed metric ownership, reconciliation
tests, payment sign validation, currency handling, refund timing rules,
and scheduled execution with monitoring.
