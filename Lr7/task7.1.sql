/*Создайте функцию, которая рассчитывает стоимость каждой аренды 
(для каждой записи таблицы bookings).*/
USE cd;
DELIMITER $$
DROP FUNCTION IF EXISTS CalculateRentalCost;
CREATE FUNCTION CalculateRentalCost(memberID INT, bookID INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE Стоимость_аренды DECIMAL(10, 2);
    SELECT 
        CASE 
            WHEN m.memid = 0 THEN f.guestcost * b.slots
            ELSE f.membercost * b.slots
        END INTO Стоимость_аренды
    FROM bookings b
    INNER JOIN facilities f ON b.facid = f.facid
    LEFT JOIN members m ON m.memid = memberID
    WHERE b.bookid = bookID;
    RETURN Стоимость_аренды;
END$$
DELIMITER ;
SELECT CalculateRentalCost(memid, bookid) AS Стоимость_аренды
FROM bookings;