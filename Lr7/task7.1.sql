/*Создайте функцию, которая рассчитывает стоимость каждой аренды 
(для каждой записи таблицы bookings).*/
USE cd;
DELIMITER $$
DROP FUNCTION IF EXISTS CalculateRentalCost;
CREATE FUNCTION CalculateRentalCost(memid INT, facid INT, slots INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE Стоимость_аренды INT;
    SET Стоимость_аренды = (SELECT 
			IF(memid = 0, guestcost, membercost) * slots
			FROM facilities
			WHERE facid = facilities.facid);
    RETURN Стоимость_аренды;
END$$
DELIMITER ;
SELECT CalculateRentalCost(memid, facid, slots) AS Стоимость_аренды
FROM bookings;