CREATE TABLE mobilee.t_mobile_phone
(
    id bigint(20) PRIMARY KEY NOT NULL COMMENT '主键' AUTO_INCREMENT,
    name varchar(18) DEFAULT '山寨机' NOT NULL COMMENT '姓名',
    cpu varchar(18) DEFAULT '未知型号' NOT NULL COMMENT 'cpu型号',
    memory int(11) DEFAULT '0' NOT NULL COMMENT '运行内存',
    storage int(11) DEFAULT '0' NOT NULL COMMENT '存储空间',
    price float DEFAULT '0' NOT NULL COMMENT '价格',
    created timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    list_time timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '开售时间',
    size float DEFAULT '4' NOT NULL COMMENT '屏幕尺寸',
    width float DEFAULT '1' COMMENT '手机宽度',
    pixel int(11) DEFAULT '0' COMMENT '手机像素',
    camera_pixel int(11) DEFAULT '0' COMMENT '相机像素',
    height float DEFAULT '1' COMMENT '手机高度',
    author bigint(20) NOT NULL COMMENT '录入人',
    manufacturer bigint(20) NOT NULL COMMENT '厂商',
    length int(11) DEFAULT '0' NOT NULL COMMENT '手机长度',
    edition int(11) DEFAULT '0' NOT NULL COMMENT '文档版本',
    CONSTRAINT t_mobile_phone_t_admin_id_fk FOREIGN KEY (author) REFERENCES t_admin (id) ON UPDATE CASCADE,
    CONSTRAINT t_mobile_phone_t_manufacturer_id_fk FOREIGN KEY (manufacturer) REFERENCES t_manufacturer (id) ON UPDATE CASCADE
);
CREATE INDEX t_mobile_phone_t_admin_id_fk ON mobilee.t_mobile_phone (author);
CREATE INDEX t_mobile_phone_t_manufacturer_id_fk ON mobilee.t_mobile_phone (manufacturer);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (1, '小米5', '骁龙820', 0, 0, 0, '2017-11-03 17:53:06', '2017-11-03 00:00:00', 4, 1, 0, 0, 1, 1, 1, 0, 5);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (2, '小米2', '未知型号', 0, 0, 0, '2017-11-04 11:40:40', '2017-11-04 11:40:40', 0, 0, 0, 0, 0, 1, 1, 0, 0);