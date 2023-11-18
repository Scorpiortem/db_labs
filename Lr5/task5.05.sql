/*Рассчитайте количество аренд каждого из объектов клуба за сентябрь 2012 года.*/
USE cd;
SELECT facility AS 'Объекты клуба', SUM(book.slots) AS 'Кол-во аренд'
FROM facilities AS fac
LEFT JOIN bookings AS book ON book.facid = fac.facid
WHERE book.slots IS NOT NULL AND starttime LIKE '%2012-09%'
GROUP BY fac.facid;