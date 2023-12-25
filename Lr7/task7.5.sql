/*Произведите изменения в стоимости аренды объектов согласно расчету задания Task-7-4, 
написав update-скрипт. Напишите скрипт отмечающий оплату всех аренд за , используя функцию Task-7-3 .
Сравните, совпадают ли расчетные данные с теми, что были Вами получены в задании Task-7-4.*/
USE cd;
START TRANSACTION;
  CALL payback(4, MONTH('2012-07-18'), YEAR('2012-07-18'));

  SET @coef = 2;
  SET @exacttime = '2012-07-31-23:59:59';
  UPDATE facilities
    SET guestcost = guestcost * (SELECT CalculateRentalChange(facid, @coef, @exacttime)), membercost = membercost * (SELECT CalculateRentalChange(facid, @coef, @exacttime));
  UPDATE bookings
    SET payed = 1
    WHERE DATE(starttime) < '2012-09-01' AND DATE(starttime) >= '2012-08-01';
  
  CALL payback(4, MONTH('2012-08-03'), YEAR('2012-08-03'));
ROLLBACK;