/*Найти свободных доставщиков*/
USE pizzeria;
SELECT delman.ID, delman.fullname AS 'ФИО', delman.phonenumber AS 'Номер телефона' FROM deliveryman delman
LEFT JOIN deliveries deliv ON delman.ID = deliv.deliverymanID
WHERE deliv.deliverymanID IS NULL;