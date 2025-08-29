--ЗАДАНИЕ №1
--Спроектируйте базу данных, содержащую три справочника:
--· язык (английский, французский и т. п.);
--· народность (славяне, англосаксы и т. п.);
--· страны (Россия, Германия и т. п.).
--Две таблицы со связями: язык-народность и народность-страна, отношения многие ко многим. Пример таблицы со связями — film_actor.
--Требования к таблицам-справочникам:
--· наличие ограничений первичных ключей.
--· идентификатору сущности должен присваиваться автоинкрементом;
--· наименования сущностей не должны содержать null-значения, не должны допускаться --дубликаты в названиях сущностей.
--Требования к таблицам со связями:
--· наличие ограничений первичных и внешних ключей.
--В качестве ответа на задание пришлите запросы создания таблиц и запросы по --добавлению в каждую таблицу по 5 строк с данными.
 
--СОЗДАНИЕ ТАБЛИЦЫ ЯЗЫКИ

create table language (
	language_id serial primary key,
	language_name varchar(100) not null unique
)

--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ ЯЗЫКИ

insert into language (language_name)
values ('Английский'), ('Французский'), ('Немецкий'), ('Японский'), ('Русский')

--СОЗДАНИЕ ТАБЛИЦЫ НАРОДНОСТИ

create table nation (
	nation_id serial primary key,
	nation_name varchar(100) not null unique
)

--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ НАРОДНОСТИ

insert into nation (nation_name)
values ('Евреи'), ('Славяне'), ('Англосаксы'), ('Буряты'), ('Узбеки')

--СОЗДАНИЕ ТАБЛИЦЫ СТРАНЫ

create table country (
	country_id serial primary key,
	country_name varchar(100) not null unique
)

--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ СТРАНЫ

insert into country (country_name)
values ('Америка'), ('Франция'), ('Германия'), ('Япония'), ('Россия')

--СОЗДАНИЕ ПЕРВОЙ ТАБЛИЦЫ СО СВЯЗЯМИ

create table language_nation (
	language_id int references language(language_id),
	nation_id int references nation(nation_id),
	primary key (language_id, nation_id)
)

--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ СО СВЯЗЯМИ

insert into language_nation (language_id, nation_id)
values (5, 1), (1, 2), (2, 4), (3, 3), (4, 5)

--СОЗДАНИЕ ВТОРОЙ ТАБЛИЦЫ СО СВЯЗЯМИ

create table country_nation ( 
	country_id int references country(country_id),
	nation_id int references nation(nation_id),
	primary key (country_id, nation_id)
)

--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ СО СВЯЗЯМИ

insert into country_nation (country_id, nation_id)
values (1, 1), (2, 2), (5, 4), (3, 3), (4, 5)
