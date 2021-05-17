FROM postgres:13.3

COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

RUN echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen
RUN localedef -i ru_RU -c -f UTF-8 -A /usr/share/locale/locale.alias ru_RU.UTF-8
ENV LANG ru_RU.utf8

ENV TZ Europe/Moscow
RUN echo "$TZ" > /etc/timezone && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime

RUN apt-get update && apt-get install -y --no-install-recommends postgresql-13-rum postgresql-13-postgis-2.5 postgresql-13-postgis-2.5-scripts

RUN set -x \
    	&& apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* \
    	&& wget -O /usr/share/postgresql/13/extension/hunspell_ru_ru--1.0.sql "https://github.com/postgrespro/hunspell_dicts/raw/master/hunspell_ru_ru/hunspell_ru_ru--1.0.sql" \
    	&& wget -O /usr/share/postgresql/13/extension/hunspell_ru_ru.control "https://github.com/postgrespro/hunspell_dicts/raw/master/hunspell_ru_ru/hunspell_ru_ru.control" \
    	&& wget -O /usr/share/postgresql/13/tsearch_data/ru_ru.dict "https://github.com/postgrespro/hunspell_dicts/raw/master/hunspell_ru_ru/ru_ru.dict" \
    	&& wget -O /usr/share/postgresql/13/tsearch_data/ru_ru.affix "https://github.com/postgrespro/hunspell_dicts/raw/master/hunspell_ru_ru/ru_ru.affix" \
        && apt-get purge -y --auto-remove ca-certificates wget

VOLUME /var/lib/postgresql/data

EXPOSE 5432
