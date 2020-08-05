-- shows the downtime of each of the application instances of a service
select up.location,
       down.eventTime as downAt,
       up.eventTime as upAt,
       (up.eventTime - down.eventTime) as downTime
from
    (
        select *
        from
            (
                select ROW_NUMBER() over (order by 1) as id,
                       attribute -> 'uri' as location,
                       attribute -> 'status' as status,
                       cast(attribute -> 'time' as timestamp) as eventTime
                from item_change
                where attribute -> 'name' = 'etcd'
                group by attribute
                order by attribute
            ) as R1
        where status = 'up'
    ) as up
        left join
    (
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
    on up.id = down.id + 1
where down.eventTime is not null