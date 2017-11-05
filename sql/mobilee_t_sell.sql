CREATE TABLE mobilee.t_sell
(
    id bigint(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    price float DEFAULT '0' NOT NULL,
    mobile_phone bigint(20) DEFAULT '0' NOT NULL,
    sale bigint(20) DEFAULT '0' NOT NULL,
    author bigint(20) DEFAULT '0' NOT NULL,
    created timestamp DEFAULT CURRENT_TIMESTAMP,
    edtion int(11) DEFAULT '0' NOT NULL,
    CONSTRAINT t_sell_t_mobile_phone_id_fk FOREIGN KEY (mobile_phone) REFERENCES t_mobile_phone (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT t_sell_t_sale_id_fk FOREIGN KEY (sale) REFERENCES t_sale (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT t_sell_t_admin_id_fk FOREIGN KEY (author) REFERENCES t_admin (id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX t_sell_t_admin_id_fk ON mobilee.t_sell (author);
CREATE INDEX t_sell_t_mobile_phone_id_fk ON mobilee.t_sell (mobile_phone);
CREATE INDEX t_sell_t_sale_id_fk ON mobilee.t_sell (sale);
INSERT INTO mobilee.t_sell (id, price, mobile_phone, sale, author, created, edtion) VALUES (1, 0, 1, 1, 1, '2017-11-04 14:55:33', 0);