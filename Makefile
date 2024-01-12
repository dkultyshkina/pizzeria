all: install sql

install:
	sudo docker-compose up -d

sql: 
	sudo docker-compose exec db bash

uninstall:
	sudo docker-compose down
	chmod 777 clean.sh
	./clean.sh
	rm -rf clean
