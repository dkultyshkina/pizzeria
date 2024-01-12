create function fnc_persons_female() returns table(id person.id%type, name person.name%type, age person.age%type, gender person.gender%type, address person.address%type)
as $$
select id, name, age, gender, address from person where gender = 'female';
$$ language sql;

create function fnc_persons_male() returns table(id person.id%type, name person.name%type, age person.age%type, gender person.gender%type, address person.address%type)
as $$
select id, name, age, gender, address from person where gender = 'male';
$$ language sql;

SELECT *
FROM fnc_persons_male();

SELECT *
FROM fnc_persons_female();

drop function fnc_persons_female();
drop function fnc_persons_male();

create function fnc_persons(pgender varchar default 'female') returns table(id person.id%type, name person.name%type, age person.age%type, gender person.gender%type, address person.address%type)
as $$
select id, name, age, gender, address from person where gender = pgender;
$$ language sql;

select *
from fnc_persons(pgender := 'male');

select *
from fnc_persons();

create function fnc_person_visits_and_eats_on_date(pperson varchar default 'Dmitriy', pprice numeric default 500, pdate date default '2023-01-08') returns table(name varchar)
as $$
begin return query
select pizzeria.name from person
join person_visits on person.id = person_visits.person_id
join pizzeria on person_visits.pizzeria_id = pizzeria.id
join menu on pizzeria.id = menu.pizzeria_id
where person_visits.visit_date = pdate and menu.price < pprice and person.name = pperson;
end;
$$ language plpgsql;

select *
from fnc_person_visits_and_eats_on_date(pprice := 800);

select *
from fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2023-01-01');