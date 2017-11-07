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
INSERT INTO mobilee.t_collection (id, mobile_phone, user, created) VALUES (1, 1, 1, '2017-11-04 12:21:50');
INSERT INTO mobilee.t_collection (id, mobile_phone, user, created) VALUES (2, 1, 1, '2017-11-05 12:16:26');
INSERT INTO mobilee.t_collection (id, mobile_phone, user, created) VALUES (3, 1, 1, '2017-11-05 12:16:31');