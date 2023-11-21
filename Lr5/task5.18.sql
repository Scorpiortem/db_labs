/*Для каждого дня августа 2012 года рассчитайте скользящее 
среднее общего дохода за предыдущие 15 дней. Вывод должен 
содержать столбцы даты и дохода, отсортированные по дате. 
Не забудьте учесть возможность того, что в день будет нулевой доход. 
Примечание: используйте DATE_ADD для генерации серии дат.*/
USE cd;
SELECT
    DATE(book.starttime) AS date,
    SUM(IF(book.memid = 0, fac.guestcost, fac.membercost) * book.slots) AS Income,
    AVG(fac.membercost + fac.guestcost) AS Moving_Avg_Income
FROM bookings book
JOIN facilities fac ON book.facid = fac.facid
WHERE DATE(book.starttime) BETWEEN '2012-08-01' AND '2012-08-31'
GROUP BY DATE(book.starttime)
ORDER BY DATE(book.starttime);