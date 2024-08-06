--Data Exploration

--Check the data types of all columns using .INFORMATION.COLUMNS

--COME BACK TO THIS IT AINT WORKIN

--Check for duplicate rows - none detected
SELECT COUNT(ride_id) - COUNT(DISTINCT ride_id) AS duplicates 
FROM all_trips;

--Check for number of null values in all columns;
SELECT 
	COUNT(*) - COUNT(ride_id), 				-- 0
	COUNT(*) - COUNT(rideable_type),		-- 0
	COUNT(*) - COUNT(started_at), 			-- 0
	COUNT(*) - COUNT(ended_at), 			-- 0
	COUNT(*) - COUNT(start_station_name), 	-- 0
	COUNT(*) - COUNT(start_station_id),		-- 0
	COUNT(*) - COUNT(end_station_name), 	-- 0
	COUNT(*) - COUNT(end_station_id), 		-- 0
	COUNT(*) - COUNT(start_lat), 			-- 0
	COUNT(*) - COUNT(start_lng), 			-- 0
	COUNT(*) - COUNT(end_lat), 				-- 0
	COUNT(*) - COUNT(end_lng), 				-- 0
	COUNT(*) - COUNT(member_casual)			-- 0
FROM all_trips;

--Despite seeing many empty values in the table, the above test returns 0 for all columns
	--Sanity check:
	SELECT * FROM all_trips WHERE end_lat IS NULL;	-- 0 rows. Still nothing.

-- To detect the empty cells another way:
SELECT COUNT(*) FROM all_trips WHERE ride_id == '';				-- 0
SELECT COUNT(*) FROM all_trips WHERE rideable_type == '';		-- 0
SELECT COUNT(*) FROM all_trips WHERE started_at == '';			-- 0
SELECT COUNT(*) FROM all_trips WHERE ended_at == '';			-- 0
SELECT COUNT(*) FROM all_trips WHERE start_station_name == '';	-- 834,545
SELECT COUNT(*) FROM all_trips WHERE start_station_id == '';	-- 834,677
SELECT COUNT(*) FROM all_trips WHERE end_station_name == '';	-- 891,757
SELECT COUNT(*) FROM all_trips WHERE end_station_id == '';		-- 891,898
SELECT COUNT(*) FROM all_trips WHERE start_lat == '';			-- 0
SELECT COUNT(*) FROM all_trips WHERE start_lng == '';			-- 0
SELECT COUNT(*) FROM all_trips WHERE end_lat == '';				-- 5,961
SELECT COUNT(*) FROM all_trips WHERE end_lng == '';				-- 5,961
SELECT COUNT(*) FROM all_trips WHERE member_casual == '';		-- 0

SELECT COUNT(*) 
FROM all_trips 
WHERE ride_id == ''
	OR rideable_type == ''
	OR started_at == ''
	OR ended_at == ''
	OR start_station_name == ''
	OR start_station_id == ''
	OR end_station_name == ''
	OR end_station_id == ''
	OR start_lat == ''
	OR start_lng == ''
	OR end_lat == ''
	OR end_lng == ''
	OR member_casual == ''; --Result: 1,334,349

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


