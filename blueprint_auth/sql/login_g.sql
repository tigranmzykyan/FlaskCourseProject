SELECT user_id,group_name
FROM external_user
WHERE login = "$login" AND password = "$password"