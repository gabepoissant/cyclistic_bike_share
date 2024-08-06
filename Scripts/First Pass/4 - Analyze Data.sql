--Data Analysis

--Member vs Casual total trips
SELECT member_casual, COUNT(member_casual) AS total_trips
FROM cleaned_trips
GROUP BY member_casual;
	
--Bike types used by each user type
SELECT rideable_type, member_casual, COUNT(rideable_type) AS total_trips
FROM cleaned_trips 
GROUP BY member_casual, rideable_type;

--Number of trips by month
SELECT member_casual, month, COUNT(month)
FROM cleaned_trips
GROUP BY month, member_casual
ORDER BY member_casual, started_at;

--Number of trips per day of week
SELECT member_casual, weekday, COUNT(weekday)
FROM cleaned_trips
GROUP BY member_casual, weekday;

--Number of trips by hour
SELECT member_casual, start_hour, COUNT(start_hour)
FROM cleaned_trips
GROUP BY member_casual, start_hour;

--Average ride_length by month
SELECT member_casual, month, AVG(ride_length)
FROM cleaned_trips
GROUP BY month, member_casual
ORDER BY member_casual, started_at;

--average ride_length by day of week
SELECT member_casual, weekday, AVG(ride_length)
FROM cleaned_trips
GROUP BY weekday, member_casual
ORDER BY member_casual, started_at;

--average ride_length by hour
SELECT member_casual, start_hour, AVG(ride_length)
FROM cleaned_trips
GROUP BY start_hour, member_casual
ORDER BY member_casual, start_hour;

--start station locations for Members
SELECT start_station_name, COUNT(ride_id) AS start_station_total
FROM cleaned_trips
WHERE member_casual = 'member'
GROUP BY start_station_name
ORDER BY start_station_total DESC
LIMIT 10;

--start station locations for Casual Riders
SELECT start_station_name, COUNT(ride_id) AS start_station_total
FROM cleaned_trips
WHERE member_casual = 'casual'
GROUP BY start_station_name
ORDER BY start_station_total DESC
LIMIT 10;

--end station locations for Members
SELECT end_station_name, COUNT(ride_id) AS end_station_total
FROM cleaned_trips
WHERE member_casual = 'member'
GROUP BY end_station_name
ORDER BY end_station_total DESC
LIMIT 10;

--end station locations for Casual Riders
SELECT end_station_name, COUNT(ride_id) AS end_station_total
FROM cleaned_trips
WHERE member_casual = 'casual'
GROUP BY end_station_name
ORDER BY end_station_total DESC
LIMIT 10;
