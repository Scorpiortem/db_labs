/*Составьте список участников (включая гостей) вместе с количеством 
часов, которые они забронировали для объекта,  округленным до ближайших 
десяти часов. Ранжируйте их по этой округленной цифре, получая в результате 
имя, фамилию, округленные часы и звание (== ранг). Сортировка по званию 
(== рангу), фамилии и имени.*/
USE cd;
SELECT mem.firstname AS 'Имя', mem.surname AS 'Фамилия', ROUND(SUM(book.slots) / 2, -1) AS Rounded_hours,
    CASE 
        WHEN mem.memid = 0 THEN 'гость' 
        ELSE 'участник' 
    END AS status
FROM bookings AS book
LEFT JOIN members AS mem ON mem.memid = book.memid
GROUP BY mem.memid, status
ORDER BY status, Rounded_hours, mem.surname, mem.firstname;