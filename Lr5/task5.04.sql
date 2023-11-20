/*Рассчитайте количество аренд каждого из объектов клуба.*/
USE cd;
SELECT facility AS 'Объекты клуба', SUM(book.slots) AS 'Кол-во аренд'
FROM facilities AS fac
INNER JOIN bookings AS book ON book.facid = fac.facid
GROUP BY fac.facid;