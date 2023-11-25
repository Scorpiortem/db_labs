/*Выведите наименования всех объектов клуба заглавными буквами, 
если они содержат в названии слово ‘Tennis’*/
USE cd;
SELECT UPPER(facility) AS 'Названия заглавными буквами' FROM facilities 
WHERE facility LIKE '%TENNIS%';