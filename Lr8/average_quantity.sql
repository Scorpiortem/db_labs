use pizzeria;
select menu.ID AS ID, menu.name AS 'Название позиции', ROUND(AVG(deliv.quantity), 3) AS 'Среднее кол-во заказов'
FROM menu 
join deliveries deliv on menu.ID = deliv.menuID
group BY menu.ID