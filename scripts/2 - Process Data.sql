--Data Processing

--Check for duplicate rows - none detected
SELECT COUNT(ride_id) - COUNT(DISTINCT ride_id) AS duplicates 
FROM all_trips;

-- To detect empty cells:
SELECT COUNT(*) FROM all_trips WHERE ride_id == '';				-- 0
SELECT COUNT(*) FROM all_trips WHERE rideable_type == '';		-- 0
SELECT COUNT(*) FROM all_trips WHERE started_at == '';			-- 0
SELECT COUNT(*) FROM all_trips WHERE ended_at == '';			-- 0
SELECT COUNT(*) FROM all_trips WHERE start_station_name == '';	-- 834,545 empty cells detected
SELECT COUNT(*) FROM all_trips WHERE start_station_id == '';	-- 834,677 empty cells detected
SELECT COUNT(*) FROM all_trips WHERE end_station_name == '';	-- 891,757 empty cells detected
SELECT COUNT(*) FROM all_trips WHERE end_station_id == '';		-- 891,898 empty cells detected
SELECT COUNT(*) FROM all_trips WHERE start_lat == '';			-- 0
SELECT COUNT(*) FROM all_trips WHERE start_lng == '';			-- 0
SELECT COUNT(*) FROM all_trips WHERE end_lat == '';				-- 5,961 empty cells detected
SELECT COUNT(*) FROM all_trips WHERE end_lng == '';				-- 5,961 empty cells detected
SELECT COUNT(*) FROM all_trips WHERE member_casual == '';		-- 0

--Check the length of ride_id - consistently 16 characters
SELECT DISTINCT(LENGTH(ride_id)) FROM all_trips; 

--Check the number of different member types - casual, member
SELECT DISTINCT(member_casual) FROM all_trips;

--Check the number of different bike types - electric_bike, classic_bike, docked_bike
SELECT DISTINCT(rideable_type) FROM all_trips;

--Create a ride_length column
SELECT 
	started_at, 
	ended_at,
    ROUND(((JULIANDAY(ended_at) - JULIANDAY(started_at)) * 1440), 2) AS ride_length
FROM all_trips;

--Check for unusual ride lengths (less than 0s and more than 1 day) - there are 5,397 results
SELECT COUNT(ride_length)
FROM
	(SELECT 
		started_at, 
		ended_at,
	    ROUND(((JULIANDAY(ended_at) - JULIANDAY(started_at)) * 1440), 2) AS ride_length
	FROM all_trips)
WHERE ride_length < 0 OR ride_length > 1440;

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
FROM cleaned_trips;
