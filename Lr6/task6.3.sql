	/*Выберите процент использования объектов по месяцам, 
	упорядочив по возрастанию*/
SELECT facility AS 'Объекты',
MONTH(book.starttime) AS Месяц,
(SUM(book.slots) / (SELECT SUM(slots) FROM bookings
WHERE bookings.facid = fac.facility)) * 100 AS Процент_использования_объектов_в_месяц
FROM bookings AS book
INNER JOIN facilities AS fac ON book.facid = fac.facility
GROUP BY fac.facility, Месяц
ORDER BY Процент_использования_объектов_в_месяц ASC;