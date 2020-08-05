-- shows the downtime of each of the application instances of a service
select up.platform,
       up.service,
       up.location,
       down.eventTime as downAt,
       up.eventTime as upAt,
       (up.eventTime - down.eventTime) as downTime
from
    (
        -- retrieve all entries with 'up' status for {{SERVICE}}
        select *
        from
            (
                select ROW_NUMBER() over (order by 1) as id,
                       attribute -> 'service' as service,
                       attribute -> 'uri' as location,
                       attribute -> 'status' as status,
                       attribute -> 'platform' as platform,
                       cast(attribute -> 'time' as timestamp) as eventTime
                from item_change
                where attribute -> 'name' = '{{SERVICE}}'
                group by attribute
                order by attribute
            ) as R1
        where status = 'up'
    ) as up
        left join
    (
        -- retrieve all entries with 'down' status for {{SERVICE}}
        select *
        from
            (
                select ROW_NUMBER() over (order by 1) as id,
                       attribute -> 'uri' as location,
                       attribute -> 'status' as status,
                       cast(attribute -> 'time' as timestamp) as eventTime
                from item_change
                where attribute -> 'name' = '{{SERVICE}}'
                group by attribute
                order by attribute
            ) as R2
        where status = 'down'
    ) as down
    on up.id = down.id + 1 -- correlates up and down entries using the temporal sequence 'id'
where down.eventTime is not null -- discards entries where service is currently up (i.e. no down event)