/*Составьте список общего количества часов, забронированных на 
один объект, помня, что интервал длится полчаса. Выходная таблица 
должна состоять из идентификатора объекта, имени и забронированных часов, 
отсортированных по идентификатору объекта. Попробуйте отформатировать 
часы с точностью до двух десятичных знаков.*/
USE cd;
SELECT book.facid, f.facility, 
       ROUND(SUM(book.slots) / 2, 2) AS 'Общее кол-во часов'
FROM bookings as book
INNER JOIN facilities as f ON book.facid = f.facid
GROUP BY book.facid, f.facility
ORDER BY book.facid;