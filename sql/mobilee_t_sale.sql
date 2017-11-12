CREATE TABLE mobilee.t_sale
(
    id bigint(20) PRIMARY KEY NOT NULL COMMENT '主键' AUTO_INCREMENT,
    name varchar(18) DEFAULT '无名' NOT NULL COMMENT '姓名',
    address varchar(200) COMMENT '地址',
    edition int(11) DEFAULT '0' NOT NULL COMMENT '文档版本',
    created timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    author bigint(20) NOT NULL COMMENT '作者',
    phone varchar(13),
    CONSTRAINT t_sale_t_admin_id_fk FOREIGN KEY (author) REFERENCES t_admin (id) ON UPDATE CASCADE
);
CREATE INDEX t_sale_t_admin_id_fk ON mobilee.t_sale (author);
INSERT INTO mobilee.t_sale (id, name, address, edition, created, author, phone) VALUES (1, '黑店', 'https://www.taobao.com/', 5, '2017-11-03 12:52:04', 1, '113213123');
INSERT INTO mobilee.t_sale (id, name, address, edition, created, author, phone) VALUES (2, '天猫', null, 0, '2017-11-03 13:12:33', 1, null);
INSERT INTO mobilee.t_sale (id, name, address, edition, created, author, phone) VALUES (3, '死神', null, 0, '2017-11-03 13:23:50', 1, null);