CREATE TABLE max_waste_stats (city, stationid, trucktype, max_waste_collected) AS (
	SELECT city, f.stationid, trucktype, MAX(f.wastecollected)
	FROM facttrips f
	LEFT JOIN dimstation ds ON f.stationid = ds.stationid
	LEFT JOIN dimtruck dt ON f.truckid = dt.truckid
    GROUP BY city, f.stationid, trucktype
)
DATA INITIALLY DEFERRED
REFRESH DEFERRED
MAINTAINED BY SYSTEM
;

REFRESH TABLE max_waste_stats; -- REFRESH THE MQT TO BE POPULATED

SELECT * FROM max_waste_stats LIMIT 10; -- TEST RESULT
