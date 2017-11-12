CREATE TABLE mobilee.t_storey_count
(
    id bigint(20) PRIMARY KEY NOT NULL COMMENT '主键' AUTO_INCREMENT,
    count int(11) DEFAULT '1' NOT NULL COMMENT '楼层数',
    mobile_phone bigint(20) NOT NULL COMMENT '手机',
    CONSTRAINT t_storey_count_t_mobile_phone_id_fk FOREIGN KEY (mobile_phone) REFERENCES t_mobile_phone (id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX t_storey_count_t_mobile_phone_id_fk ON mobilee.t_storey_count (mobile_phone);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (17, 9, 1);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (18, 1, 2);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (19, 1, 3);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (20, 3, 4);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (21, 1, 5);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (22, 1, 6);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (23, 1, 7);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (24, 1, 8);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (25, 1, 9);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (26, 1, 10);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (27, 1, 11);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (28, 1, 12);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (29, 1, 13);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (30, 1, 14);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (31, 1, 15);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (32, 1, 16);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (33, 3, 17);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (34, 1, 18);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (37, 1, 21);
INSERT INTO mobilee.t_storey_count (id, count, mobile_phone) VALUES (38, 1, 22);