/*Создайте список объектов с общим доходом менее 1000. Создайте выходную таблицу, 
состоящую из названия объекта и дохода, отсортированного по доходу. Помните, что 
для гостей и участников действуют разные цены!*/
USE cd;
SELECT f.facid AS Facility_name,
       SUM(CASE WHEN mem.memid = 0 THEN f.guestcost * book.slots
                ELSE f.membercost * book.slots END) AS Total_income
FROM bookings AS book
INNER JOIN facilities AS f ON book.facid = f.facid
LEFT JOIN members AS mem ON book.memid = mem.memid
GROUP BY f.facid
HAVING Total_income < 1000
ORDER BY Total_income DESC;