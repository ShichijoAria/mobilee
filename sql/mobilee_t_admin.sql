CREATE TABLE mobilee.t_admin
(
    id bigint(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name varchar(18) DEFAULT '阿卡林',
    password varchar(18) DEFAULT '123456'
);
INSERT INTO mobilee.t_admin (name, password) VALUES ('叶良辰', '123456');