## Features
- скрипт создания базы данных
- скрипт для заполнения тестовыми данными
- выборки по различным условиям разного уровня сложности

## Перед запуском
- в файл .env добавьте следующие переменные для подключения к базе, можно изменить .env.example на .env
```
    MYSQL_ROOT_PASSWORD=
    MYSQL_DATABASE=
```

## Для запуска
```bash
    docker compose up --build -d
```

## TODO:
- triggers
- procedures

## Концептуальная схема
![image](https://user-images.githubusercontent.com/91421235/234338874-2a5e2edb-ae02-4e86-ac8a-af1ff1ca66ac.png)

## Логическая схема
![image](https://user-images.githubusercontent.com/91421235/234338952-fd6c6306-90f8-4521-9505-c5ff7ea306c0.png)

## Физическая схема
![image](https://user-images.githubusercontent.com/91421235/234339075-eb95886b-9653-4656-a951-e8ac71aaaef0.png)
