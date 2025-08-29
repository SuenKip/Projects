--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Выведите для каждого покупателя его адрес проживания, 
--город и страну проживания.

SELECT concat(c.last_name,' ',c.first_name) as name, a.address, ci.city, co.country
from customer c
join address a using(address_id)
join city ci using(city_id) 
join country co using(country_id)

--ЗАДАНИЕ №2
--С помощью SQL-запроса посчитайте для каждого магазина количество его покупателей.

select s.store_id, count(c.customer_id)
from store s
join customer c using(store_id)
group by s.store_id

--Доработайте запрос и выведите только те магазины, 
--у которых количество покупателей больше 300-от.
--Для решения используйте фильтрацию по сгруппированным строкам 
--с использованием функции агрегации.

select s.store_id, count(c.customer_id)
from store s
join customer c using(store_id)
group by s.store_id
having count(c.customer_id) > 300

-- Доработайте запрос, добавив в него информацию о городе магазина, 
--а также фамилию и имя продавца, который работает в этом магазине.

select s.store_id, count(c.customer_id), ci.city, concat(st.first_name,' ',st.last_name) as namest
from store s
join customer c using(store_id)
join address a on s.address_id = a.address_id
join city ci using(city_id)
join staff st using(store_id)
group by s.store_id, ci.city_id, st.staff_id
having count(c.customer_id) > 300;

--ЗАДАНИЕ №3
--Выведите ТОП-5 покупателей, 
--которые взяли в аренду за всё время наибольшее количество фильмов

select concat(c.last_name,' ',c.first_name) as name, count(r.rental_id)
from customer c
join rental r using(customer_id)
group by c.customer_id
order by count(r.rental_id) desc 
limit 5;

--ЗАДАНИЕ №4
--Посчитайте для каждого покупателя 4 аналитических показателя:
--  1. количество фильмов, которые он взял в аренду
--  2. общую стоимость платежей за аренду всех фильмов (значение округлите до целого числа)
--  3. минимальное значение платежа за аренду фильма
--  4. максимальное значение платежа за аренду фильма

select concat(c.last_name,' ',c.first_name) as name, count(p.rental_id), round(sum(p.amount)), min(p.amount), max(p.amount)
from customer c 
join rental r using(customer_id)
join payment p using(rental_id)
group by c.customer_id

--ЗАДАНИЕ №5
--Используя данные из таблицы городов, составьте все возможные пары городов так, чтобы 
--в результате не было пар с одинаковыми названиями городов. Решение должно быть через Декартово произведение.

select c1.city as city1, c2.city as sity2
from city c1
cross join city c2
where c1.city != c2.city

--ЗАДАНИЕ №6
--Используя данные из таблицы rental о дате выдачи фильма в аренду (поле rental_date) и 
--дате возврата (поле return_date), вычислите для каждого покупателя среднее количество 
--дней, за которые он возвращает фильмы. В результате должны быть дробные значения, а не интервал.

select customer_id, round(avg(return_date :: date - rental_date :: date), 2) as count_day
from rental r
group by customer_id
order by customer_id asc

--======== ДОПОЛНИТЕЛЬНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Посчитайте для каждого фильма сколько раз его брали в аренду и значение общей стоимости аренды фильма за всё время.

select f.title, f.rating, c.name, f.release_year, l.name, count(r.rental_id) as count_rental, sum(p.amount) as sum_amount
from film f
join film_category fc on f.film_id = fc.film_id
join category c using(category_id)
join language l using(language_id)
join inventory i on f.film_id = i.film_id
join rental r using(inventory_id)
join payment p using(rental_id)
group by f.film_id, c.category_id, l.language_id
order by f.title asc

--ЗАДАНИЕ №2
--Доработайте запрос из предыдущего задания и выведите с помощью него фильмы, которые отсутствуют на dvd дисках.

select f.title, f.rating, c.name, f.release_year, l.name, count(r.rental_id) as count_rental, sum(p.amount) as sum_amount
from film f
join film_category fc on f.film_id = fc.film_id
join category c using(category_id)
join language l using(language_id)
left outer join inventory i on f.film_id = i.film_id 
left outer join rental r using(inventory_id)
left outer join payment p using(rental_id)
group by f.film_id, c.category_id, l.language_id
having count(r.rental_id) = 0
order by count(r.rental_id), f.title asc

--ЗАДАНИЕ №3
--Посчитайте количество продаж, выполненных каждым продавцом. Добавьте вычисляемую колонку "Премия".
--Если количество продаж превышает 7300, то значение в колонке будет "Да", иначе должно быть значение "Нет".
	
select s.staff_id, count(p.amount),
	case 
		when sum(p.amount) > 7300 then 'Да'
		else 'Нет'
	end as Премия
from staff s 
join payment p using(staff_id)
group by s.staff_id

select count(staff_id)
from staff s

select p.staff_id, count(p.amount),
	case 
		when sum(p.amount) > 7300 then 'Да'
		else 'Нет'
	end as Премия
from payment p
group by p.staff_id






















