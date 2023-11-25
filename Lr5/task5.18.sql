USE cd;
WITH RECURSIVE DateRange AS (
    SELECT '2012-08-01' AS Date
    UNION ALL
    SELECT DATE_ADD(Date, INTERVAL 1 DAY) 
    FROM DateRange 
    WHERE Date < '2012-08-31'
),
TotalRevenue AS(
SELECT Daterange.Date, 
	Coalesce(SUM(
        CASE 
            WHEN b.memid = 0 THEN b.slots * f.guestcost 
            ELSE b.slots * f.membercost
        END), 0) as total_revenue
    FROM Daterange
    LEFT JOIN bookings b ON DATE(b.starttime) = Date
    LEFT JOIN facilities f ON b.facid = f.facid
    LEFT JOIN members m ON b.memid = m.memid
    GROUP BY Date
)
 SELECT DISTINCT DATE, ROUND((SELECT SUM(total_revenue) FROM TotalRevenue TR  
 WHERE b.starttime > TR.Date - INTERVAL 14 DAY AND b.starttime < TRD.Date + INTERVAL 1 DAY) / 15, 2) AS moving_average_revenue
FROM TotalRevenue TRD
LEFT JOIN bookings b ON DATE(b.starttime) = Date
ORDER BY Date;