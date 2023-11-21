/*Выберите начальное и конечное время последних 10 аренд  объектов, 
упорядочив их по времени их окончания.*/
USE cd;
SELECT starttime AS 'Начальное время', ADDTIME(starttime, SEC_TO_TIME(slots * 1800)) AS Конечное_время
FROM bookings
ORDER BY Конечное_время DESC
LIMIT 10;