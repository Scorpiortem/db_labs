/*Составьте список общего количества бронирований 
на каждый объект в месяц в 2012 году.*/
USE cd;
SELECT fac.facility AS 'Объект', MONTH(book.starttime) AS 'Месяц', SUM(book.slots) AS 'Кол-во бронирований'
FROM facilities AS fac
INNER JOIN bookings AS book ON fac.facid = book.facid WHERE YEAR(book.starttime) = 2012
GROUP BY fac.facility, MONTH(book.starttime); 