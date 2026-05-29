with suppliers as (
    select
        "supplier_id" as SUPPLIER_ID,
        "supplier_name" as SUPPLIER_NAME,
        "country" as COUNTRY
    from {{ ref('stg_suppliers')}}
),

products as (
    select 
        PRODUCT_ID,
        SUPPLIER_ID
    from {{ ref('stg_products') }}
),

shipment_stats as (
    select 
        PRODUCT_ID,
        count(SHIPMENT_ID) as delivery_orders_count,
        sum(SHIPPED_QTY) as aggregate_shipped_volume,
        avg(datediff('day', SHIPPED_AT, DELIVERED_AT)) as average_transit_days
    from Manufacturing360.dbt_avadde.stg_shipments
    where SHIPMENT_STATUS = 'DELIVERED'
    group by PRODUCT_ID
)

select 
    s.supplier_id,
    s.supplier_name,
    s.country,
    coalesce(sum(sub.delivery_orders_count), 0) as completed_fulfillments,
    coalesce(sum(sub.aggregate_shipped_volume), 0) as total_volume_routed,
    coalesce(avg(sub.average_transit_days), 0.0) as calculated_lead_time_days

from suppliers s
left join products p 
    on s.supplier_id = p.supplier_id

left join shipment_stats sub 
    on p.product_id = sub.product_id

group by s.supplier_id, s.supplier_name, s.country