{{
  config(
    materialized='incremental',
    unique_key='trip_id',
    incremental_strategy='merge',
    on_schema_change='append_new_columns'  )
}}

select 
    
    -- trip identifier
    trips.trip_id,
    trips.vendor_id,
    vendor.vendor_name,
    trips.taxi_color,
    trips.rate_code_id,

    -- location identifiers
    trips.pickup_location_id,
    pz.borough as pickup_borough,
    pz.zone as pickup_zone,
    trips.dropoff_location_id,
    dz.borough as dropoff_borough,
    dz.zone as dropoff_zone,

    --trip timing
    trips.pickup_datetime,
    trips.dropoff_datetime,
    trips.store_and_fwd_flag,

    -- trip metrics
    trips.passenger_count,
    trips.trip_distance,
    trips.trip_type,


    -- trip financials
    trips.fare_amount,
    trips.extra,
    trips.mta_tax,
    trips.ehail_fee,
    trips.tip_amount,
    trips.tolls_amount,
    trips.improvement_surcharge,
    trips.total_amount,
    trips.payment_type,
    trips.payment_type_description

from {{ ref('int_trips') }} as trips
left join {{ ref('dim_vendors') }} as vendor
    on trips.vendor_id = vendor.vendor_id
left join {{ ref('dim_zones') }} as pz
    on trips.pickup_location_id = pz.locationid
left join {{ ref('dim_zones') }} as dz
    on trips.dropoff_location_id = dz.locationid


{% if is_incremental() %}
  -- Only process new trips based on pickup datetime
  where trips.pickup_datetime > (select max(pickup_datetime) from {{ this }})
{% endif %}
