/*Создайте список общего количества мест, забронированных на один объект 
в месяц в 2012 году. Включите выходные строки, содержащие итоговые суммы 
за все месяцы по каждому объекту а также итоговые суммы за все месяцы для 
всех объектов. Выходная таблица должна состоять из идентификатора объекта, 
месяца и слотов, отсортированных по идентификатору и месяцу. При вычислении 
агрегированных значений для всех месяцев и всех facid возвращайте нулевые 
значения в столбцах месяца и facid.*/
USE cd; 
SELECT 	IFNULL(derived_table.facid, 'Total') AS facid, IFNULL(derived_table.Month, 'Total') AS Month, SUM(derived_table.slots) AS 'Количество броней' 
FROM (SELECT fac.facid AS facid, MONTH(book.starttime) AS month, SUM(book.slots) AS slots
FROM facilities AS fac
INNER JOIN bookings book ON fac.facid = book.facid
WHERE YEAR(book.starttime) = 2012 
GROUP BY facid, Month, slots) AS derived_table
GROUP BY facid, Month WITH ROLLUP;