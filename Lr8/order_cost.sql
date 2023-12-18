/*Найти стоимость каждого заказа*/
USE pizzeria;
SELECT deliv.ID, deliv.deliveryID AS 'ID доставки', deliv.menuID AS 'ID меню', deliv.quantity AS 'Кол-во продуктов', deliv.quantity * menu.price AS 'Стоимость заказа' FROM deliveries deliv
LEFT JOIN menu ON menu.ID = deliv.menuID;