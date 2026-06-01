with source as (
    select * from {{ source('raw_mfg', 'inventory') }}
)
select
    inventory_id,
    product_id,
    warehouse_id,
    quantity as inventory_stock_qty,
    reorder_level as safety_stock_threshold,
    cast(last_updated as timestamp) as record_updated_at
from source