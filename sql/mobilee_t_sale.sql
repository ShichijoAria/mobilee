CREATE TABLE mobilee.t_sale
(
    id bigint(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name varchar(18) DEFAULT '无名' NOT NULL,
    address varchar(200),
    edition int(11) DEFAULT '0' NOT NULL,
    created timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    author bigint(20) NOT NULL,
    CONSTRAINT t_sale_t_admin_id_fk FOREIGN KEY (author) REFERENCES t_admin (id) ON UPDATE CASCADE
);
CREATE INDEX t_sale_t_admin_id_fk ON mobilee.t_sale (author);
INSERT INTO mobilee.t_sale (id, name, address, edition, created, author) VALUES (1, '黑店', null, 0, '2017-11-03 12:52:04', 1);
INSERT INTO mobilee.t_sale (id, name, address, edition, created, author) VALUES (2, '天猫', null, 0, '2017-11-03 13:12:33', 1);
INSERT INTO mobilee.t_sale (id, name, address, edition, created, author) VALUES (3, '死神', null, 0, '2017-11-03 13:23:50', 1);