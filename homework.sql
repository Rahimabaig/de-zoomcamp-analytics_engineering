--- question 3 ---
select count(*) as total_trips
from taxi_rides_ny.prod.fct_monthly_zone_revenue


---- question 4---
SELECT pickup_zone,
       SUM(revenue_monthly_total_amount) AS total_revenue
FROM taxi_rides_ny.prod.fct_monthly_zone_revenue
WHERE taxi_color = 'green'
  AND CAST(revenue_month AS VARCHAR) LIKE '2020%'
GROUP BY pickup_zone
order by total_revenue desc
limit 1;


--- question 5 ---
SELECT SUM(total_monthly_trips) AS green_taxi_trips_oct2019
FROM taxi_rides_ny.prod.fct_monthly_zone_revenue
WHERE taxi_color = 'green'
  AND revenue_month >= DATE '2019-10-01'
  AND revenue_month < DATE '2019-11-01';