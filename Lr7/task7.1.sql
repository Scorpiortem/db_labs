/*Создайте функцию, которая рассчитывает стоимость каждой аренды 
(для каждой записи таблицы bookings).*/
USE cd;
DELIMITER $$
DROP FUNCTION IF EXISTS CalculateRentalCost;
CREATE FUNCTION CalculateRentalCost(memid INT, facid INT, slots INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE Стоимость_аренды DECIMAL(10, 2);
    SELECT 
        CASE 
            WHEN memid = 0 THEN guestcost * slots
            ELSE membercost * slots
        END INTO Стоимость_аренды
    FROM facilities
    WHERE facid = facilities.facid;
    RETURN Стоимость_аренды;
END$$
DELIMITER ;
SELECT CalculateRentalCost(memid, facid, slots) AS Стоимость_аренды
FROM bookings;