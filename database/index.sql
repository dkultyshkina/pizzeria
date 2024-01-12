
CREATE INDEX idx_menu_pizzeria_id ON menu USING btree (pizzeria_id);
CREATE INDEX idx_person_order_person_id ON person_order USING btree (person_id);
CREATE INDEX idx_person_order_menu_id ON person_order USING btree (menu_id);
CREATE INDEX idx_person_visits_person_id ON person_visits USING btree (person_id);
CREATE INDEX idx_person_visits_pizzeria_id ON person_visits USING btree (pizzeria_id);

set enable_seqscan = off;
set enable_indexscan = on;
explain analyze select food.name, pizzeria.name as pizzeria_name from menu
join pizzeria on menu.pizzeria_id = pizzeria.id
join food on menu.food_id = food.id;

create index idx_person_name on person using btree (UPPER(name));
set enable_indexscan = on;
set enable_seqscan = off;
explain analyze select name from person
where UPPER(name) = 'Anna';

create index idx_person_order_multi on person_order using btree (person_id, menu_id, order_date);
set enable_seqscan = off;
set enable_indexscan = on;
explain analyze
SELECT person_id, menu_id, order_date
FROM person_order
WHERE person_id = 8 AND menu_id = 19;

create unique index idx_menu_unique on menu using btree (pizzeria_id, food_id);
set enable_indexscan = on;
set enable_seqscan = off;
explain analyze
select pizzeria.name, menu.pizzeria_id, food.name from pizzeria
join menu on pizzeria.id = menu.pizzeria_id
join food on menu.food_id = food.id;

create unique index idx_person_order_order_date on person_order using btree (person_id, menu_id, order_date)
where order_date = '2023-01-01';
set enable_indexscan = on;
set enable_seqscan = off;
explain analyze
select person_order.order_date, person_order.person_id, person_order.menu_id, food.name, menu.price, person.name from menu
join person_order on menu.id = person_order.menu_id
join person on person_order.person_id = person.id
join food on menu.food_id = food.id
where person_order.order_date = '2023-01-01';

set enable_seqscan = off;
set enable_indexscan = on;
explain analyze
SELECT
    f.name AS pizza_name,
    max(rating) OVER (PARTITION BY rating ORDER BY rating ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS k
FROM menu m 
join food f on m.food_id = f.id
INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
ORDER BY 1,2;

create index idx_1 on pizzeria using btree (rating);
set enable_seqscan = off;
set enable_indexscan = on;
explain analyze
SELECT
    f.name AS pizza_name,
    max(rating) OVER (PARTITION BY rating ORDER BY rating ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS k
FROM  menu m
join food f on m.food_id = f.id
INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
ORDER BY 1,2;
drop index idx_1;

create unique index idx_person_discounts_unique on person_discounts (person_id, pizzeria_id);
set enable_indexscan = on;
set enable_seqscan = off;
explain analyze
select * from person_discounts
where person_id = 1 and pizzeria_id = 2;

create sequence seq_person_discounts
start 1;
alter table person_discounts alter id set default nextval('seq_person_discounts');
select setval('seq_person_discounts', (select count(*)+1 from person_discounts));
