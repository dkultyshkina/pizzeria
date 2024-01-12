create function fnc_trg_person_insert_audit() returns trigger as $$
begin
insert into person_audit(created, type_event, row_id, name, age, gender, address) values (current_timestamp,'I', new.id, new.name, new.age, new.gender, new.address);
return null;
end;
$$ language plpgsql;

create trigger trg_person_insert_audit
after insert on person
for each row
execute function fnc_trg_person_insert_audit();

INSERT INTO person(id, name, age, gender, address) VALUES (10,'Damir', 22, 'male', 'Irkutsk');

create function fnc_trg_person_update_audit() returns trigger as $$
begin
insert into person_audit(created, type_event, row_id, name, age, gender, address) values (current_timestamp, 'U', old.id, old.name, old.age, old.gender, old.address);
return null;
end;
$$ language plpgsql;

create trigger trg_person_update_audit
after update on person
for each row
execute function fnc_trg_person_update_audit();

UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;

create function fnc_trg_person_delete_audit() returns trigger as $$
begin
insert into person_audit(created, type_event, row_id, name, age, gender, address) values (current_timestamp,'D', old.id, old.name, old.age, old.gender, old.address);
return null;
end;
$$ language plpgsql;

create trigger trg_person_delete_audit
after delete on person
for each row
execute function fnc_trg_person_delete_audit();

DELETE FROM person WHERE id = 10;

drop trigger trg_person_insert_audit on person;
drop trigger trg_person_update_audit on person;
drop trigger trg_person_delete_audit on person;

drop function fnc_trg_person_insert_audit();
drop function fnc_trg_person_update_audit();
drop function fnc_trg_person_delete_audit();

delete from person_audit where row_id = 10;

create function fnc_trg_person_audit() returns trigger as $$
begin
if (TG_OP = 'INSERT') then
insert into person_audit(created, type_event, row_id, name, age, gender, address) values (current_timestamp, 'I', new.id, new.name, new.age, new.gender, new.address);
elseif (TG_OP = 'UPDATE') then 
insert into person_audit(created, type_event, row_id, name, age, gender, address) values (current_timestamp, 'U', old.id, old.name, old.age, old.gender, old.address);
elseif (TG_OP = 'DELETE') then
insert into person_audit(created, type_event, row_id, name, age, gender, address) values (current_timestamp,'D', old.id, old.name, old.age, old.gender, old.address);
end if;
return null;
end;
$$ language plpgsql;

create trigger trg_person_audit
after insert or update or delete on person
for each row
execute function fnc_trg_person_audit();

INSERT INTO person(id, name, age, gender, address)  VALUES (10,'Damir', 22, 'male', 'Irkutsk');
UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;
DELETE FROM person WHERE id = 10;
