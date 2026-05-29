version: 2

models:
  # =========================================================================
  # STAGING LAYER MODEL ENTITIES
  # =========================================================================
  - name: stg_products
    description: "Standardized table clean-casting base product specifications and catalog values pricing fields."
    columns:
      - name: product_id
        description: "Primary surrogate item code primary key identifying an individual product catalog entry."
      - name: product_name
        description: "Clean trimmed label description of the warehouse manufacturing parts item."
      - name: product_category
        description: "Operational taxonomy field classifying parts categories groupings."
      - name: unit_price_usd
        description: "Standardized catalog price value formalized in United States Dollars (USD)."
        
      - name: weight_kg
        description: "Net dimensions weight measurement formalized in Kilograms (KG)."

  - name: stg_machines
    description: "Normalized industrial hardware master ledger tracing daily fleet state flags."
    columns:
      - name: machine_id
        description: "Primary key cluster key identifying a specific machine tool asset framework."
        
      - name: machine_type
        description: "Engineering design classification name tracking equipment classes (e.g., CNC, Lathe, 3D Printer)."
      - name: capacity_per_day
        description: "Maximum standard output limit volume throughput potential manageable within a 24-hour shift."
      - name: last_maintenance_at
        description: "Standardized UTC timestamp logging the exact historical maintenance sign-off entry."
      - name: machine_status
        description: "Current physical health operational runtime condition phase indicator string."
        

  - name: stg_inventory
    description: "Standardized inventory balance snapshot table reporting current balances per facility depot."
    columns:
      - name: inventory_id
        description: "Composite identifier tracing specific warehouse stock placement lines securely."
        
      - name: product_id
        description: "Foreign lookup target code matching an index inside the product dimensions ledger."
      - name: warehouse_id
        description: "Unique positional facility indicator reference key tracking logistics terminal locations."
      - name: inventory_stock_qty
        description: "Total clean physical balance items remaining available inside storage racks."
      - name: safety_stock_threshold
        description: "The safety-stock volume ceiling under which manufacturing replenishment orders must execute."

  - name: stg_production_orders
    description: "Cleaned tracking records monitoring assembly line history logs execution values."
    columns:
      - name: production_order_id
        description: "Unique master operational transaction index key tracking floor batch runs."
        
      - name: target_production_qty
        description: "The engineering product quantity requested for assembly under the job line code matrix."
      - name: order_status
        description: "Lifecycle gate step indicator code tracking factory run timelines."
        

  - name: stg_shipments
    description: "Standardized logistics outbound manifest database table tracing transits milestones."
    columns:
      - name: shipment_id
        description: "Primary tracking key referencing an individual carrier shipment row item."
        
      - name: shipped_qty
        description: "Volumetric units item configuration container capacity committed into logistics channels."
      - name: shipment_status
        description: "Transit execution phase update code flag metrics mapping."
        

  # =========================================================================
  # INTERMEDIATE REUSABLE BUSINESS LOGIC MODELS
  # =========================================================================
  - name: int_production_efficiency
    description: "Model 1: Operations performance intelligence model calculating batch run durations and line capacity utilization rates."
    columns:
      - name: production_order_id
        description: "Primary key matching unique evaluated batch run metrics rows."
        
      - name: run_duration_days
        description: "Calculated schedule timeline delta counting total processing days from start to completions."
      - name: calculated_capacity_efficiency_pct
        description: "Throughput metrics assessment score analyzing target output against historical capacity metrics."

  - name: int_inventory_stock_alerts
    description: "Model 2: Critical replenishment calculation matching warehouse quantities against target limits to flag logistics anomalies."
    columns:
      - name: inventory_id
        description: "Unique identification reference mapping warehouse inventory balances data tracks."
        
      - name: stock_health_status
        description: "Heuristic classification warning code calling out warehouse replenishment statuses."
        

  - name: int_machine_utilization_downtime
    description: "Model 3: Aggregated machine telemetry logic monitoring historical job counts to evaluate hardware fatigue metrics."
    columns:
      - name: machine_id
        description: "Primary index matching machine fleet asset units to compute analytics attributes summaries."
        
      - name: operational_utilization_tier
        description: "Uptime performance class grading hardware lines usage vulnerabilities."
        

  - name: int_supplier_performance
    description: "Model 4: Supply chain optimization module mining shipment manifest entries to calculate true average delivery windows."
    columns:
      - name: supplier_id
        description: "Unique reference pointer indexing single evaluated vendor entities cards."
        
      - name: calculated_lead_time_days
        description: "Mathematical moving average timeline score calculating calendar duration requirements from dispatch up to hub deliveries."

  # =========================================================================
  # REPORTING PRESENTATION LAYER MARTS
  # =========================================================================
  - name: dim_products
    description: "Analytical Product Master Catalog Dimension optimized for visual intelligence dashboards queries."
    columns:
      - name: product_id
        description: "Surrogate presentation key identifying individual product dimension entries row segments."
        

  - name: dim_suppliers
    description: "Star Schema flat clean Supplier Profile Attributes Dimension table for corporate vendor monitoring."
    columns:
      - name: supplier_id
        description: "Primary identification key pointing to a unique validated supplier vendor entry profile."
        

  - name: dim_machines
    description: "Star Schema Fleet Availability and Machinery Capacity Dimension tracking utilization trends, history metrics, and states configurations."
    columns:
      - name: machine_id
        description: "Master dimensional reference key pointing to individual pieces of equipment tooling assets frames."
        

  - name: fct_inventory
    description: "Analytical Summary Inventory Fact ledger reporting balance units snapshots across global facilities depots locations."
    columns:
      - name: inventory_id
        description: "Granular fact record row index context mapping key tracking variables."
        

  - name: fct_production_orders
    description: "INCREMENTAL PERFORMANCE FACT MART: High-speed analytics fact sheet appending changes to shopfloor job runs using delta timeline evaluations."
    columns:
      - name: production_order_id
        description: "Primary transaction row fact tracking manufacturing run entries logs histories."
        
  - name: fct_shipments
    description: "INCREMENTAL PERFORMANCE FACT MART: High-speed logistics summaries fact tracking routing milestones shifts on rolling execution frames."
    columns:
      - name: shipment_id
        description: "Logistics transactional reference index capturing carriers fulfillment paths variations inside the query layers."
        