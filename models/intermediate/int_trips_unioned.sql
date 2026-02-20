
with green_trips as (
    select
        -- identifiers
        vendor_id,
        rate_code_id,
        pickup_location_id,
        dropoff_location_id,

        -- timestamps
        pickup_datetime,  
        dropoff_datetime,

        -- trip info
        store_and_fwd_flag,
        passenger_count,
        trip_distance,
        trip_type,

        -- payment info
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        ehail_fee,
        improvement_surcharge,
        total_amount,
        payment_type,
        'green' as taxi_color
    from {{ ref('stg_green_tripdata') }}
),

yellow_trips as (
    select
        -- identifiers
        vendor_id,
        rate_code_id,
        pickup_location_id,
        dropoff_location_id,

        -- timestamps
        pickup_datetime,  
        dropoff_datetime,

        -- trip info
        store_and_fwd_flag,
        passenger_count,
        trip_distance,
        cast(1 as integer) as trip_type,

        -- payment info
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        cast(0 as numeric) as ehail_fee,
        improvement_surcharge,
        total_amount,
        payment_type,
        'yellow' as taxi_color
    from {{ ref('stg_yellow_tripdata') }}
),

trips_unioned as (
    select * from yellow_trips
    union all  
    select * from green_trips
)


select * from trips_unioned