CREATE TABLE mobilee.t_manufacturer
(
    id bigint(20) PRIMARY KEY NOT NULL COMMENT '主键' AUTO_INCREMENT,
    name varchar(18) DEFAULT '无名' NOT NULL COMMENT '姓名',
    address varchar(200) COMMENT '地址',
    author bigint(20) NOT NULL COMMENT '作者',
    created timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    edition int(11) DEFAULT '0' NOT NULL COMMENT '文档版本',
    CONSTRAINT t_manufacturer_t_admin_id_fk FOREIGN KEY (author) REFERENCES t_admin (id) ON UPDATE CASCADE
);
CREATE INDEX t_manufacturer_t_admin_id_fk ON mobilee.t_manufacturer (author);
INSERT INTO mobilee.t_manufacturer (id, name, address, author, created, edition) VALUES (1, '小米', '北京市海淀区清河中街68号五彩城购物中心东区F2层', 1, '2017-11-02 16:17:36', 0);
INSERT INTO mobilee.t_manufacturer (id, name, address, author, created, edition) VALUES (5, '华为', null, 1, '2017-11-02 21:45:14', 0);
INSERT INTO mobilee.t_manufacturer (id, name, address, author, created, edition) VALUES (8, '苹果', null, 1, '2017-11-02 22:32:33', 0);
INSERT INTO mobilee.t_manufacturer (id, name, address, author, created, edition) VALUES (9, '魅族', null, 1, '2017-11-02 22:32:43', 0);
INSERT INTO mobilee.t_manufacturer (id, name, address, author, created, edition) VALUES (10, '锤子', null, 1, '2017-11-02 22:33:11', 0);
INSERT INTO mobilee.t_manufacturer (id, name, address, author, created, edition) VALUES (11, '黑莓', null, 1, '2017-11-02 22:34:59', 0);
INSERT INTO mobilee.t_manufacturer (id, name, address, author, created, edition) VALUES (12, '诺基亚', null, 1, '2017-11-02 22:48:41', 0);
INSERT INTO mobilee.t_manufacturer (id, name, address, author, created, edition) VALUES (13, '三星', null, 1, '2017-11-03 13:24:56', 0);
INSERT INTO mobilee.t_manufacturer (id, name, address, author, created, edition) VALUES (14, '小辣椒', null, 1, '2017-11-03 15:08:44', 0);
INSERT INTO mobilee.t_manufacturer (id, name, address, author, created, edition) VALUES (15, 'oppo', null, 1, '2017-11-05 20:57:26', 0);
INSERT INTO mobilee.t_manufacturer (id, name, address, author, created, edition) VALUES (16, '360', null, 1, '2017-11-05 21:00:29', 0);
INSERT INTO mobilee.t_manufacturer (id, name, address, author, created, edition) VALUES (17, '测试', null, 2, '2017-11-10 10:32:41', 0);
INSERT INTO mobilee.t_manufacturer (id, name, address, author, created, edition) VALUES (18, '测试2', null, 2, '2017-11-10 10:37:50', 0);