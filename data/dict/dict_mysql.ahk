; 动态配置
mysql := {
    username: 'admin',
    host: '%'
}

; 数据库常用指令
mysqlDict := Map(
    ; grant 权限
    "mgg", "SHOW GRANTS FOR '" mysql.username "'@'" mysql.host "';",
    "mga", "GRANT SELECT ON db.* TO '" mysql.username "'@'" mysql.host "';",
    "mgrm", "REVOKE ALL ON *.* FROM '" mysql.username "'@'" mysql.host "';",
    "mgs", "FLUSH PRIVILEGES;",
)
