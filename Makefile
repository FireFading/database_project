shell:
	docker exec -it db_mysql mysql --password=password -c ./scrypt/insert.sql

build:
	docker compose up --build

up:
	docker compose up

down:
	docker compose down
