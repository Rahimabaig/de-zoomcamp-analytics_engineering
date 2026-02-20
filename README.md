# NYC Taxi Analytics Engineering with dbt + DuckDB

This project demonstrates an Analytics Engineering workflow using DuckDB and dbt 
to process and analyze NYC taxi trip data (yellow and green taxis) for 2019–2020.

## Project Structure
models/
├── staging/        # Raw data cleaning and renaming
├── intermediate/   # Joining and unioning models
└── marts/          # Final fact and dimension tables

## Models
- `stg_green_tripdata` - Staged green taxi data
- `stg_yellow_tripdata` - Staged yellow taxi data
- `int_trips_unioned` - Unioned yellow + green trips
- `int_trips` - Enriched and deduplicated trips
- `dim_vendors` - Vendor dimension
- `dim_zones` - Taxi zone dimension
- `fct_trips` - Final fact table with all trip details
- `fct_monthly_zone_revenue` - Monthly revenue by zone

## How to run
dbt build --target prod

## Tools
- dbt-duckdb
- DuckDB
- Python