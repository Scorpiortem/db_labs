/*Напишите процедуру, которая считает окупаемость каждого объекта клуба на 
основании оплаты аренд за месяц. Применить ее к июлю 2012 года. */
USE cd;

DELIMITER $$

DROP PROCEDURE IF EXISTS payback $$
CREATE PROCEDURE payback(currentfacid INT, mes INT, god INT)
READS SQL DATA
NOT DETERMINISTIC
BEGIN
	WITH temp AS(
      SELECT b.starttime AS Дата, SUM(p.payment) OVER (
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) - f.initialoutlay AS Доход
        FROM payments AS p
		JOIN bookings AS b ON b.bookid = p.bookid
		JOIN facilities AS f ON b.facid = f.facid
        WHERE currentfacid = b.facid AND
		MONTH(starttime) = mes AND YEAR(starttime) = god
        ORDER BY b.starttime)
    SELECT Дата FROM temp WHERE Доход > 0 LIMIT 1;	
  END $$

CALL payback(4, MONTH('2012-07-18'), YEAR('2012-07-18'));