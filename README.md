# php53-apache-mysql-client-docker
Docker image with: Ubuntu 20.04; apache2; php5.3; php5-mysql - for discontinued projects that need, e.g., mysql_connect

Example `docker-compose.yml`
```
version: '3'
services:
  db:
    image: mysql
    command: --default-authentication-plugin=mysql_native_password --collation-server=latin1_general_cs --character-set-server=latin1
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: example
    ports:
      - "3306:3306"
  php:
    image: dlage/php53-apache-mysql-client
    volumes:
      - ./path/to/phpapp:/var/www/html
    links:
      - "db:mysqldb"
    ports:
      - "8080:80"
    depends_on:
      - db
  phpmyadmin:
    image: phpmyadmin
    restart: always
    ports:
      - 8081:80
    environment:
      PMA_HOST: db
      PMA_USER: root
      PMA_PASSWORD: example
      UPLOAD_LIMIT: 1G
    depends_on:
      - db
```
