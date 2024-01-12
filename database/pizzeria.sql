
create table if not EXISTS person(
  id bigint primary key ,
  name varchar not null,
  age integer not null default 10,
  gender varchar default 'female' not null ,
  address varchar
  );

alter table person add constraint ch_gender check ( gender in ('female','male') );

insert into person values (1, 'Anna', 16, 'female', 'Moscow');
insert into person values (2, 'Andrey', 21, 'male', 'Moscow');
insert into person values (3, 'Kate', 33, 'female', 'Moscow');
insert into person values (4, 'Denis', 13, 'male', 'Moscow');
insert into person values (5, 'Sofia', 45, 'female', 'Moscow');
insert into person values (6, 'Irina', 21, 'female', 'Saint-Petersburg');
insert into person values (7, 'Peter', 24, 'male', 'Saint-Petersburg');
insert into person values (8, 'Nataly', 30, 'female', 'Moscow');
insert into person values (9, 'Dmitriy', 18, 'male', 'Moscow');


create table if not EXISTS pizzeria
(id bigint primary key ,
 name varchar not null ,
 rating numeric not null default 0);

alter table pizzeria add constraint ch_rating check ( rating between 0 and 5);

insert into pizzeria values (1,'Pizzaria #1', 4.6);
insert into pizzeria values (2,'Pizzaria #2', 4.3);
insert into pizzeria values (3,'Pizzaria #3', 3.2);
insert into pizzeria values (4,'Pizzaria #4', 4.9);
insert into pizzeria values (5,'Pizzaria #5', 2.3);
insert into pizzeria values (6,'Pizzaria #6', 4.2);

create table if not EXISTS person_visits
(id bigint primary key ,
 person_id bigint not null ,
 pizzeria_id bigint not null ,
 visit_date date not null default current_date,
 constraint uk_person_visits unique (person_id, pizzeria_id, visit_date),
 constraint fk_person_visits_person_id foreign key  (person_id) references person(id),
 constraint fk_person_visits_pizzeria_id foreign key  (pizzeria_id) references pizzeria(id)
 );

insert into person_visits values (1, 1, 1, '2023-01-01');
insert into person_visits values (2, 2, 2, '2023-01-01');
insert into person_visits values (3, 2, 1, '2023-01-02');
insert into person_visits values (4, 3, 5, '2023-01-03');
insert into person_visits values (5, 3, 6, '2023-01-04');
insert into person_visits values (6, 4, 5, '2023-01-07');
insert into person_visits values (7, 4, 6, '2023-01-08');
insert into person_visits values (8, 5, 2, '2023-01-08');
insert into person_visits values (9, 5, 6, '2023-01-09');
insert into person_visits values (10, 6, 2, '2023-01-09');
insert into person_visits values (11, 6, 4, '2023-01-01');
insert into person_visits values (12, 7, 1, '2023-01-03');
insert into person_visits values (13, 7, 2, '2023-01-05');
insert into person_visits values (14, 8, 1, '2023-01-05');
insert into person_visits values (15, 8, 2, '2023-01-06');
insert into person_visits values (16, 8, 4, '2023-01-07');
insert into person_visits values (17, 9, 4, '2023-01-08');
insert into person_visits values (18, 9, 5, '2023-01-09');
insert into person_visits values (19, 9, 6, '2023-01-10');

 create table if not EXISTS food (
 id bigint primary key, 
 name varchar not null
 );
 
insert into food values (1,'cheese pizza');
insert into food values (2,'pepperoni pizza');
insert into food values (3,'sausage pizza');
insert into food values (4,'supreme pizza');
insert into food values (5,'mushroom pizza');

create table if not EXISTS menu
(id bigint primary key ,
 pizzeria_id bigint not null ,
 food_id bigint not null ,
 price numeric not null default 1,
 constraint fk_food_food_id foreign key (food_id) references food(id),
 constraint fk_menu_pizzeria_id foreign key (pizzeria_id) references pizzeria(id));
 
insert into menu values (1,1,1, 900);
insert into menu values (2,1,2, 1200);
insert into menu values (3,1,3, 1200);
insert into menu values (4,1,4, 1200);

insert into menu values (5,6,1, 950);
insert into menu values (6,6,2, 800);
insert into menu values (7,6,3, 1000);

insert into menu values (8,2,1, 800);
insert into menu values (9,2,5, 1100);

insert into menu values (10,3,1, 780);
insert into menu values (11,3,4, 850);

insert into menu values (12,4,1, 700);
insert into menu values (13,4,5, 950);
insert into menu values (14,4,2, 1000);
insert into menu values (15,4,3, 950);

insert into menu values (16,5,1, 700);
insert into menu values (17,5,2, 800);
insert into menu values (18,5,4, 850);

create table if not EXISTS person_order
(
    id bigint primary key ,
    person_id  bigint not null ,
    menu_id bigint not null ,
    order_date date not null default current_date,
    constraint fk_order_person_id foreign key (person_id) references person(id),
    constraint fk_order_menu_id foreign key (menu_id) references menu(id)
);

insert into person_order values (1,1, 1, '2023-01-01');
insert into person_order values (2,1, 2, '2023-01-01');

insert into person_order values (3,2, 8, '2023-01-01');
insert into person_order values (4,2, 9, '2023-01-01');

insert into person_order values (5,3, 16, '2023-01-04');

insert into person_order values (6,4, 16, '2023-01-07');
insert into person_order values (7,4, 17, '2023-01-07');
insert into person_order values (8,4, 18, '2023-01-07');
insert into person_order values (9,4, 6, '2023-01-08');
insert into person_order values (10,4, 7, '2023-01-08');

insert into person_order values (11,5, 6, '2023-01-09');
insert into person_order values (12,5, 7, '2023-01-09');

insert into person_order values (13,6, 13, '2023-01-01');

insert into person_order values (14,7, 3, '2023-01-03');
insert into person_order values (15,7, 9, '2023-01-05');
insert into person_order values (16,7, 4, '2023-01-05');

insert into person_order values (17,8, 8, '2023-01-06');
insert into person_order values (18,8, 14, '2023-01-07');

insert into person_order values (19,9, 18, '2023-01-09');
insert into person_order values (20,9, 6, '2023-01-10');

create table if not EXISTS person_discounts
( id bigint primary key,
  person_id bigint,
  pizzeria_id bigint,
  discount numeric,
  constraint fk_person_discounts_person_id foreign key (person_id) references person(id),
  constraint fk_person_discounts_pizzeria_id foreign key (pizzeria_id) references pizzeria(id)
);

insert into person_discounts (id, person_id, pizzeria_id, discount)
select row_number() over() as id, person.id as person_id, pizzeria.id as pizzeria_id, 
case 
when count(*) = 1
then 10.5
when count(*) = 2
then 22
else 30
end as discount
from person
join person_order on person.id = person_order.person_id 
join menu on person_order.menu_id = menu.id
join pizzeria on menu.pizzeria_id = pizzeria.id
group by person.id, pizzeria.id;

alter table person_discounts add constraint ch_nn_person_id check (person_id != null);
alter table person_discounts add constraint ch_nn_pizzeria_id check (pizzeria_id != null);
alter table person_discounts add constraint ch_nn_discount check (discount != null);
alter table person_discounts alter discount set default 0;
alter table person_discounts add constraint ch_range_discount check ( discount between 0 and 100);

comment on table person_discounts is 'a table with data on a personal discount for each person in different pizzerias';
comment on column person_discounts.id is 'id of table person_discounts is primary key';
comment on column person_discounts.person_id is 'id of a person who has a discount in pizzerias';
comment on column person_discounts.pizzeria_id is 'id of pizzerias in which someone has discount';
comment on column person_discounts.discount is 'count of discount to persons in the pizzeria';

create table if not EXISTS person_audit
( created timestamp with time zone not null,
  type_event char(1) not null default 'I',
  row_id bigint not null,
  name varchar,
  age integer,
  gender varchar,
  address varchar
);

alter table person_audit add constraint ch_type_event check (type_event in ('I', 'U', 'D'));