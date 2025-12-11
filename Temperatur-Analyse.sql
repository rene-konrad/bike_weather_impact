WITH daily_counts AS (SELECT
    COUNT(trips.trip_id) AS count_trips,
    EXTRACT(MONTH FROM trips.start_date) as monat,
    DATE(trips.start_date) AS datum,
CASE
    WHEN weather_2017.temp < 50 THEN '1_Cold (<50°F)'
    WHEN weather_2017.temp >= 50 AND weather_2017.temp < 60 THEN '2_Cool_Foggy (50-60°F)'
    WHEN weather_2017.temp >= 60 AND weather_2017.temp < 68 THEN '3_Ideal (60-68°F)'
    WHEN weather_2017.temp >= 68 AND weather_2017.temp <= 75 THEN '4_Warm (68-75°F)'
    WHEN weather_2017.temp > 75 THEN '5_Hot (>75°F)'
    ELSE 'Unknown'
END AS comfort_category,
CASE 
            WHEN EXTRACT(DAYOFWEEK FROM trips.start_date) IN (1, 7) THEN 'Weekend' 
            ELSE 'Weekday' 
        END AS day_type,
CASE 
    WHEN weather_2017.prcp > 0.05 THEN 'Rainy'
    ELSE 'Dry' 
END AS rain_status
FROM
    `bigquery-public-data.noaa_gsod.gsod2017` AS weather_2017
INNER JOIN
    `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips` AS trips
ON
    DATE(CAST(weather_2017.year AS INT64), CAST(weather_2017.mo AS INT64), CAST(weather_2017.da AS INT64)) = DATE(trips.start_date)
INNER JOIN
    `bigquery-public-data.san_francisco_bikeshare.bikeshare_station_info` AS station
ON
    trips.start_station_name = station.name
WHERE
    weather_2017.stn = "724940"
GROUP BY monat,day_type, comfort_category, rain_status, DATE(trips.start_date))
SELECT
    monat,
    rain_status,comfort_category,
    ROUND(AVG(count_trips),0) AS anzahl_trips_pro_tag
FROM
    daily_counts
WHERE day_type = 'Weekday'
GROUP by comfort_category, rain_status, monat
ORDER BY monat ASC