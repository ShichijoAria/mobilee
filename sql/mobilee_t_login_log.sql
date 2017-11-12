CREATE TABLE mobilee.t_login_log
(
    id bigint(20) PRIMARY KEY NOT NULL COMMENT '主键' AUTO_INCREMENT,
    user bigint(20) NOT NULL COMMENT '用户',
    created timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '登录日期'
);
INSERT INTO mobilee.t_login_log (id, user, created) VALUES (1, 1, '2017-11-08 21:23:02');
INSERT INTO mobilee.t_login_log (id, user, created) VALUES (2, 1, '2017-11-08 21:23:23');
INSERT INTO mobilee.t_login_log (id, user, created) VALUES (3, 2, '2017-11-08 21:32:57');
INSERT INTO mobilee.t_login_log (id, user, created) VALUES (4, 1, '2017-11-07 22:36:30');
INSERT INTO mobilee.t_login_log (id, user, created) VALUES (5, 2, '2017-11-07 22:36:36');
INSERT INTO mobilee.t_login_log (id, user, created) VALUES (6, 1, '2017-11-07 22:36:40');
INSERT INTO mobilee.t_login_log (id, user, created) VALUES (7, 1, '2017-11-06 22:36:43');
INSERT INTO mobilee.t_login_log (id, user, created) VALUES (8, 1, '2017-11-06 22:36:47');
INSERT INTO mobilee.t_login_log (id, user, created) VALUES (9, 1, '2017-11-05 22:36:51');
INSERT INTO mobilee.t_login_log (id, user, created) VALUES (10, 1, '2017-11-05 22:36:54');
INSERT INTO mobilee.t_login_log (id, user, created) VALUES (11, 1, '2017-11-05 22:36:58');
INSERT INTO mobilee.t_login_log (id, user, created) VALUES (12, 1, '2017-11-05 22:37:01');
INSERT INTO mobilee.t_login_log (id, user, created) VALUES (13, 1, '2017-11-04 22:37:05');
INSERT INTO mobilee.t_login_log (id, user, created) VALUES (14, 1, '2017-11-04 22:37:09');
INSERT INTO mobilee.t_login_log (id, user, created) VALUES (15, 2, '2017-11-09 10:50:14');
INSERT INTO mobilee.t_login_log (id, user, created) VALUES (16, 2, '2017-11-09 13:24:09');
INSERT INTO mobilee.t_login_log (id, user, created) VALUES (17, 2, '2017-11-09 13:30:24');
INSERT INTO mobilee.t_login_log (id, user, created) VALUES (18, 2, '2017-11-09 13:33:17');
INSERT INTO mobilee.t_login_log (id, user, created) VALUES (19, 2, '2017-11-10 08:50:40');
INSERT INTO mobilee.t_login_log (id, user, created) VALUES (20, 2, '2017-11-10 08:57:35');
INSERT INTO mobilee.t_login_log (id, user, created) VALUES (21, 93108, '2017-11-10 10:42:30');