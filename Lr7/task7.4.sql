/*Напишите функцию, которая будет рассчитывать увеличение/уменьшение 
стоимость аренды объекта на последующие месяцы  для изменения ( увеличения или уменьшения) 
срока окупаемость на заданную долю (в процентах) на основании расчета окупаемости за уже
оплаченные периоды. Сохраните расчет в виде csv или sql файла (например, используя временные таблицы). */
USE cd;

DELIMITER //

DROP FUNCTION IF EXISTS CalculateRentalChange //
CREATE FUNCTION CalculateRentalChange(facid INT, frac FLOAT, starttime TIMESTAMP, stoptime TIMESTAMP)
  RETURNS VARCHAR(50)
  READS SQL DATA
  NOT DETERMINISTIC
  BEGIN
    DECLARE Доход DECIMAL(10, 2);
    DECLARE Обслуживание DECIMAL(10, 2);
    DECLARE Чистый_доход DECIMAL(10, 2);
    DECLARE Стоимость DECIMAL(10, 2);
    DECLARE coef DECIMAL(10, 2);

    -- Сколько компания получила дохода за всё время использования объекта без учёта стоимости обсулуживания
    SELECT SUM(p.payment) INTO Доход
      FROM payments AS p
        JOIN bookings AS b ON b.bookid = p.bookid
        JOIN facilities AS f ON b.facid = f.facid
      WHERE facid = b.facid AND
        b.starttime BETWEEN starttime AND stoptime
      GROUP BY b.facid;

    IF Доход IS NULL THEN 
    RETURN 1;
    END IF;


   -- Сколько компания тратила на обслуживание объекта за всё время
    SELECT f.monthlymaintenance * (MONTH(stoptime) - MONTH(starttime) + 1) INTO Обслуживание
	FROM facilities AS f
	JOIN bookings AS b ON b.facid = f.facid WHERE facid = b.facid
	GROUP BY b.facid;

    -- Во сколько обошёлся объект
    SELECT f.initialoutlay INTO Стоимость FROM facilities AS f
	WHERE facid = f.facid;

    -- Чистый доход объекта
    SET Чистый_доход = (Доход - Обслуживание);
    -- Проверка на окупаемость, если чистый доход не превысит нуль, то делаем вывод, что объект не окупился
    -- Если стоимость объекта оказалась ниже или равна чистому доходу, то объект уже стал окупаемым 
    IF Чистый_доход <= 0 OR Стоимость <= Чистый_доход 
    THEN 
    RETURN 1;
    END IF;
    -- Рассчёт коэффицента для стоимости аренды объекта
    SET coef = ((1 / frac) * (Стоимость - Чистый_доход) / Стоимость * (1 - Обслуживание / Доход) + Обслуживание / Доход);
    RETURN coef;
  END //

DELIMITER ;

SELECT CalculateRentalChange(2, 5, '2012-07-01','2012-07-31 23:59:59')
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/output.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';