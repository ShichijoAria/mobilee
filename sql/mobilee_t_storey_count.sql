CREATE TABLE mobilee.t_storey_count
(
    id bigint(20) PRIMARY KEY NOT NULL COMMENT '主键' AUTO_INCREMENT,
    count int(11) DEFAULT '0' NOT NULL COMMENT '楼层数',
    mobile_phone bigint(20) NOT NULL COMMENT '手机',
    CONSTRAINT t_storey_count_t_mobile_phone_id_fk FOREIGN KEY (mobile_phone) REFERENCES t_mobile_phone (id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX t_storey_count_t_mobile_phone_id_fk ON mobilee.t_storey_count (mobile_phone);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (17, 2, 1);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (18, 0, 2);