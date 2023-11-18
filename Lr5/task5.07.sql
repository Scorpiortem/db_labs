/*Найдите общее количество участников (члены + гости), 
совершивших хотя бы одно бронирование.*/
USE cd;
SELECT COUNT(DISTINCT book.memid) AS 'Кол-во участников'
FROM bookings AS book;