/*
    Onix Config Manager - Copyright (c) 2018-2021 by www.gatblau.org

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
    Unless required by applicable law or agreed to in writing, software distributed under
    the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
    either express or implied.
    See the License for the specific language governing permissions and limitations under the License.

    Contributors to this project, hereby assign copyright in this code to the project,
    to be licensed under the same terms as the rest of the code.
*/
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
