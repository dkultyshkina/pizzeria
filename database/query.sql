

select name, age FROM person WHERE address = 'Moscow';

select name, age from person where address = 'Moscow' AND gender = 'female' order by name;

select name, rating from pizzeria where rating <= 5 AND rating >= 3.5 order by rating;

select name, rating from pizzeria where rating BETWEEN 3.5 AND 5 order by rating;

select DISTINCT person_id from person_visits where visit_date BETWEEN '2022-01-06' AND '2022-01-09' OR pizzeria_id = 2 order by person_id DESC;

select CONCAT(name, ' ', '(age:', age,',gender:''', gender,''',address:''', address, ''')') AS person_information from person order by name;

select DISTINCT (select name from person where person.id = person_order.person_id) as name from person_order where (menu_id = 13 or menu_id = 14 or menu_id = 18) and order_date = '2023-01-07';

select (select name from person where person.id = person_order.person_id) as name, 
case
when ((select name from person where person.id = person_order.person_id) = 'Denis') then 'true'
else 'false'
end as check_name
from person_order where (menu_id = 13 or menu_id = 14 or menu_id = 18) and order_date = '2022-01-07';

select id, name, 
case 
when (age >= 10 and age <= 20) then 'interval #1'
when (age > 20 and age < 24) then 'interval #2'
else 'interval #3'
end as interval_info
from person
order by interval_info;

select id, person_id, menu_id, order_date
from person_order where id%2 = 0 order by id;

select (select name from person where id = pv.person_id) as person_name, 
(select name from pizzeria where id = pv.pizzeria_id) as pizzeria_name
from (select * from person_visits WHERE visit_date BETWEEN '2022-01-07' and '2022-01-09') as pv order by person_name, pizzeria_name desc;


select person.id as object_id, person.name as object_name from person
union 
select menu.id as object_id, food.name as object_name from menu join food on menu.food_id = food.id
order by object_id, object_name;

select person.name as object_name from person
union all
select food.name as object_name from food
order by object_name;

select name from food 
union
select name from food
order by name desc;

select order_date as action_date, person_id as person_id from person_order
intersect 
select visit_date as action_date, person_id as person_id from person_visits
order by action_date, person_id desc;

select person_id as action_date from person_order where order_date = '2023-01-07'
except all
select person_id as action_date from person_visits where visit_date = '2023-01-07';

select  person.id as person_id, person.name as person_name, person.age, person.gender, person.address, pizzeria.id as pizzeria_id, pizzeria.name as pizzeria_name, pizzeria.rating from person cross join pizzeria
order by person_id, pizzeria_id;

select order_date as action_date, person.name as person_name from person_order join person on person.id = person_order.person_id
intersect select visit_date as action_date, person.name as person_name from person_visits join person on person.id = person_visits.person_id
order by action_date, person_name desc;

select person_order.order_date as order_date, concat(person.name, ' (age:', person.age, ')') as person_information from person_order join person on person_order.person_id = person.id order by order_date, person_information;

select person_order.order_date as order_date, concat(joined.name, ' (age:', joined.age, ')') as person_information from person_order natural join (select person.id as person_id, name, age from person) as joined order by order_date, person_information;

select name from pizzeria where id not in (select person_visits.pizzeria_id from person_visits);
select name from pizzeria where not exists (select person_visits.pizzeria_id from person_visits where person_visits.pizzeria_id = pizzeria.id);  

select person.name as person_name, food.name as pizza_name, pizzeria.name as pizzeria_name from person join person_order on person_order.person_id = person.id join menu on menu.id = person_order.menu_id join food on menu.food_id = food.id join pizzeria on menu.pizzeria_id = pizzeria.id order by person_name, pizza_name, pizzeria_name;

select name, rating from pizzeria
left join person_visits on pizzeria.id = person_visits.pizzeria_id 
where person_visits.pizzeria_id is null;

select distinct visit_date from person_visits
right join person on person_visits.person_id = person.id 
where person_visits.person_id != 1 and person_visits.person_id != 2 and visit_date between '2023-01-03' and '2023-01-10'
order by visit_date;

select 
case 
when person.name is null
then '-'
else person.name
end as person_name,
case 
when joined.visit_date is null
then null
else joined.visit_date
end as visit_date,
case 
when pizzeria.name is null
then '-'
else pizzeria.name
end as pizzeria_name
from person
full join (select * from person_visits where person_visits.visit_date between '2023-01-01' and '2023-01-03') as joined on person.id = joined.person_id 
full join pizzeria on joined.pizzeria_id = pizzeria.id
order by person_name, visit_date, pizzeria_name;

with table_cte (visit_date, person_id) as (
    select distinct visit_date, person_id from person_visits
    where visit_date between '2023-01-03' and '2023-01-10'
)
select distinct visit_date from table_cte 
right join person on table_cte.person_id = person.id 
where table_cte.person_id != 1 and table_cte.person_id != 2 
order by visit_date;

select food.name as pizza_name, pizzeria.name as pizzeria_name, menu.price from menu
join pizzeria on menu.pizzeria_id = pizzeria.id
join food on menu.food_id = food.id
where food.name = 'mushroom pizza' or food.name = 'pepperoni pizza'
order by food.name, pizzeria_name;

select name from person
where age > 25 and gender = 'female'
order by name;

select food.name as pizza_name, pizzeria.name as pizzeria_name from pizzeria
join menu on menu.pizzeria_id = pizzeria.id
join food on menu.food_id = food.id
join person_order on menu.id = person_order.menu_id
join person on person_order.person_id = person.id
where person.name = 'Anna' or person.name = 'Denis'
order by pizza_name, pizzeria_name;

select pizzeria.name from person 
join person_visits on person.id = person_visits.person_id
join pizzeria on person_visits.pizzeria_id = pizzeria.id
join menu on pizzeria.id = menu.pizzeria_id
where person.name = 'Dmitriy' and visit_date = '2023-01-08' and menu.price < 800;

select person.name from person 
join person_order on person.id = person_order.person_id
join menu on person_order.menu_id = menu.id
join food on menu.food_id = food.id
where person.gender = 'male' and (address = 'Moscow' or address = 'Samara') and (food.name = 'pepperoni pizza' or food.name = 'mushroom pizza')
order by name desc;

select DISTINCT person.name from person 
join person_order on person.id = person_order.person_id
join menu on person_order.menu_id = menu.id
join food on menu.food_id = food.id
where person.gender = 'female' and food.name = 'pepperoni pizza'
intersect 
select DISTINCT person.name from person 
join person_order on person.id = person_order.person_id
join menu on person_order.menu_id = menu.id
join food on menu.food_id = food.id
where person.gender = 'female' and food.name = 'cheese pizza'
order by name;

select joined.name as person_name1, person.name as person_name2, person.address as common_address from person
join (select id, name, address from person) as joined on person.address = joined.address
where joined.id > person.id
order by person_name1, person_name2, common_address;

select food.name, menu.price, pizzeria.name as pizzeria_name, person_visits.visit_date from menu
join food on menu.food_id = food.id
join pizzeria on menu.pizzeria_id = pizzeria.id
join person_visits on pizzeria.id = person_visits.pizzeria_id
join person on person_visits.person_id = person.id
where person.name = 'Kate' and menu.price between 800 and 1000
order by 1, menu.price, pizzeria.name;

select menu.id as menu_id from menu
except 
select person_order.menu_id from person_order
order by menu_id;

select food.name as pizza_name, menu.price, pizzeria.name as pizzeria_name from pizzeria
left join menu on pizzeria.id = menu.pizzeria_id
left join food on menu.food_id = food.id
left join person_order on menu.id = person_order.menu_id
where person_order.menu_id is null
order by pizza_name, menu.price;

(select pizzeria.name as pizzaria_name from pizzeria
join person_visits on pizzeria.id = person_visits.pizzeria_id
join person on person_visits.person_id = person.id
where person.gender = 'female'
except all 
select pizzeria.name as pizzaria_name from pizzeria
join person_visits on pizzeria.id = person_visits.pizzeria_id
join person on person_visits.person_id = person.id
where person.gender = 'male')
union all 
(select pizzeria.name as pizzaria_name from pizzeria
join person_visits on pizzeria.id = person_visits.pizzeria_id
join person on person_visits.person_id = person.id
where person.gender = 'male'
except all 
select pizzeria.name as pizzaria_name from pizzeria
join person_visits on pizzeria.id = person_visits.pizzeria_id
join person on person_visits.person_id = person.id
where person.gender = 'female')
order by pizzaria_name;

(select pizzeria.name as pizzaria_name from pizzeria
join menu on pizzeria.id = menu.pizzeria_id
join person_order on menu.id = person_order.menu_id
join person on person_order.person_id = person.id
where person.gender = 'female'
except 
select pizzeria.name as pizzaria_name from pizzeria
join menu on pizzeria.id = menu.pizzeria_id
join person_order on menu.id = person_order.menu_id
join person on person_order.person_id = person.id
where person.gender = 'male')
union 
(select pizzeria.name as pizzaria_name from pizzeria
join menu on pizzeria.id = menu.pizzeria_id
join person_order on menu.id = person_order.menu_id
join person on person_order.person_id = person.id
where person.gender = 'male'
except
select pizzeria.name as pizzaria_name from pizzeria
join menu on pizzeria.id = menu.pizzeria_id
join person_order on menu.id = person_order.menu_id
join person on person_order.person_id = person.id
where person.gender = 'female')
order by pizzaria_name;

select pizzeria.name as pizzeria_name from pizzeria
join person_visits on pizzeria.id = person_visits.pizzeria_id
join person on person_visits.person_id = person.id
where person.name = 'Andrey' and not exists (select person_id from person_order where person_visits.visit_date = person_order.order_date)
order by pizzeria_name;

select distinct food.name as pizza_name, pizzeria.name as pizzeria_name_1, joined.name as pizzeria_name_2, menu.price from menu
join food on menu.food_id = food.id
join pizzeria on menu.pizzeria_id = pizzeria.id 
join (select pizzeria.id, pizzeria.name, food.name as pizza_name, menu.price from pizzeria join menu on pizzeria.id = menu.pizzeria_id join food on menu.food_id = food.id) as joined on pizzeria.id > joined.id and joined.pizza_name = pizza_name and menu.price = joined.price
order by pizza_name;

insert into food (id, name) values (6, 'greek pizza');
insert into menu (id, pizzeria_id, food_id, price) values (19, 2, 6, 800);

insert into food (id, name) values (7, 'sicilian pizza');
insert into menu (id, pizzeria_id, food_id, price) values ((select (max(menu.id)+1) from menu), (select pizzeria.id from pizzeria where pizzeria.name = 'Pizzeria #1'), 7, 900);

insert into person_visits (id, person_id, pizzeria_id, visit_date) values ((select (count(person_visits.id)+1) from person_visits), (select id from person where name = 'Denis'), (select id from pizzeria where pizzeria.name = 'Pizzaria #2'), '2023-02-24');
insert into person_visits (id, person_id, pizzeria_id, visit_date) values ((select (count(person_visits.id)+1) from person_visits), (select id from person where name = 'Irina'), (select id from pizzeria where pizzeria.name = 'Pizzaria #2'), '2023-02-24');

insert into person_order (id, person_id, menu_id, order_date) values ((select (count(person_order.id)+1) from person_order), (select id from person where name = 'Denis'), (select menu.id from menu join food on menu.food_id = food.id where food.name = 'sicilian pizza'), '2023-02-24');
insert into person_order (id, person_id, menu_id, order_date) values ((select (count(person_order.id)+1) from person_order), (select id from person where name = 'Irina'), (select menu.id from menu join food on menu.food_id = food.id where food.name = 'sicilian pizza'), '2023-02-24');

update menu set price = ROUND((select price from menu join food on menu.food_id = food.id where food.name = 'greek pizza') / 100 * 90) where menu.id = 6;

insert into person_order (id, person_id, menu_id, order_date) 
select gs+(select max(person_order.id) from person_order), 
gs, 
(select menu.id from menu join food on menu.food_id = food.id where food.name = 'greek pizza'),
'2023-02-25' from person
 join generate_series(1, (select count(*) from person)) as gs on gs = person.id;

delete from person_order where person_order.order_date = '2023-02-25';
delete from menu where menu.food_id = 6;
delete from food where food.name = 'greek pizza';

select distinct person.name, food.name, menu.price, round((1 - person_discounts.discount / 100) * menu.price) as discount_price, pizzeria.name as pizzeria_name from person
join person_order on person.id = person_order.person_id
join menu on person_order.menu_id = menu.id
join food on menu.food_id = food.id
join pizzeria on menu.pizzeria_id = pizzeria.id
join person_discounts on person_discounts.person_id = person.id and person_discounts.pizzeria_id = pizzeria.id
order by person.name, food.name;

select person.id as person_id, count(*) as count_of_visits from person
join person_visits on person.id = person_visits.person_id
group by person.id
order by count_of_visits desc, person.id;

select person.name, count(*) as count_of_visits from person
join person_visits on person.id = person_visits.person_id
group by person.id
order by count_of_visits desc, person.name 
limit 4;

(select pizzeria.name, count(*), 'order' as action_type from pizzeria
join menu on pizzeria.id = menu.pizzeria_id
join person_order on menu.id = person_order.menu_id
group by pizzeria.name
order by action_type, count desc
limit 3)
union
(select pizzeria.name, count(*), 'visit' as action_type from pizzeria
join person_visits on pizzeria.id = person_visits.pizzeria_id
group by pizzeria.name
order by action_type, count desc
limit 3)
order by action_type, count desc;

select p.name, 
((select count(*) from pizzeria join person_visits on pizzeria.id = person_visits.pizzeria_id where pizzeria.name = p.name) + 
 (select count(pizzeria.name) from pizzeria join menu on pizzeria.id = menu.pizzeria_id join person_order on menu.id = person_order.menu_id where pizzeria.name = p.name)) 
as total_count from pizzeria as p
group by p.name
order by total_count desc, p.name;

select person.name, count(*) as count_of_visits from person
join person_visits on person.id = person_visits.person_id
group by person.name 
having count(*) >= 3;

select distinct person.name from person 
join person_order on person.id = person_order.person_id
order by person.name;

select pizzeria.name, count(*) as count_of_orders, cast(round(avg(price),2) as float) as average_price, max(price) as max_price, min(price) as min_price from pizzeria
join menu on pizzeria.id = menu.pizzeria_id
join person_order on menu.id = person_order.menu_id
group by pizzeria.name
order by pizzeria.name;

select round(avg(pizzeria.rating), 4) as global_rating from pizzeria;

select person.address, pizzeria.name, count(*) as count_of_orders from pizzeria
join menu on pizzeria.id = menu.pizzeria_id
join person_order on menu.id = person_order.menu_id
join person on person_order.person_id = person.id
group by person.address, pizzeria.name
order by person.address, pizzeria.name;

select person.address, cast(round(max(age) - (min(age) / max(age)::numeric), 2) as float) as formula, cast(round(avg(age), 2) as float) as average, 
case 
when cast(round(max(age) - (min(age) / max(age)::numeric), 2) as float) > cast(round(avg(age), 2) as float)
then true
else false
end as comparison
from person
group by person.address
order by person.address;