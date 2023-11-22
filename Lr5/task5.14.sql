/*Выведите идентификатор объекта, в котором забронировано наибольшее 
количество мест (slot). Убедитесь, что в случае ничьей все результаты 
привязки будут выведены.Примечание: используйте функцию ранжирования*/
USE cd;
SELECT DISTINCT facid, slots
FROM (
  SELECT facid, slots, RANK() OVER (ORDER BY slots DESC) AS rnk
  FROM bookings
) AS subquery
WHERE rnk = 1;