DO
$$
    BEGIN
       INSERT INTO "version"(appVersion, dbVersion, description, source) VALUES('<APP_VERSION>', '<DB_VERSION>', 'Database Release <DB_VERSION>', '<SOURCE>');
    END;
$$