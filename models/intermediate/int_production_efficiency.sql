with production_runs as (
    select * from {{ ref('stg_production_orders') }}
),

machines as (
    select * from {{ ref('stg_machines') }}
)

select
    p.production_order_id,
    p.product_id,               -- ✅ ADD THIS LINE
    p.machine_id,
    m.machine_type,
    p.target_production_qty,
    p.production_started_at,
    p.production_ended_at,

    datediff('day', p.production_started_at, p.production_ended_at) 
        as run_duration_days,

    (p.target_production_qty / nullif(
        (m.capacity_per_day * datediff('day', p.production_started_at, p.production_ended_at)), 
        0
    )) * 100 as calculated_capacity_efficiency_pct,

    p.order_status

from production_runs p
left join machines m 
    on p.machine_id = m.machine_id
