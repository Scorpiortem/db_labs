/*Рассчитайте количество аренд каждого из объектов клуба за сентябрь 2012 года.*/
USE cd;
SELECT facility AS 'Объекты клуба', SUM(book.slots) AS 'Кол-во аренд'
FROM facilities AS fac
INNER JOIN bookings AS book ON book.facid = fac.facid
WHERE book.starttime >= '2012-09-01' AND book.starttime < '2012-10-01'
GROUP BY fac.facid;