SELECT f.stationid, year, city, AVG(wastecollected) AS TotalWasteCollected
FROM facttrips f
JOIN dimdate dd ON f.dateid = dd.dateid
JOIN dimstation ds ON f.stationid = ds.stationid
GROUP BY CUBE(year, city, f.stationid)
LIMIT 10
;




