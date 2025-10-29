with customers as (

    select * from {{ ref('stg_jaffle_shop__customers') }}

),

orders as (

    select * from {{ ref('stg_jaffle_shop__orders') }}

),

payments as (

    select * from {{ ref('stg_stripe__payments') }}
),

final as (
    select
        p.order_id,
        c.customer_id,
        p.amount
    from payments p left join orders o using (order_id)
    left join customers c using(customer_id)
)

select * from final
