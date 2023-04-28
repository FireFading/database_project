## Features
- [описание предметной области](description_subject_area.pdf)
- [концептуальная схема](diagrams/conceptual.pdf)
- [логическая схема](diagrams/logical.png)
- [физическая схема](diagrams/physical.png)
- [скрипт создания базы данных](scrypts/create.sql)
- [скрипт для заполнения тестовыми данными](scrypts/insert.sql)
- [выборки по различным условиям разного уровня сложности](scrypts/select.sql)
- [триггеры по бизнес-правилам](scrypts/triggers.sql)
- [процедуры](scrypts/procedures.sql)

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

## Бизнес-правила
- количество использованного вещества не превышает доступное количество из таблицы доступных версий веществ.
- брать из лаборатории вещества могут лаборанты, которые старше 21 года
- запрет на использование просроченных веществ

