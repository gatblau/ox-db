SELECT dbVersion
FROM "version"
WHERE COALESCE('{{AppVersion}}',appVersion) = appVersion
ORDER BY time DESC
LIMIT 1