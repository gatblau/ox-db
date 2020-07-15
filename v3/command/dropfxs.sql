DO
$$
    DECLARE
        rec RECORD;
        DROP_STATEMENT VARCHAR(200);
    BEGIN
        -- drops all functions that start with the FX_PATTERN prefix
        FOR rec IN
            SELECT routines.routine_name as fx_name
            FROM information_schema.routines
            WHERE routines.specific_schema='public'
            AND routines.routine_name SIMILAR TO 'ox_*'
            ORDER BY routines.routine_name
        LOOP
            DROP_STATEMENT = 'DROP FUNCTION IF EXISTS ' || rec.fx_name || ' CASCADE;';
            EXECUTE DROP_STATEMENT;
        END LOOP;
    END;
$$