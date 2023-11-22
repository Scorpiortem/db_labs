/*Составьте список объектов вместе с их общим доходом. Выходная таблица 
должна состоять из названия объекта и доходов, отсортированных по доходам. 
Помните, что для гостей и участников действуют разные цены!*/
USE cd;
SELECT fac.facility AS 'Название объекта',
       SUM(CASE WHEN book.memid = 0 THEN fac.guestcost * book.slots
                ELSE fac.membercost * book.slots END) AS Total_income
FROM facilities AS fac
LEFT JOIN bookings AS book ON book.facid = fac.facid
GROUP BY fac.facility
ORDER BY Total_income DESC;