# PostgreSQL 11 docker image

```bash
docker pull vadimshvetsov/postgres-ru
```

В [оригинальный образ](https://hub.docker.com/_/postgres) добавлено:

* локаль ru_RU.UTF-8
* часовой пояс Europe/Moscow (переопределяется переменной окружения `TZ`)
* расширения [PostGIS](https://postgis.net/), [RUM индекс](https://github.com/postgrespro/rum), [русские словари](https://github.com/postgrespro/hunspell_dicts/tree/master/hunspell_ru_ru) для полнотекстового поиска

Расширения устанавливаются как обычно

```sql
CREATE EXTENSION postgis;
CREATE EXTENSION rum;
CREATE EXTENSION hunspell_ru_ru;
```

Со словарями работать примерно так

```sql
=> SELECT ts_lexize('russian_hunspell', 'истории');
 ts_lexize
-----------
 {история}
(1 row)
```

подробности о словаре [здесь](https://github.com/postgrespro/hunspell_dicts)
