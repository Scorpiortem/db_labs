/*Создайте список объектов с общим доходом менее 1000. Создайте выходную таблицу, 
состоящую из названия объекта и дохода, отсортированного по доходу. Помните, что 
для гостей и участников действуют разные цены!*/
USE cd;
SELECT fac.facility AS 'Название объекта',
       SUM(CASE WHEN book.memid = 0 THEN fac.guestcost * book.slots
                ELSE fac.membercost * book.slots END) AS Total_income
FROM facilities AS fac
LEFT JOIN bookings AS book ON book.facid = fac.facid
GROUP BY fac.facility
HAVING Total_income < 1000
ORDER BY Total_income DESC;