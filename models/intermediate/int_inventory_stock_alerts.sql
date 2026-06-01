with inventory_current as (
    select * from {{ ref('stg_inventory') }}
),
products as (
    select * from {{ ref('stg_products') }}
)
select
    i.inventory_id,
    i.warehouse_id,
    p.product_id,
    p.product_name,
    p.product_category,
    i.inventory_stock_qty,
    i.safety_stock_threshold,
    case 
        when i.inventory_stock_qty <= i.safety_stock_threshold then 'REORDER TRIGGERED'
        when i.inventory_stock_qty > (i.safety_stock_threshold * 3) then 'OVERSTOCK WARNING'
        else 'HEALTHY VOLUMES'
    end as stock_health_status
from inventory_current i
left join products p on i.product_id = p.product_id