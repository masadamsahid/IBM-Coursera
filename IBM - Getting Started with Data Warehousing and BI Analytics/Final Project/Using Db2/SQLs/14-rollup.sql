SELECT f.stationid, year, city, SUM(wastecollected) AS TotalWasteCollected
FROM facttrips f
JOIN dimdate dd ON f.dateid = dd.dateid
JOIN dimstation ds ON f.stationid = ds.stationid
GROUP BY ROLLUP(year, city, f.stationid)
LIMIT 10
;




