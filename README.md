## Features
- [описание предметной области](description_subject_area.pdf)
- [концептуальная схема](diagrams/conceptual.pdf)
- [логическая схема](diagrams/logical.pdf)
- [физическая схема](diagrams/physical.pdf)
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
