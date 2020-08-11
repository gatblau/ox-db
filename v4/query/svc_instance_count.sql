-- shows the list of service up/down events with the count of instances which are up
SELECT *
FROM ox_ses_events_up_count('{{PLATFORM}}', '{{SERVICE}}', '{{FACET}}')