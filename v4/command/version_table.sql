DO
$$
    BEGIN
        ---------------------------------------------------------------------------
        -- VERSION - version of releases (not only database)
        ---------------------------------------------------------------------------
        IF NOT EXISTS(SELECT relname FROM pg_class WHERE relname = 'version')
        THEN
            CREATE TABLE version
            (
                appVersion  CHARACTER VARYING(25) NOT NULL COLLATE pg_catalog."default",
                dbVersion   CHARACTER VARYING(25) NOT NULL COLLATE pg_catalog."default",
                description TEXT COLLATE pg_catalog."default",
                time        TIMESTAMP(6) WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP(6),
                source      CHARACTER VARYING(250),
                CONSTRAINT version_app_version_db_release_pk PRIMARY KEY (appVersion, dbVersion)
            )
                WITH (
                    OIDS = FALSE
                )
                TABLESPACE pg_default;

            ALTER TABLE version
                OWNER to onix;
        END IF;
    END;
$$
