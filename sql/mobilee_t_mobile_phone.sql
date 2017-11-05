CREATE TABLE mobilee.t_mobile_phone
(
    id bigint(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name varchar(18) DEFAULT '山寨机' NOT NULL,
    cpu varchar(18) DEFAULT '未知型号' NOT NULL,
    memory int(11) DEFAULT '0' NOT NULL,
    storage int(11) DEFAULT '0' NOT NULL,
    price float DEFAULT '0' NOT NULL,
    created timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    list_time timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    size float DEFAULT '4' NOT NULL,
    width float DEFAULT '1',
    pixel int(11) DEFAULT '0',
    camera_pixel int(11) DEFAULT '0',
    height float DEFAULT '1',
    author bigint(20) NOT NULL,
    manufacturer bigint(20) NOT NULL,
    length int(11) DEFAULT '0' NOT NULL,
    edition int(11) DEFAULT '0' NOT NULL,
    CONSTRAINT t_mobile_phone_t_admin_id_fk FOREIGN KEY (author) REFERENCES t_admin (id) ON UPDATE CASCADE,
    CONSTRAINT t_mobile_phone_t_manufacturer_id_fk FOREIGN KEY (manufacturer) REFERENCES t_manufacturer (id) ON UPDATE CASCADE
);
CREATE INDEX t_mobile_phone_t_admin_id_fk ON mobilee.t_mobile_phone (author);
CREATE INDEX t_mobile_phone_t_manufacturer_id_fk ON mobilee.t_mobile_phone (manufacturer);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (1, '小米5', '骁龙820', 0, 0, 0, '2017-11-03 17:53:06', '2017-11-03 00:00:00', 4, 1, 0, 0, 1, 1, 1, 0, 5);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (2, '小米2', '未知型号', 0, 0, 0, '2017-11-04 11:40:40', '2017-11-04 11:40:40', 0, 0, 0, 0, 0, 1, 1, 0, 0);