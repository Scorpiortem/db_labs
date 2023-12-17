/*Создайте таблицу payments со структурой (payid INT PK, FK on booking.bookid; payment  DECIMAL.
 Добавьте в таблицу bookings поле payed, смысл которого оплачена или не оплачена аренда. Создайте триггеры, которые 
Запрещают удаление записей, если они уже оплачены;
После отметки оплаты, заносят в таблицу  payments запись с соответствующим значением PK и суммой оплаты,  для вычисления которой используется функция созданная в Task-7-1.
При отмене оплаты - удаляет соответствующую запись в таблице payments.    
Напишите скрипт, который отмечает, что все аренды июля 2012 года оплачены. Посчитайте (написав соответствующий скрипт) оплату на июль 2012 года двумя способами: 
-используя данные таблицы payments
-используя только функцию из Task-7-1 и данные таблицы bookings.
Сравните результаты расчета.*/
USE cd;
DELIMITER $$
DROP TRIGGER IF EXISTS prevent_paid_deletion $$
CREATE TRIGGER prevent_paid_deletion
BEFORE DELETE ON bookings
FOR EACH ROW
BEGIN
  IF (OLD.payed = 1) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Нельзя удалить оплаченную запись!';
	END IF;
END $$

DROP TRIGGER IF EXISTS insert_payment_record $$
CREATE TRIGGER insert_payment_record
AFTER UPDATE ON bookings
FOR EACH ROW
BEGIN
  CASE
		WHEN NEW.payed = OLD.payed THEN 
        BEGIN END;
		WHEN NEW.payed = 1 THEN
			INSERT INTO payments (bookid, payment) VALUES (NEW.bookid, CalculateRentalCost(NEW.memid, NEW.facid, NEW.slots));
		WHEN NEW.payed = 0 THEN
        DELETE FROM payments AS pay 
        WHERE pay.bookid =  NEW.bookid;
	END CASE;
END $$

DROP TRIGGER IF EXISTS already_payed $$
CREATE TRIGGER already_payed 
AFTER INSERT ON bookings
FOR EACH ROW 
BEGIN
	IF NEW.payed = 1 THEN
		INSERT INTO payments(bookid, payment)
        VALUES(NEW.bookid, CalculateRentalCost(NEW.memid, NEW.facid, NEW.slots));
	END IF;
END $$

DELIMITER ;

UPDATE bookings 
SET payed = 1
WHERE YEAR(starttime) = 2012 AND MONTH(starttime) = 7; 

SELECT SUM(payment) AS "Общая стоимость"
FROM payments;

SELECT SUM(CalculateRentalCost(memid, facid, slots)) AS "Общая стоимость"
FROM bookings book
WHERE MONTH(starttime) = 7 AND YEAR(starttime) = 2012;