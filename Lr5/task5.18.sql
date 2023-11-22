/*Для каждого дня августа 2012 года рассчитайте скользящее 
среднее общего дохода за предыдущие 15 дней. Вывод должен 
содержать столбцы даты и дохода, отсортированные по дате. 
Не забудьте учесть возможность того, что в день будет нулевой доход. 
Примечание: используйте DATE_ADD для генерации серии дат.*/
USE cd;
WITH RECURSIVE DateRange AS (
    SELECT '2012-08-01 00:00:00' AS Дата
    UNION ALL
    SELECT DATE_ADD(Дата, INTERVAL 1 DAY) 
    FROM DateRange 
    WHERE Дата < '2012-08-31 23:59:59'
),
RevenuePerDay AS (
    SELECT DateRange.Дата, COALESCE(SUM(b.slots), 0) AS total_revenue
    FROM DateRange
    LEFT JOIN bookings b ON DATE(b.starttime) = DateRange.Дата
    GROUP BY Дата
)
SELECT Дата, ROUND((SELECT AVG(total_revenue) FROM RevenuePerDay RP 
WHERE RP.Дата BETWEEN DATE_SUB(RPD.Дата, INTERVAL 14 DAY) AND RPD.Дата), 2) AS Скользящее_среднее
FROM RevenuePerDay RPD
ORDER BY Дата;