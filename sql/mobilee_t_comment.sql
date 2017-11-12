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
INSERT INTO mobilee.t_comment (id, content, created, author, mobile_phone, storey) VALUES (1, '垃圾手机', '2017-11-04 19:18:46', 1, 1, 1);
INSERT INTO mobilee.t_comment (id, content, created, author, mobile_phone, storey) VALUES (4, '发的规划及地方了；交给对方考虑；价格；东方丽景的法规尽快的发生过', '2017-11-05 11:29:28', 1, 1, 2);
INSERT INTO mobilee.t_comment (id, content, created, author, mobile_phone, storey) VALUES (6, '打发时间过来看；地方见过了；金顶佛光；极度分裂；感觉发了；的建设管理；发生的经过了；地方就是看了个技术的反馈结果看了的房间观看了就是地方了感觉了；是否见过了； ', '2017-11-06 22:38:00', 1, 1, 3);
INSERT INTO mobilee.t_comment (id, content, created, author, mobile_phone, storey) VALUES (7, '我S8要回来的！SSG fuck you～', '2017-11-06 22:38:28', 1, 1, 4);
INSERT INTO mobilee.t_comment (id, content, created, author, mobile_phone, storey) VALUES (8, '性价比高', '2017-11-07 12:15:46', 2, 1, 5);
INSERT INTO mobilee.t_comment (id, content, created, author, mobile_phone, storey) VALUES (9, '规范和冬季减肥计划分工会经费和价格非常', '2017-11-07 16:48:04', 2, 1, 5);
INSERT INTO mobilee.t_comment (id, content, created, author, mobile_phone, storey) VALUES (10, '很优秀的手机', '2017-11-10 08:59:56', 2, 17, 1);
INSERT INTO mobilee.t_comment (id, content, created, author, mobile_phone, storey) VALUES (11, '很好的手机', '2017-11-10 09:00:08', 2, 17, 2);
INSERT INTO mobilee.t_comment (id, content, created, author, mobile_phone, storey) VALUES (12, '没有肾来买了', '2017-11-10 09:00:49', 2, 4, 1);
INSERT INTO mobilee.t_comment (id, content, created, author, mobile_phone, storey) VALUES (13, '啦啦啦', '2017-11-10 09:01:00', 2, 4, 2);
INSERT INTO mobilee.t_comment (id, content, created, author, mobile_phone, storey) VALUES (14, '测试', '2017-11-10 10:43:19', 93108, 1, 7);
INSERT INTO mobilee.t_comment (id, content, created, author, mobile_phone, storey) VALUES (15, '测试', '2017-11-10 10:43:27', 93108, 1, 8);