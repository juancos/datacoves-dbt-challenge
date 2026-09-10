{{ config(materialized='table') }}

with payments_by_order as (
    select
        order_id,
        sum(
            case
                when payment_type = 'charge'
                    then cast(amount as decimal(18,2))
                when payment_type = 'refund'
                    then -cast(amount as decimal(18,2))
                else 0
            end
        ) as net_collected_amount
    from {{ ref('payments') }}
    group by order_id
)

select
    o.order_id,
    o.customer_id,
    c.customer_name,
    cast(o.order_date as date) as order_date,
    o.status,
    coalesce(p.net_collected_amount, 0) as net_collected_amount
from {{ ref('orders') }} o
left join {{ ref('customers') }} c
    on o.customer_id = c.customer_id
left join payments_by_order p
    on o.order_id = p.order_id
where o.status = 'completed'
