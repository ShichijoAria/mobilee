CREATE TABLE mobilee.t_admin
(
    id bigint(20) PRIMARY KEY NOT NULL COMMENT '主键' AUTO_INCREMENT,
    name varchar(18) DEFAULT '阿卡林' COMMENT '姓名',
    password varchar(18) DEFAULT '123456' COMMENT '密码'
);
INSERT INTO mobilee.t_admin (id, name, password) VALUES (1, '龙傲天', '123456');