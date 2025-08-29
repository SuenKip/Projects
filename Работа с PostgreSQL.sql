--ЗАДАНИЕ №1
--Сделайте запрос к таблице payment и с помощью оконных функций добавьте вычисляемые колонки согласно условиям:
--Пронумеруйте все платежи от 1 до N по дате платежа
--Пронумеруйте платежи для каждого покупателя, сортировка платежей должна быть по дате платежа
--Посчитайте нарастающим итогом сумму всех платежей для каждого покупателя, сортировка должна 
--быть сперва по дате платежа, а затем по размеру платежа от наименьшей к большей
--Пронумеруйте платежи для каждого покупателя по размеру платежа от наибольшего к
--меньшему так, чтобы платежи с одинаковым значением имели одинаковое значение номера.
--Можно составить на каждый пункт отдельный SQL-запрос, а можно объединить все колонки в одном запросе.

select customer_id, payment_id, payment_date, row_number() over(order by payment_date), 
	row_number() over(partition by customer_id order by payment_date), 
	sum(amount) over(partition by customer_id order by payment_date, amount asc),
	dense_rank() over(partition by customer_id order by amount desc)
from payment p 

--ЗАДАНИЕ №2
--С помощью оконной функции выведите для каждого покупателя стоимость платежа и стоимость 
--платежа из предыдущей строки со значением по умолчанию 0.0 с сортировкой по дате платежа.

select customer_id, payment_id, amount, payment_date, 
	lag(amount, 1, 0.0) over(partition by customer_id  order by payment_date)
from payment p 

--ЗАДАНИЕ №3
--С помощью оконной функции определите, на сколько каждый следующий платеж покупателя больше или меньше текущего.

select customer_id, payment_id, amount, payment_date, 
	(lag(amount, 1, 0.0) over (partition by customer_id  order by payment_date) - amount)
from payment p 

--ЗАДАНИЕ №4
--С помощью оконной функции для каждого покупателя выведите данные о его последней оплате аренды.

select customer_id, 
	first_value(payment_id) over(partition by customer_id order by payment_date desc),
	first_value(payment_date) over(partition by customer_id order by payment_date desc),
	first_value(amount) over(partition by customer_id order by payment_date desc)
from payment p 




