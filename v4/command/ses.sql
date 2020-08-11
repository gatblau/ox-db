/*
    Onix Config Manager - Copyright (c) 2018-2019 by www.gatblau.org

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
        /*
   returns a series of chronological events comprising status, location and time for a specific
   platform, service and facet combination
   */
        CREATE OR REPLACE FUNCTION ox_ses_events(platform_param character varying, -- the platform on which the service is operating
                                                 service_param character varying, -- the type of service (e.g. etcd)
                                                 facet_param character varying -- the aspect of the service being reported (e.g. node, quorum, etc)
        )
            RETURNS TABLE
                    (
                        platform   character varying,
                        service    character varying,
                        facet      character varying,
                        status     character varying,
                        location   character varying,
                        check_time timestamp
                    )
            LANGUAGE 'plpgsql'
            COST 100
            STABLE
        AS
        $BODY$
        BEGIN
            RETURN QUERY
                SELECT CAST(attribute -> 'platform' AS CHARACTER VARYING) AS platform_param,
                       CAST(attribute -> 'service' AS CHARACTER VARYING)  AS service_param,
                       CAST(attribute -> 'facet' AS CHARACTER VARYING)    AS facet_param,
                       CAST(attribute -> 'status' AS CHARACTER VARYING)   AS status,
                       CAST(attribute -> 'location' AS CHARACTER VARYING) AS location,
                       CAST(attribute -> 'time' AS TIMESTAMP)             AS check_time
                FROM item_change
                WHERE attribute -> 'platform' = COALESCE(platform_param, attribute -> 'platform')
                  AND attribute -> 'service' = COALESCE(service_param, attribute -> 'service')
                  AND attribute -> 'facet' = COALESCE(facet_param, attribute -> 'facet');
        END;
        $BODY$;

        /*
         returns a series of chronological events comprising status, location, time and total number of up instances
         for a specific platform, service and facet combination
         */
        CREATE OR REPLACE FUNCTION ox_ses_events_up_count(platform_param CHARACTER VARYING,
                                                          service_param CHARACTER VARYING,
                                                          facet_param CHARACTER VARYING)
            RETURNS TABLE
                    (
                        platform   CHARACTER VARYING,
                        service    CHARACTER VARYING,
                        facet      CHARACTER VARYING,
                        status     CHARACTER VARYING,
                        location   CHARACTER VARYING,
                        check_time TIMESTAMP,
                        up_total   INT
                    )
            LANGUAGE 'plpgsql'
            COST 100
            VOLATILE
        AS
        $BODY$
        DECLARE
            r     RECORD;
            count INT;
        BEGIN
            CREATE TEMP TABLE temp_status
            (
                platform   CHARACTER VARYING,
                service    CHARACTER VARYING,
                facet      CHARACTER VARYING,
                status     CHARACTER VARYING,
                location   CHARACTER VARYING,
                check_time TIMESTAMP,
                up_total   INT
            );
            count = 0;
            FOR r IN
                SELECT *
                FROM ox_ses_events(platform_param, service_param, facet_param)
                LOOP
                    IF r.status = 'up' THEN
                        count = count + 1;
                    ELSIF r.status = 'down' THEN
                        count = count - 1;
                    END IF;
                    INSERT INTO temp_status(platform,
                                            service,
                                            facet,
                                            status,
                                            location,
                                            check_time,
                                            up_total)
                    VALUES (r.platform,
                            r.service,
                            r.facet,
                            r.status,
                            r.location,
                            r.check_time,
                            count);
                END LOOP;
            RETURN QUERY
                SELECT *
                FROM temp_status;
            DROP TABLE temp_status;
        END;
        $BODY$;
    END;
$$