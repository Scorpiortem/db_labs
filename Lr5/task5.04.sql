/*Рассчитайте количество аренд каждого из объектов клуба.*/
USE cd;
SELECT facility AS 'Объекты клуба', SUM(book.slots) AS 'Кол-во аренд'
FROM facilities AS fac
LEFT JOIN bookings AS book ON book.facid = fac.facid
WHERE book.slots IS NOT NULL
GROUP BY fac.facid;