CREATE TABLE mobilee.t_user
(
    id bigint(20) PRIMARY KEY NOT NULL,
    name varchar(18) DEFAULT '阿卡林' NOT NULL,
    password varchar(18) DEFAULT '123456' NOT NULL,
    gender tinyint(4) DEFAULT '1' COMMENT '1男2女',
    created timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    birthday timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    phone varchar(13),
    email varchar(18),
    edition int(11) DEFAULT '0'
);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (1, '李哥', '123456', 1, '2017-10-29 16:58:35', '2017-10-28 17:15:46', null, null, 0);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (2, '阿卡林', '123456', 1, '2017-10-29 16:46:32', '2017-10-28 17:16:04', null, null, 0);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (3, '阿卡林', '123456', 1, '2017-10-29 16:46:32', '2017-10-28 17:16:04', null, null, 0);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (4, '阿卡林', '123456', 1, '2017-10-29 16:46:32', '2017-10-28 17:16:04', null, null, 0);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (5, '阿卡林', '123456', 1, '2017-10-29 16:46:32', '2017-10-28 17:16:04', null, null, 0);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (6, '阿卡林', '123456', 1, '2017-10-29 16:46:32', '2017-10-28 17:16:04', null, null, 0);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (7, '阿卡林', '123456', 1, '2017-10-29 16:46:32', '2017-10-28 17:16:04', null, null, 0);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (8, '阿卡林', '123456', 1, '2017-10-29 16:46:32', '2017-10-28 17:16:04', null, null, 0);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (9, '阿卡林', '123456', 1, '2017-10-29 20:09:17', '2017-10-29 20:09:17', null, null, 0);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (10, '阿卡林', '123456', 1, '2017-10-29 20:09:17', '2017-10-29 20:09:17', null, null, 0);
INSERT INTO mobilee.t_user (id, name, password, gender, created, birthday, phone, email, edition) VALUES (11, '阿卡林', '123456', 1, '2017-10-29 20:09:17', '2017-10-29 20:09:17', null, null, 0);