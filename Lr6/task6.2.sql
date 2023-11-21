/*Выберите количество аренд объектов клуба в каждый месяц.*/
USE cd;
SELECT YEAR(starttime) AS Год, MONTH(starttime) AS Месяц, facility AS 'Название объекта', COUNT(*) AS 'Количество аренд'
FROM bookings AS book
JOIN facilities AS fac ON book.facid = fac.facid
GROUP BY YEAR(starttime), MONTH(starttime), facility;