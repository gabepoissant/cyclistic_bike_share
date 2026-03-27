--Ensure past attempts don't interfere 
DROP TABLE IF EXISTS all_trips;

--Combine all tables
CREATE TABLE IF NOT EXISTS all_trips AS
	SELECT * FROM '202206_divvy_tripdata'
	UNION ALL
	SELECT * FROM '202207_divvy_tripdata'
	UNION ALL
	SELECT * FROM '202208_divvy_tripdata'
	UNION ALL
	SELECT * FROM '202209_divvy_publictripdata'
	UNION ALL
	SELECT * FROM '202210_divvy_tripdata'
	UNION ALL
	SELECT * FROM '202211_divvy_tripdata'
	UNION ALL
	SELECT * FROM '202212_divvy_tripdata'
	UNION ALL
	SELECT * FROM '202301_divvy_tripdata'
	UNION ALL
	SELECT * FROM '202302_divvy_tripdata'
	UNION ALL
	SELECT * FROM '202303_divvy_tripdata'
	UNION ALL
	SELECT * FROM '202304_divvy_tripdata'
	UNION ALL
	SELECT * FROM '202305_divvy_tripdata';

--Checking if it worked - it did
SELECT * FROM all_trips;

--Checking number of rows - 5,829,030
SELECT COUNT(*) FROM all_trips;