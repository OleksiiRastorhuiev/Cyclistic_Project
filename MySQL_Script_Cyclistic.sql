CREATE TABLE v1_tripdata_combined_12(
ride_id nvarchar(225),
rideable_type nvarchar(50),
started_at datetime,
ended_at datetime,
start_station_name nvarchar(225),
start_station_id nvarchar(225),
end_station_name nvarchar(225),
end_station_id nvarchar(225),
start_lat decimal(10,8),
start_lng decimal(11,8),
end_lat decimal(10,8),
end_lng decimal(11,8),
member_casual nvarchar(50));

-- Importing data for each month into nearly created table tripdata_combined_12 
-- from local folder
SET GLOBAL local_infile=1;
-- data for the 1st month
LOAD DATA LOCAL INFILE '/Users/oleksiirastorhuiev/Desktop/tripdata_2023_01.csv' 
INTO TABLE v1_tripdata_combined_12 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- data for the 2nd month
LOAD DATA LOCAL INFILE '/Users/oleksiirastorhuiev/Desktop/tripdata_2023_02.csv' 
INTO TABLE v1_tripdata_combined_12
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- data for the 3rd month
LOAD DATA LOCAL INFILE '/Users/oleksiirastorhuiev/Desktop/tripdata_2023_03.csv' 
INTO TABLE v1_tripdata_combined_12
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- data for the 4th month
LOAD DATA LOCAL INFILE '/Users/oleksiirastorhuiev/Desktop/tripdata_2023_04.csv' 
INTO TABLE v1_tripdata_combined_12
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- data for the 5th month
LOAD DATA LOCAL INFILE '/Users/oleksiirastorhuiev/Desktop/tripdata_2023_05.csv' 
INTO TABLE v1_tripdata_combined_12
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- data for the 6th month
LOAD DATA LOCAL INFILE '/Users/oleksiirastorhuiev/Desktop/tripdata_2023_06.csv' 
INTO TABLE v1_tripdata_combined_12
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- data for the 7th month
LOAD DATA LOCAL INFILE '/Users/oleksiirastorhuiev/Desktop/tripdata_2023_07.csv' 
INTO TABLE v1_tripdata_combined_12 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- data for the 8th month
LOAD DATA LOCAL INFILE '/Users/oleksiirastorhuiev/Desktop/tripdata_2023_08.csv' 
INTO TABLE v1_tripdata_combined_12
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- data for the 9th month
LOAD DATA LOCAL INFILE '/Users/oleksiirastorhuiev/Desktop/tripdata_2023_09.csv' 
INTO TABLE v1_tripdata_combined_12
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- data for the 10th month
LOAD DATA LOCAL INFILE '/Users/oleksiirastorhuiev/Desktop/tripdata_2023_10.csv' 
INTO TABLE v1_tripdata_combined_12 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- data for the 11th month
LOAD DATA LOCAL INFILE '/Users/oleksiirastorhuiev/Desktop/tripdata_2023_11.csv' 
INTO TABLE v1_tripdata_combined_12 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- data for the 12th month
LOAD DATA LOCAL INFILE '/Users/oleksiirastorhuiev/tripdata_2023_12.csv' 
INTO TABLE v1_tripdata_combined_12
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- exploring and cheching the data
SELECT * FROM v1_tripdata_combined_12 LIMIT 5;

-- find total number of rows
SELECT COUNT(*) AS total_number_rows FROM v1_tripdata_combined_12; -- 6 491 571

-- finding duplicates. Because a column ride_id as row identifier have to be unique, we need will find 
-- and delete duplicates based on this single column ride_id

SELECT COUNT(*) AS number_duplicates
FROM (
    SELECT COUNT(*)
    FROM v1_tripdata_combined_12
    GROUP BY ride_id
    HAVING COUNT(*) > 1
) AS duplicates; -- 771693 duplicate

SET SESSION SQL_MODE='ALLOW_INVALID_DATES'; -- disable the warning from invalid datetime formats
-- creating filtered tables with no duplicates
CREATE TABLE v2_tripdata_combined_12 LIKE v1_tripdata_combined_12;

-- inserting the data from previous table without duplicates in ride_id column
INSERT v2_tripdata_combined_12 SELECT DISTINCT * FROM v1_tripdata_combined_12
WHERE ride_id IN (SELECT ride_id FROM v1_tripdata_combined_12);

-- find total number of rows of newly created table
SELECT COUNT(*) AS total_number_rows_no_duplicates FROM v2_tripdata_combined_12; -- 5 719 878 rows

-- verify if there are still duplicates
SELECT COUNT(*) AS total_duplicate_rows -- None
FROM v2_tripdata_combined_12
GROUP BY 
ride_id,
rideable_type,
started_at,
ended_at,
start_station_name,
start_station_id,
end_station_name,
end_station_id,
start_lat,
start_lng,
end_lat,
end_lng,
member_casual
HAVING COUNT(*) > 1;

-- REMOVING blanks rows
-- number of blank rows in columns
SELECT
    COUNT(*) AS total_blank_rows_count -- 1388174 total blanc rows
FROM (
    SELECT
        ride_id,
        rideable_type,
        started_at,
        ended_at,
        start_station_name,
        start_station_id,
        end_station_name,
        end_station_id,
        start_lat,
        start_lng,
        end_lat,
        end_lng,
        member_casual
    FROM v2_tripdata_combined_12
    WHERE
        ride_id = '' OR
        rideable_type = '' OR
        started_at IS NULL OR
        ended_at IS NULL OR
        start_station_name = '' OR
        start_station_id = '' OR
        end_station_name = '' OR
        end_station_id = '' OR
        start_lat = '' OR
        start_lng = '' OR
        end_lat = '' OR
        end_lng = '' OR
        member_casual = ''
) AS distinct_blank_rows;

-- columns with blanc and null values
SELECT 'blank_count_ride_id' AS column_name, COUNT(*) AS count_value FROM v2_tripdata_combined_12 WHERE ride_id = ''
UNION ALL
SELECT 'blank_count_rideable_type', COUNT(*) FROM v2_tripdata_combined_12 WHERE rideable_type = ''
UNION ALL
SELECT 'null_count_started_at', COUNT(*) FROM v2_tripdata_combined_12 WHERE started_at IS NULL
UNION ALL
SELECT 'null_count_ended_at', COUNT(*) FROM v2_tripdata_combined_12 WHERE ended_at IS NULL
UNION ALL
SELECT 'blank_count_start_station_name', COUNT(*) FROM v2_tripdata_combined_12 WHERE start_station_name = ''
UNION ALL
SELECT 'blank_count_start_station_id', COUNT(*) FROM v2_tripdata_combined_12 WHERE start_station_id = ''
UNION ALL
SELECT 'blank_count_end_station_name', COUNT(*) FROM v2_tripdata_combined_12 WHERE end_station_name = ''
UNION ALL
SELECT 'blank_count_end_station_id', COUNT(*) FROM v2_tripdata_combined_12 WHERE end_station_id = ''
UNION ALL
SELECT 'blank_count_start_lat', COUNT(*) FROM v2_tripdata_combined_12 WHERE start_lat = ''
UNION ALL
SELECT 'blank_count_start_lng', COUNT(*) FROM v2_tripdata_combined_12 WHERE start_lng = ''
UNION ALL
SELECT 'blank_count_end_lat', COUNT(*) FROM v2_tripdata_combined_12 WHERE end_lat = ''
UNION ALL
SELECT 'blank_count_end_lng', COUNT(*) FROM v2_tripdata_combined_12 WHERE end_lng = ''
UNION ALL
SELECT 'blank_count_member_casual', COUNT(*) FROM v2_tripdata_combined_12 WHERE member_casual = '';

-- deletion of blanc values
DELETE FROM v2_tripdata_combined_12
WHERE	
    start_station_name = '' OR 
	start_station_id = '' OR 
	end_station_name = '' OR 
	end_station_id = '' OR 
	end_lat = '' OR 
	end_lng = ''; -- 1 388 174 rows affected

-- total number of rows 
SELECT COUNT(*) AS total_number_rows_cleaned FROM v2_tripdata_combined_12; -- 4 331 704 rows

-- adding new columns
ALTER TABLE v2_tripdata_combined_12
ADD COLUMN duration_minutes INT; 
UPDATE v2_tripdata_combined_12
SET duration_minutes = TIMESTAMPDIFF(MINUTE,started_at, ended_at);

ALTER TABLE v2_tripdata_combined_12
ADD COLUMN day_of_week INT;
UPDATE v2_tripdata_combined_12 
SET day_of_week = DAYOFWEEK(started_at);

ALTER TABLE v2_tripdata_combined_12
ADD COLUMN day_name nvarchar(50);
UPDATE v2_tripdata_combined_12
SET day_name = DAYNAME(started_at);

ALTER TABLE v2_tripdata_combined_12
ADD COLUMN month_name nvarchar(50);
UPDATE v2_tripdata_combined_12
SET month_name = MONTHNAME(started_at); 

ALTER TABLE v2_tripdata_combined_12
ADD COLUMN the_hour INT;
UPDATE v2_tripdata_combined_12
SET the_hour = HOUR(started_at);

-- find the number of trip duration with negative values or null
SELECT COUNT(duration_minutes) AS number_null_and_negative_duration FROM v2_tripdata_combined_12
WHERE duration_minutes <= 0; 

-- find the number of trip duration more than 24 hour (1440 minutes)
SELECT COUNT(duration_minutes) AS number_long_duration FROM v2_tripdata_combined_12
WHERE duration_minutes >= 1440; -- 133

-- Now we need to remove these unrepresentative rows
SET SQL_SAFE_UPDATES = 0; -- this querry removes restrictions for data manipulation 
DELETE FROM v2_tripdata_combined_12 WHERE duration_minutes <=0; -- 87517 rows affected

-- Removing outliers in trip duration more than 24 hours (1440 minutes)
DELETE FROM v2_tripdata_combined_12 WHERE duration_minutes >=1440; -- 133 rows affected

-- verify changes
SELECT 'long_duration_minutes', COUNT(duration_minutes) FROM v2_tripdata_combined_12 WHERE duration_minutes >= 1440 -- 0
UNION ALL
SELECT 'negative_or_null_duration_minutes', COUNT(duration_minutes) FROM v2_tripdata_combined_12 WHERE duration_minutes <=0; -- 0

-- Total umber of rides by user type

SELECT 'member', COUNT(member_casual) FROM v2_tripdata_combined_12 WHERE member_casual = 'member' -- 2738867
UNION ALL
SELECT 'casual', COUNT(member_casual) FROM v2_tripdata_combined_12 WHERE member_casual = 'casual'; -- 1505187

-- STATISTICAL DISCRIPTION --

-- average, minimal, maximal trip duration in minutes
SELECT ROUND(AVG(duration_minutes), 2) AS average_trip_duration, -- 15,73 minutes
ROUND(MIN(duration_minutes), 2) AS min_trip_duration, -- 1 minutes
ROUND(MAX(duration_minutes), 2) AS max_trip_duration -- 1439 minutes
FROM v2_tripdata_combined_12;

-- calculate median for trip duration 
SET @rowindex := -1;
SELECT
   ROUND(AVG(duration_minutes),2) as median_trip_duration
FROM
   (SELECT @rowindex:=@rowindex + 1 AS rowindex,
           duration_minutes
    FROM v2_tripdata_combined_12
    ORDER BY duration_minutes) AS d
WHERE
d.rowindex IN (FLOOR(@rowindex / 2), CEIL(@rowindex / 2)); -- 10,00 minutes

-- calculate mode for trip duration
WITH freq_cte AS (
SELECT duration_minutes, COUNT(*) as freq
FROM v2_tripdata_combined_12 GROUP BY duration_minutes)
SELECT * FROM freq_cte
WHERE freq = (SELECT(MAX(freq)) FROM freq_cte); -- mode 5 minutes; frequence 297214

-- average ride duration for member and casual user
SELECT 'member' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes FROM v2_tripdata_combined_12 WHERE member_casual = 'member' -- 11,89
UNION ALL
SELECT 'casual' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes FROM v2_tripdata_combined_12 WHERE member_casual = 'casual'; -- 22,71


-- member average trip duration
SELECT ROUND(AVG(duration_minutes),2) AS member_average_trip
FROM v2_tripdata_combined_12
WHERE member_casual= 'member'; -- 11,89 minutes

-- casual average trip duration
SELECT ROUND(AVG(duration_minutes),2) AS casual_average_trip
FROM v2_tripdata_combined_12
WHERE member_casual= 'casual'; -- 22,71 minutes 

-- preferred rideable type among member and casual users
SELECT rideable_type,member_casual AS user,
COUNT(*) AS number_rides
FROM v2_tripdata_combined_12
WHERE member_casual='member'
GROUP BY rideable_type, member_casual -- Number of bikes taken (member): electric 950 116, classic 1 788 751
UNION ALL
SELECT rideable_type,member_casual AS user,
COUNT(*) AS number_rides
FROM v2_tripdata_combined_12
WHERE member_casual='casual'
GROUP BY rideable_type, member_casual; -- Number of bikes taken (casual): electric 569 179, classic 860 632, docked 75 376

-- Average ride duration by month and type of user
SELECT 'January' AS month, 'member' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'member' AND month_name = 'January' -- 9,73
UNION ALL
SELECT 'January' AS month, 'casual' AS user,  ROUND(AVG(duration_minutes),2) AS avg_duration_minutes 
FROM v2_tripdata_combined_12 WHERE member_casual = 'casual' AND month_name = 'January' -- 14,64
UNION ALL
SELECT 'February' AS month, 'member' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'member' AND month_name = 'February' -- 10,18
UNION ALL
SELECT 'February' AS month, 'casual' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'casual' AND month_name = 'February' -- 17,48
UNION ALL
SELECT 'March' AS month, 'member' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'member' AND month_name = 'March' -- 9,98
UNION ALL
SELECT 'March' AS month, 'casual' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'casual' AND month_name = 'March' -- 16,54
UNION ALL
SELECT 'April' AS month, 'member' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'member' AND month_name = 'April' -- 11,44
UNION ALL
SELECT 'April' AS month, 'casual' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'casual' AND month_name = 'April' -- 22,48
UNION ALL
SELECT 'May' AS month, 'member' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'member' AND month_name = 'May' -- 12,51
UNION ALL
SELECT 'May' AS month, 'casual' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'casual' AND month_name = 'May' -- 24,31
UNION ALL
SELECT 'June' AS month, 'member' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'member' AND month_name = 'June' -- 12,70
UNION ALL
SELECT 'June' AS month, 'casual' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'casual' AND month_name = 'June' -- 23,81
UNION ALL
SELECT 'July' AS month, 'member' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'member' AND month_name = 'July' -- 13,12
UNION ALL
SELECT 'July' AS month, 'casual' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'casual' AND month_name = 'July' -- 25,08
UNION ALL
SELECT 'August' AS month, 'member' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'member' AND month_name = 'August' -- 13,04
UNION ALL
SELECT 'August' AS month, 'casual' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'casual' AND month_name = 'August' -- 24,10
UNION ALL
SELECT 'September' AS month, 'member' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'member' AND month_name = 'September' -- 12,39
UNION ALL
SELECT 'September' AS month, 'casual' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'casual' AND month_name = 'September' -- 23,29
UNION ALL
SELECT 'October' AS month, 'member' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'member' AND month_name = 'October' -- 11,34
UNION ALL
SELECT 'October' AS month, 'casual' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'casual' AND month_name = 'October' -- 21,15
UNION ALL
SELECT 'November' AS month, 'member' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'member' AND month_name = 'November' -- 10,73
UNION ALL
SELECT 'November' AS month, 'casual' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'casual' AND month_name = 'November' -- 17,52
UNION ALL
SELECT 'December' AS month, 'member' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'member' AND month_name = 'December' -- 10,49
UNION ALL
SELECT 'December' AS month, 'casual' AS user, ROUND(AVG(duration_minutes),2) AS avg_duration_minutes
FROM v2_tripdata_combined_12 WHERE member_casual = 'casual' AND month_name = 'December'; -- 16,28

-- Top 10 the most popular stations amoung the members
SELECT start_station_name,
COUNT(*) AS number_member_rides
FROM v2_tripdata_combined_12
WHERE member_casual='member'
	AND start_station_name !=''
GROUP BY start_station_name
ORDER BY COUNT(*) DESC
LIMIT 10;

-- Top 10 the most popular stations among casual users
SELECT start_station_name,
COUNT(*) AS number_of_casual_rides
FROM v2_tripdata_combined_12
WHERE member_casual='casual'
	AND start_station_name !=''
GROUP BY start_station_name
ORDER BY COUNT(*) DESC
LIMIT 10; 


-- Number of "round trips": start station = end station among member and casual riders
SELECT COUNT(*) AS round_trips_member
FROM v2_tripdata_combined_12
WHERE start_station_name = end_station_name
AND member_casual = 'member'; -- 69 174 trips

SELECT COUNT(*) AS round_trips_casual
FROM v2_tripdata_combined_12
WHERE start_station_name = end_station_name
AND member_casual = 'casual'; -- 122 769

-- Because a number of riders which take bicycles back at the same station as they rented is very low,
-- it is worth finding top 10 end station for both member and casual riders

-- Top 10 the most popular end stations amoung the members
SELECT end_station_name,
COUNT(*) AS number_member_trips
FROM v2_tripdata_combined_12
WHERE member_casual='member'
	AND start_station_name !=''
GROUP BY start_station_name
ORDER BY COUNT(*) DESC
LIMIT 10;

-- Top 10 the most popular end stations among casual users
SELECT end_station_name,
COUNT(*) AS number_of_casual_trips
FROM v2_tripdata_combined_12
WHERE member_casual='casual'
	AND start_station_name !=''
GROUP BY start_station_name
ORDER BY COUNT(*) DESC
LIMIT 10; 

-- Number of rides taken depending on month and user type

-- for member:
SELECT month_name,
COUNT(*) AS member_trips_month
FROM new_tripdata_combined_12
WHERE member_casual='member'
GROUP BY month_name
ORDER BY member_trips_month DESC;

-- for casual:
SELECT month_name,
COUNT(*) AS member_trips_month
FROM new_tripdata_combined_12
WHERE member_casual='casual'
GROUP BY month_name;


SELECT day_name,
COUNT(*) AS member_trips_day
FROM v2_tripdata_combined_12
WHERE member_casual='member'
GROUP BY day_name
ORDER BY member_trips_day DESC; -- Wednesday, Thursday and Tuesday were the busiest days, and Sunday was the least busy

-- for casual:
SELECT day_name,
COUNT(*) AS casual_trips_day
FROM v2_tripdata_combined_12
WHERE member_casual='casual'
GROUP BY day_name
ORDER BY casual_trips_day DESC; -- Saturday, Sunday and Friday were the busiest among casual users. Beginng of the week 
-- was the least busy

-- saving results as csv 
SET SQL_SAFE_UPDATES = 0;

SELECT * FROM v2_tripdata_combined_12
INTO OUTFILE '/Users/oleksiirastorhuiev/Desktop/v1_final_tripdata_combined_12.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';

