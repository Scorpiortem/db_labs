/*Составьте список объектов вместе с их общим доходом. Выходная таблица 
должна состоять из названия объекта и доходов, отсортированных по доходам. 
Помните, что для гостей и участников действуют разные цены!*/
USE cd;
SELECT f.facid AS Facility_name,
       SUM(CASE WHEN mem.memid = 0 THEN f.guestcost * book.slots
                ELSE f.membercost * book.slots END) AS Total_income
FROM bookings AS book
INNER JOIN facilities AS f ON book.facid = f.facid
LEFT JOIN members AS mem ON book.memid = mem.memid
GROUP BY f.facid
ORDER BY Total_income DESC;