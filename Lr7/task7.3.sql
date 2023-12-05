/*Напишите процедуру, которая считает окупаемость каждого объекта клуба на 
основании оплаты аренд за месяц. Применить ее к июлю 2012 года. */
USE cd;

DELIMITER $$

DROP PROCEDURE IF EXISTS payback $$
CREATE PROCEDURE payback()
  BEGIN
    SELECT book.facid, fac.facility, SUM(pay.payment) - fac.monthlymaintenance AS Доход
	FROM bookings AS book
	JOIN payments AS pay ON book.bookid = pay.bookid
	JOIN facilities AS fac ON book.facid = fac.facid
	WHERE DATE(starttime) < '2012-08-01' AND DATE(starttime) >= '2012-07-01'
	GROUP BY book.facid ORDER BY book.facid;
  END $$

DELIMITER ;

CALL payback;