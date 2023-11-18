/*Создайте список общего количества мест, забронированных на один объект 
в месяц в 2012 году. Включите выходные строки, содержащие итоговые суммы 
за все месяцы по каждому объекту а также итоговые суммы за все месяцы для 
всех объектов. Выходная таблица должна состоять из идентификатора объекта, 
месяца и слотов, отсортированных по идентификатору и месяцу. При вычислении 
агрегированных значений для всех месяцев и всех facid возвращайте нулевые 
значения в столбцах месяца и facid.*/
USE cd;
SELECT facid, 
       CASE WHEN starttime LIKE '2012-01%' THEN '2012-01'
            WHEN starttime LIKE '2012-02%' THEN '2012-02'
            WHEN starttime LIKE '2012-03%' THEN '2012-03'
            WHEN starttime LIKE '2012-04%' THEN '2012-04'
            WHEN starttime LIKE '2012-05%' THEN '2012-05'
            WHEN starttime LIKE '2012-06%' THEN '2012-06'
            WHEN starttime LIKE '2012-07%' THEN '2012-07'
            WHEN starttime LIKE '2012-08%' THEN '2012-08'
            WHEN starttime LIKE '2012-09%' THEN '2012-09'
            WHEN starttime LIKE '2012-10%' THEN '2012-10'
            WHEN starttime LIKE '2012-11%' THEN '2012-11'
            WHEN starttime LIKE '2012-12%' THEN '2012-12'
            ELSE 'Total' END AS month,
       SUM(slots) AS total_slots
FROM bookings
WHERE starttime >= '2012-01-01' AND starttime < '2013-01-01'
GROUP BY facid, month
WITH ROLLUP
ORDER BY facid, month;