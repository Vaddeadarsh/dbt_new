{{
    config(
        materialized='incremental',
        unique_key='shipment_id',
        on_schema_change='sync_all_columns'
    )
}}
select 
    shipment_id, product_id, warehouse_id, shipped_qty, shipment_status, shipped_at, delivered_at
from {{ ref('stg_shipments') }}
{% if is_incremental() %}
    where shipped_at >= (select max(shipped_at) from {{ this }}) - interval '3 days'
{% endif %}