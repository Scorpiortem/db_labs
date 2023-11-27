	/*Выберите процент использования объектов по месяцам, 
	упорядочив по возрастанию*/
USE cd;
WITH slots as (SELECT facility, SUM(b.slots) AS Стоимость_аренды,   
DATE_FORMAT(b.starttime, '%y %m') AS Год_Месяц
FROM facilities AS f
JOIN bookings AS b ON b.facid = f.facid
GROUP BY f.facid, Год_Месяц
)
SELECT sl1.facility AS 'Объекты', 
ROUND(sl1.Стоимость_аренды / SUM(sl2.Стоимость_аренды) * 100, 1) AS Процент_использования_объектов_в_месяц,
sl1.Год_Месяц
FROM slots AS sl1
JOIN slots AS sl2 ON sl1.Год_Месяц = sl2.Год_Месяц
GROUP BY sl1.facility, sl1.Стоимость_аренды, sl1.Год_Месяц
ORDER BY Процент_использования_объектов_в_месяц ASC;