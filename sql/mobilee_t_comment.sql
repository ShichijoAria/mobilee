CREATE TABLE mobilee.t_comment
(
    id bigint(20) PRIMARY KEY NOT NULL COMMENT '主键' AUTO_INCREMENT,
    content varchar(200) DEFAULT '' NOT NULL COMMENT '评论',
    created timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    author bigint(20) DEFAULT '0' NOT NULL COMMENT '作者',
    mobile_phone bigint(20) DEFAULT '0' NOT NULL COMMENT '手机',
    storey int(11) DEFAULT '0' NOT NULL COMMENT '楼层',
    CONSTRAINT t_comment_t_user_id_fk FOREIGN KEY (author) REFERENCES t_user (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT t_comment_t_mobile_phone_id_fk FOREIGN KEY (mobile_phone) REFERENCES t_mobile_phone (id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX t_comment_t_mobile_phone_id_fk ON mobilee.t_comment (mobile_phone);
CREATE INDEX t_comment_t_user_id_fk ON mobilee.t_comment (author);
INSERT INTO mobilee.t_comment (id, content, created, author, mobile_phone, storey) VALUES (1, '垃圾手机', '2017-11-04 19:18:46', 1, 1, 0);
INSERT INTO mobilee.t_comment (id, content, created, author, mobile_phone, storey) VALUES (2, '辣鸡', '2017-11-04 23:37:25', 1, 2, 0);
INSERT INTO mobilee.t_comment (id, content, created, author, mobile_phone, storey) VALUES (3, '', '2017-11-04 23:38:20', 1, 2, 0);
INSERT INTO mobilee.t_comment (id, content, created, author, mobile_phone, storey) VALUES (4, '垃圾', '2017-11-05 11:29:28', 1, 1, 1);