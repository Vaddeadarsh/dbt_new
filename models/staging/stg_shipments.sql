with source as (
    select * from {{ source('raw_mfg', 'shipments') }}
)
select
    shipment_id,
    product_id,
    warehouse_id,
    quantity as shipped_qty,
    cast(shipment_date as timestamp) as shipped_at,
    cast(delivery_date as timestamp) as delivered_at,
    upper(trim(status)) as shipment_status
from source