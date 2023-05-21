1. Which manufacturer's planes had most no of flights? And how many flights?


SELECT p.manufacturer, COUNT(*) AS flight_count
FROM flights f
JOIN planes p ON f.tailnum = p.tailnum
GROUP BY p.manufacturer
ORDER BY flight_count DESC
LIMIT 1;


2. Which manufacturer's planes had most no of flying hours? And how many hours?


SELECT p.manufacturer, SUM(CAST(f.air_time AS INT)) AS total_flying_hours
FROM flights f
JOIN planes p ON f.tailnum = p.tailnum
GROUP BY p.manufacturer
ORDER BY total_flying_hours DESC
LIMIT 1;

3. Which plane flew the most number of hours? And how many hours?


SELECT p.tailnum, SUM(CAST(f.air_time AS INT)) AS total_flying_hours
FROM flights f
JOIN planes p ON f.tailnum = p.tailnum
GROUP BY p.tailnum
ORDER BY total_flying_hours DESC
LIMIT 1;

4. Which destination had most delay in flights?


SELECT dest, SUM(CAST(arr_delay AS INT)) AS total_delay
FROM flights
GROUP BY dest
ORDER BY total_delay DESC
LIMIT 1;

5. Which manufactures planes had covered most distance? And how much distance?

SELECT p.manufacturer, SUM(f.distance) AS total_distance
FROM flights f
JOIN planes p ON f.tailnum = p.tailnum
GROUP BY p.manufacturer
ORDER BY total_distance DESC
LIMIT 1;
 
 
 Which airport had most flights on weekends?

SELECT origin, COUNT(*) AS flight_count
FROM flights
WHERE strftime('%w', date(year || '-' || month || '-' || day)) IN ('0', '6') -- Select weekends (0 = Sunday, 6 = Saturday)
GROUP BY origin
ORDER BY flight_count DESC
LIMIT 1;
