/*Составьте список имен и идентификаторов каждого участника, 
а также их первого бронирования после 1 сентября 2012 г. 
Упорядочите по идентификатору участника.*/
USE cd;
SELECT mem.memid AS 'ID участника', mem.firstname AS 'Имя участника', mem.surname AS 'Фамилия участника', 
MIN(book.starttime) AS 'Первое бронирование после 1 сентября 2012 года'
FROM members AS mem
INNER JOIN bookings AS book ON mem.memid = book.memid
WHERE book.starttime >= '2012-09-01' AND mem.memid != 0
GROUP BY mem.memid, mem.firstname, mem.surname
ORDER BY mem.memid;