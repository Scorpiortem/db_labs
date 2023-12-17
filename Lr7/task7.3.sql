/*Напишите процедуру, которая считает окупаемость каждого объекта клуба на 
основании оплаты аренд за месяц. Применить ее к июлю 2012 года. */
USE cd;

DELIMITER $$

DROP PROCEDURE IF EXISTS payback $$
CREATE PROCEDURE payback(currentDate DATE)
READS SQL DATA
NOT DETERMINISTIC
  BEGIN
    SELECT book.facid, fac.facility, SUM(pay.payment) - fac.monthlymaintenance AS Доход
	FROM bookings AS book
	JOIN payments AS pay ON book.bookid = pay.bookid
	JOIN facilities AS fac ON book.facid = fac.facid
	WHERE DATE_FORMAT(starttime, '%y %m') = DATE_FORMAT(currentDate, '%y %m')
	GROUP BY book.facid ORDER BY book.facid;
  END $$

DELIMITER ;

CALL payback('2012-07-18');