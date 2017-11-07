CREATE TABLE mobilee.t_user
(
    id bigint(20) PRIMARY KEY NOT NULL COMMENT '主键',
    name varchar(18) DEFAULT '阿卡林' NOT NULL COMMENT '姓名',
    password varchar(18) DEFAULT '123456' NOT NULL COMMENT '密码',
    gender tinyint(4) DEFAULT '1' COMMENT '1男2女',
    created timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    birthday timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '生日',
    phone varchar(13) COMMENT '手机',
    email varchar(18) COMMENT '邮箱',
    edition int(11) DEFAULT '0' NOT NULL COMMENT '文档版本'
);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (1, '李哥', '123456', 1, '2017-11-01 17:35:00', '2017-10-31 00:00:00', null, null, 5);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (2, '夜吹', '123456', 1, '2017-11-01 17:35:00', '2017-10-31 00:00:00', null, null, 2);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (3, '阿卡', '123456', 1, '2017-11-01 17:35:00', '2017-10-31 00:00:00', null, null, 2);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (4, '卡', '123456', 1, '2017-11-01 17:35:21', '2017-10-31 18:18:00', null, null, 1);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (5, '阿卡林', '123456', 1, '2017-11-01 17:35:21', '2017-10-31 18:18:00', null, null, 1);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (6, '小智', '123456', 1, '2017-11-01 17:35:00', '2017-10-31 00:00:00', null, null, 3);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (7, '阿卡林', '123456', 1, '2017-11-01 17:35:21', '2017-10-31 18:18:00', null, null, 1);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (8, '狗贼', '123456', 1, '2017-11-01 17:35:21', '2017-10-31 18:18:00', null, null, 1);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (9, '涛妹', '123456', 1, '2017-11-01 17:35:00', '2017-10-31 00:00:00', null, null, 2);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (10, '小漠', '123456', 1, '2017-11-02 21:58:00', '2017-11-02 00:00:00', null, null, 1);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (12, '阿卡林', '123456', 1, '2017-11-02 21:59:24', '2017-11-02 21:59:24', null, null, 0);