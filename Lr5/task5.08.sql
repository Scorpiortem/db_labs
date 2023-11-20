/*Составьте список объектов вместе с их общим доходом. Выходная таблица 
должна состоять из названия объекта и доходов, отсортированных по доходам. 
Помните, что для гостей и участников действуют разные цены!*/
USE cd;
SELECT fac.facility AS 'Название объекта',
       SUM(CASE WHEN mem.memid = 0 THEN fac.guestcost * book.slots
                ELSE fac.membercost * book.slots END) AS Total_income
FROM bookings AS book
INNER JOIN facilities AS fac ON book.facid = fac.facid
LEFT JOIN members AS mem ON book.memid = mem.memid
GROUP BY fac.facid
ORDER BY Total_income DESC;