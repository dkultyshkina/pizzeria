create view v_persons_female as
select * from person 
where gender='female';

create view v_persons_male as
select * from person 
where gender='male';

select name from v_persons_female
union select name from v_persons_male 
order by name;

create view v_generated_dates as
select gs::date as generated_date from generate_series('2023-01-01', '2023-01-31', interval '1 day') as gs
order by gs;

select generated_date as missing_date from v_generated_dates
except
select visit_date as missing_date from person_visits
where EXTRACT(MONTH FROM visit_date) = 1
order by missing_date;

create view v_symmetric_union as
(select person_id from person_visits 
where person_visits.visit_date = '2023-01-02'
except
select person_id from person_visits
where person_visits.visit_date = '2023-01-06')
union
(select person_id from person_visits
where person_visits.visit_date = '2023-01-06'
except
select person_id from person_visits 
where person_visits.visit_date = '2023-01-02')
order by person_id;

create view v_price_with_discount as
select person.name, food.name, menu.price, round(menu.price/100*90) as discount_price from person
join person_order on person.id = person_order.person_id
join menu on person_order.menu_id = menu.id
join food on menu.food_id = food.id
order by 1, 2;

create materialized view mv_dmitriy_visits_and_eats as
select pizzeria.name from person
join person_visits on person.id = person_visits.person_id
join pizzeria on person_visits.pizzeria_id = pizzeria.id
join menu on pizzeria.id = menu.pizzeria_id
where person_visits.visit_date = '2023-01-08' and menu.price < 800 and person.name = 'Dmitriy';

insert into person_visits (id, person_id, pizzeria_id, visit_date) 
values ((select max(person_visits.id)+1 from person_visits), (select id from person where name = 'Dmitriy'), (select id from pizzeria where name='Pizzaria #1'), '2023-01-08');
insert into person_order (id, person_id, menu_id, order_date) 
values ((select max(person_order.id)+1 from person_order), (select id from person where name = 'Dmitriy'), (select menu.id from menu join food on menu.food_id = food.id where food.name='cheese pizza' and pizzeria_id = 5), '2023-01-08');

refresh materialized view mv_dmitriy_visits_and_eats;

refresh materialized view mv_dmitriy_visits_and_eats;

DROP VIEW v_generated_dates;
DROP VIEW v_persons_female;
DROP VIEW v_persons_male;
DROP VIEW v_price_with_discount;
DROP VIEW v_symmetric_union;

DROP MATERIALIZED VIEW mv_dmitriy_visits_and_eats;