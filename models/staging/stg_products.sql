with source as (
    select * from {{ source('raw_mfg', 'products') }}
)
select
    product_id,
    supplier_id,
    trim(name) as product_name,
    trim(category) as product_category,
    cast(price as numeric(12,2)) as unit_price_usd,
    cast(weight_kg as numeric(8,2)) as weight_kg,
    created_at
from source