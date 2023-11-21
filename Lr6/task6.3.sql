	/*Выберите процент использования объектов по месяцам, 
	упорядочив по возрастанию*/
USE cd;
SELECT YEAR(starttime) AS Год, MONTH(starttime) AS Месяц,
ROUND(COUNT(slots)/(SELECT COUNT(*) FROM bookings) * 100, 3) AS 'Процент использования объектов в месяц' FROM bookings
GROUP BY Месяц, Год
ORDER BY Месяц, Год;