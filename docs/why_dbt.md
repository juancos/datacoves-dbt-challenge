# Before Buying Another Dashboard, Agree on the Number

A leadership meeting should focus on decisions. Yet a simple question,
“How much did we collect?”, can turn into a debate between Finance and
Sales. One report includes cancelled orders. Another ignores refunds.
Both teams trust their spreadsheets, and someone spends the afternoon
explaining the difference.

I would introduce dbt to make those calculations consistent, visible,
and easier to check.

## What dbt would change

Think of dbt as a shared set of instructions for preparing business data.
Our team defines how a metric is calculated, documents the rules, and
adds checks for problems we want to catch.

For an executive, the value is practical: less time reconciling competing
reports, clearer ownership of calculations, and a record of what changed.
Those benefits depend on the team agreeing on definitions and using the
process consistently.

## A small example

For this proposal, I built a working demonstration using dbt and
MotherDuck, a cloud database. It uses fictional customers, orders, and
payments.

The business question is deliberately precise: how much have we collected,
after refunds, on completed orders?

The sample contains six orders and eight payment transactions. Our rules
exclude cancelled orders and subtract refunds from charges. The result
is five completed orders and $610 in net collections.

One order has both a charge and a partial refund. The project combines
those payments before joining them to the order, avoiding a common
reporting mistake: counting the same order more than once.

This is a cash collection metric, not a claim about recognized accounting
revenue. That distinction is exactly why written definitions matter.

## Confidence needs checks

The project includes 23 automated checks covering duplicate identifiers,
missing required values, allowed statuses, and relationships between
customers, orders, and payments. All passed in the demonstrated run.

That does not prove every business rule is correct. I also checked the
expected order count and total separately. In production, we would add
financial reconciliation checks and agree on refund timing and currencies
with Finance.

## Start with a focused pilot

I would ask for a four-week pilot around one frequently disputed metric.
Finance would own its definition, and the data team would implement and
maintain it. We would compare the results with the existing reporting
process before switching any critical report.

Before starting, we would record time spent reconciling that metric,
reporting discrepancies, and time needed to make a calculation change.
At the end, we would compare those measures and review operating costs.

The investment includes engineering time, training, database usage, and
any hosting or scheduling services we choose. dbt will not fix incorrect
source data or replace business ownership.

My recommendation is to approve that limited pilot. If we can show less
manual reconciliation and a calculation that both teams understand and
trust, we have a concrete reason to expand.
