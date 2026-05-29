with source as (
    select * from {{ source('raw_mfg', 'production') }}
)
select
    production_order_id,
    product_id,
    machine_id,
    quantity as target_production_qty,
    cast(start_date as timestamp) as production_started_at,
    cast(end_date as timestamp) as production_ended_at,
    upper(trim(status)) as order_status
from source