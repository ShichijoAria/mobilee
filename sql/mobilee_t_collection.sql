CREATE TABLE mobilee.t_collection
(
    id bigint(20) PRIMARY KEY NOT NULL COMMENT '主键' AUTO_INCREMENT,
    mobile_phone bigint(20) NOT NULL COMMENT '手机',
    user bigint(20) NOT NULL COMMENT '用户',
    created timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    CONSTRAINT t_collection_t_mobile_phone_id_fk FOREIGN KEY (mobile_phone) REFERENCES t_mobile_phone (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT t_collection_t_user_id_fk FOREIGN KEY (user) REFERENCES t_user (id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX t_collection_t_mobile_phone_id_fk ON mobilee.t_collection (mobile_phone);
CREATE INDEX t_collection_t_user_id_fk ON mobilee.t_collection (user);
INSERT INTO mobilee.t_collection (id, mobile_phone, user, created) VALUES (12, 1, 2, '2017-11-07 22:10:43');
INSERT INTO mobilee.t_collection (id, mobile_phone, user, created) VALUES (13, 1, 93107, '2017-11-08 16:57:14');
INSERT INTO mobilee.t_collection (id, mobile_phone, user, created) VALUES (14, 1, 1, '2017-11-08 22:45:51');
INSERT INTO mobilee.t_collection (id, mobile_phone, user, created) VALUES (15, 1, 2, '2017-11-08 22:45:51');
INSERT INTO mobilee.t_collection (id, mobile_phone, user, created) VALUES (16, 2, 3, '2017-11-08 22:45:51');
INSERT INTO mobilee.t_collection (id, mobile_phone, user, created) VALUES (17, 4, 1, '2017-11-08 22:45:51');
INSERT INTO mobilee.t_collection (id, mobile_phone, user, created) VALUES (18, 5, 1, '2017-11-08 22:45:51');
INSERT INTO mobilee.t_collection (id, mobile_phone, user, created) VALUES (19, 6, 1, '2017-11-08 22:45:51');
INSERT INTO mobilee.t_collection (id, mobile_phone, user, created) VALUES (20, 7, 1, '2017-11-08 22:45:51');
INSERT INTO mobilee.t_collection (id, mobile_phone, user, created) VALUES (21, 8, 1, '2017-11-08 22:45:51');
INSERT INTO mobilee.t_collection (id, mobile_phone, user, created) VALUES (22, 9, 2, '2017-11-08 22:45:51');
INSERT INTO mobilee.t_collection (id, mobile_phone, user, created) VALUES (23, 10, 3, '2017-11-08 22:45:51');
INSERT INTO mobilee.t_collection (id, mobile_phone, user, created) VALUES (24, 11, 2, '2017-11-08 22:45:51');
INSERT INTO mobilee.t_collection (id, mobile_phone, user, created) VALUES (25, 4, 2, '2017-11-09 13:24:13');
INSERT INTO mobilee.t_collection (id, mobile_phone, user, created) VALUES (26, 1, 93108, '2017-11-10 10:42:38');