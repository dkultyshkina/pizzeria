# :pizza: База данных "Пиццерия"

![Database](https://img.shields.io/badge/Database-blue.svg?style=flat&logo=database) 
![SQL](https://img.shields.io/badge/SQL-blue.svg?style=flat&logo=sql) 
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-blue.svg?style=flat&logo=postgresql)

Также, помимо модели пиццерии (database/model.sql), представлены дополнения к базе данных в виде:

- SQL-запросов (database/query.sql);
- Индексы (database/index.sql);
- Триггеры (database/trigger.sql);
- Функции (database/function.sql);
- Образы (database/view.sql).

![Структура базы данных](./materials/pictures/db.png)

<p align="center"> Структура базы данных </p>

<br>

# Сборка и удаление

- Ввести в папке **pizzeria/** команду **make all** для сборки базы данных в контейнере;

<br>

- Ввести в папке **pizzeria/** команду **make sql** для входа в контейнер;

<br>

- Ввести в папке **pizzeria/** команду **make install** для сборки базы данных в контейнере;

<br>

- Ввести в папке **pizzeria/** команду **make uninstall** для очищения базы данных, удаления образов и контейнера.
