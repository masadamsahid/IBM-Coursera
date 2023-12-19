SELECT stationid, trucktype, SUM(wastecollected) AS TotalWasteCollected
FROM facttrips f
LEFT JOIN dimtruck d ON f.truckid = d.truckid
GROUP BY GROUPING SETS(stationid, trucktype)
LIMIT 10
;




