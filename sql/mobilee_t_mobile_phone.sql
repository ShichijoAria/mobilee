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
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (1, '小米5', '骁龙820', 0, 0, 500, '2017-11-03 17:53:06', '2017-11-03 00:00:00', 4, 1, 0, 0, 1, 1, 1, 0, 8);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (2, '红米5A', '未知型号', 0, 0, 5445, '2017-11-04 11:40:40', '2017-11-04 00:00:00', 0, 0, 0, 0, 0, 1, 1, 0, 2);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (3, 'OPPO R11s', '高通骁龙660', 4, 64, 2999, '2017-11-05 20:59:54', '2017-11-01 00:00:00', 6.01, 75.5, 0, 0, 7.1, 1, 15, 0, 0);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (4, 'iphoneX', '苹果A11', 0, 64, 8388, '2017-11-06 12:52:11', '2017-11-09 00:00:00', 5.8, 70.9, 0, 0, 7.7, 1, 8, 0, 0);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (5, '华为Mate10', '海思kirin970', 4, 64, 3899, '2017-11-06 12:56:37', '2017-10-09 00:00:00', 5.9, 77.8, 0, 0, 8.2, 1, 5, 0, 0);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (6, '华为P10', '海思kirin960', 4, 64, 3788, '2017-11-06 12:58:13', '2017-02-02 00:00:00', 5.1, 77.8, 0, 0, 8.2, 1, 5, 0, 0);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (7, 'iphone6s', '苹果A9', 2, 16, 3788, '2017-11-06 13:00:51', '2015-09-02 00:00:00', 4.7, 67.1, 0, 0, 7.1, 1, 8, 0, 0);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (8, 'iphone7', '苹果A10', 2, 32, 4499, '2017-11-06 13:02:12', '2012-09-04 00:00:00', 4.7, 67.1, 0, 0, 7.1, 1, 8, 0, 0);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (9, 'iphone6plus', '苹果A8', 2, 16, 3288, '2017-11-06 13:04:04', '2012-09-04 00:00:00', 5.5, 77.8, 0, 0, 7.1, 1, 8, 0, 0);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (10, 'iphone6', '苹果A8', 1, 64, 3288, '2017-11-06 13:07:30', '2012-09-04 00:00:00', 5.5, 67, 0, 0, 6.9, 1, 8, 0, 0);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (11, '华为P10plus', '海思Kirin960', 6, 128, 4888, '2017-11-06 13:13:16', '2017-02-01 00:00:00', 5.5, 74.2, 0, 0, 6.98, 1, 5, 0, 0);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (12, '华为Mate9', '海思Kirin960', 6, 128, 4199, '2017-11-06 13:14:57', '2017-02-01 00:00:00', 5.5, 78.9, 0, 0, 7.9, 1, 5, 0, 0);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (13, '荣耀Magic', '海思Kirin950', 4, 0, 4199, '2017-11-06 13:17:19', '2016-12-01 00:00:00', 5.09, 69.9, 0, 0, 6.8, 1, 5, 0, 0);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (14, '荣耀V9(尊享版)', '海思Kirin960', 6, 128, 3499, '2017-11-06 13:19:20', '2016-12-01 00:00:00', 5.7, 77.5, 0, 0, 6.97, 1, 5, 0, 0);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (15, '魅族PRO6s', '联发科helio X25', 4, 64, 2299, '2017-11-06 13:22:06', '2016-10-01 00:00:00', 5.2, 70.8, 0, 0, 7.3, 1, 9, 0, 0);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (16, '魅族MX6', '联发科helio X20', 3, 32, 1599, '2017-11-06 13:25:22', '2016-10-01 00:00:00', 5.5, 75.2, 0, 0, 7.25, 1, 9, 0, 0);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (17, '魅族PRO7', '联发科helio P25', 3, 64, 2499, '2017-11-06 13:27:02', '2016-10-01 00:00:00', 5.2, 70.72, 0, 0, 7.3, 1, 9, 0, 0);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (18, '魅族PRO7plus', '联发科helio X30', 6, 128, 4080, '2017-11-06 13:28:39', '2016-10-01 00:00:00', 5.7, 77.24, 0, 0, 7.3, 1, 9, 0, 0);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (21, '测试', '未知型号', 456, 546, 45645, '2017-11-09 12:55:08', '2017-11-16 00:00:00', 45, 456, 0, 0, 456, 2, 5, 0, 0);
INSERT INTO mobilee.t_mobile_phone (id, name, cpu, memory, storage, price, created, list_time, size, width, pixel, camera_pixel, height, author, manufacturer, length, edition) VALUES (22, '测是', '未知', 0, 0, 0, '2017-11-10 10:40:11', '2017-11-21 00:00:00', 2, 2, 0, 0, 22, 2, 18, 0, 0);