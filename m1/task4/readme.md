# **Task 4** #

**Install MySQL Server to Ubuntu**

![1.mysql_install](images/1.mysql_install.jpg)


Connect Worbench to MySQL

SET GLOBAL validate_password.special_char_count = 0;

>CREATE USER 'root'@'localhost' IDENTIFIED BY 'password';

>GRANT ALL PRIVILEGES ON * . * TO 'newuser'@'localhost';

>FLUSH PRIVILEGES;

>SELECT user,authentication_string,plugin,host FROM mysql.user;







| Тип      | Ссылка |
|----------|---------|
|Установаrf MySQL|https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-20-04-ru|
|Политика паролей |https://blog.programs74.ru/how-to-resolve-mysql-error-1819/|
|Права|https://www.digitalocean.com/community/tutorials/mysql-ru
|





