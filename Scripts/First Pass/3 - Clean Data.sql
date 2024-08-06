--Data Cleaning

--Drop Table if exists
DROP TABLE IF EXISTS cleaned_trips;

--Create a cleaned table
CREATE TABLE IF NOT EXISTS cleaned_trips AS 
	SELECT *,
		ROUND(((JULIANDAY(ended_at) - JULIANDAY(started_at)) * 1440), 2) AS ride_length,
		CASE CAST (STRFTIME('%w', started_at) AS INTEGER)
			WHEN 0 THEN 'Sunday'
			WHEN 1 THEN 'Monday'
			WHEN 2 THEN 'Tuesday'
			WHEN 3 THEN 'Wednesday'
			WHEN 4 THEN 'Thursday'
			WHEN 5 THEN 'Friday'
			WHEN 6 THEN 'Saturday' END AS weekday,
		CASE CAST (STRFTIME('%m', started_at) AS INTEGER)
			WHEN 1 THEN 'January'
			WHEN 2 THEN 'February'
			WHEN 3 THEN 'March'
			WHEN 4 THEN 'April'
			WHEN 5 THEN 'May'
			WHEN 6 THEN 'June'
			WHEN 7 THEN 'July' 
			WHEN 8 THEN 'August' 			
			WHEN 9 THEN 'September' 			
			WHEN 10 THEN 'October' 			
			WHEN 11 THEN 'November'
			WHEN 12 THEN 'December' 
			END AS month,
		SUBSTR(started_at, 12,2) AS start_hour
	FROM all_trips
	WHERE start_station_name <> ''
		AND start_station_id <> ''
		AND end_station_name <> ''
		AND end_station_id <> ''
		AND end_lat <> ''
		AND end_lng <> ''
	;

--Initial rows: 5,829,030
--Remaining rows: 4,494,681
--Removed rows: 1,334,349
SELECT COUNT(*)
FROM cleaned_trips  
