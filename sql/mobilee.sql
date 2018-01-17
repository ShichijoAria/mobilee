/*
Navicat MySQL Data Transfer

Source Server         : mobilee
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : mobilee

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2017-11-16 15:08:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_admin
-- ----------------------------
DROP TABLE IF EXISTS `t_admin`;
CREATE TABLE `t_admin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(18) DEFAULT '阿卡林' COMMENT '姓名',
  `password` varchar(18) DEFAULT '123456' COMMENT '密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='管理员';

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `t_admin` VALUES ('1', '龙傲天', '123456');
INSERT INTO `t_admin` VALUES ('2', '叶良辰d', '123456');
INSERT INTO `t_admin` VALUES ('3', '赵日天', '123456');

-- ----------------------------
-- Table structure for t_collection
-- ----------------------------
DROP TABLE IF EXISTS `t_collection`;
CREATE TABLE `t_collection` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mobile_phone` bigint(20) NOT NULL COMMENT '手机',
  `user` bigint(20) NOT NULL COMMENT '用户',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `t_collection_t_mobile_phone_id_fk` (`mobile_phone`),
  KEY `t_collection_t_user_id_fk` (`user`),
  CONSTRAINT `t_collection_t_mobile_phone_id_fk` FOREIGN KEY (`mobile_phone`) REFERENCES `t_mobile_phone` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_collection_t_user_id_fk` FOREIGN KEY (`user`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='收藏';

-- ----------------------------
-- Records of t_collection
-- ----------------------------
INSERT INTO `t_collection` VALUES ('12', '1', '2', '2017-11-07 22:10:43');
INSERT INTO `t_collection` VALUES ('13', '1', '93107', '2017-11-08 16:57:14');
INSERT INTO `t_collection` VALUES ('14', '1', '1', '2017-11-08 22:45:51');
INSERT INTO `t_collection` VALUES ('15', '1', '2', '2017-11-08 22:45:51');
INSERT INTO `t_collection` VALUES ('16', '2', '3', '2017-11-08 22:45:51');
INSERT INTO `t_collection` VALUES ('17', '4', '1', '2017-11-08 22:45:51');
INSERT INTO `t_collection` VALUES ('18', '5', '1', '2017-11-08 22:45:51');
INSERT INTO `t_collection` VALUES ('19', '6', '1', '2017-11-08 22:45:51');
INSERT INTO `t_collection` VALUES ('20', '7', '1', '2017-11-08 22:45:51');
INSERT INTO `t_collection` VALUES ('21', '8', '1', '2017-11-08 22:45:51');
INSERT INTO `t_collection` VALUES ('22', '9', '2', '2017-11-08 22:45:51');
INSERT INTO `t_collection` VALUES ('23', '10', '3', '2017-11-08 22:45:51');
INSERT INTO `t_collection` VALUES ('24', '11', '2', '2017-11-08 22:45:51');
INSERT INTO `t_collection` VALUES ('25', '4', '2', '2017-11-09 13:24:13');
INSERT INTO `t_collection` VALUES ('26', '1', '93108', '2017-11-10 10:42:38');

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `content` varchar(200) NOT NULL DEFAULT '' COMMENT '评论',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `author` bigint(20) NOT NULL DEFAULT '0' COMMENT '作者',
  `mobile_phone` bigint(20) NOT NULL DEFAULT '0' COMMENT '手机',
  `storey` int(11) NOT NULL DEFAULT '0' COMMENT '楼层',
  PRIMARY KEY (`id`),
  KEY `t_comment_t_mobile_phone_id_fk` (`mobile_phone`),
  KEY `t_comment_t_user_id_fk` (`author`),
  CONSTRAINT `t_comment_t_mobile_phone_id_fk` FOREIGN KEY (`mobile_phone`) REFERENCES `t_mobile_phone` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_comment_t_user_id_fk` FOREIGN KEY (`author`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='评论';

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES ('1', '垃圾手机', '2017-11-04 19:18:46', '1', '1', '1');
INSERT INTO `t_comment` VALUES ('4', '发的规划及地方了；交给对方考虑；价格；东方丽景的法规尽快的发生过', '2017-11-05 11:29:28', '1', '1', '2');
INSERT INTO `t_comment` VALUES ('6', '打发时间过来看；地方见过了；金顶佛光；极度分裂；感觉发了；的建设管理；发生的经过了；地方就是看了个技术的反馈结果看了的房间观看了就是地方了感觉了；是否见过了； ', '2017-11-06 22:38:00', '1', '1', '3');
INSERT INTO `t_comment` VALUES ('7', '我S8要回来的！SSG fuck you～', '2017-11-06 22:38:28', '1', '1', '4');
INSERT INTO `t_comment` VALUES ('8', '性价比高', '2017-11-07 12:15:46', '2', '1', '5');
INSERT INTO `t_comment` VALUES ('9', '规范和冬季减肥计划分工会经费和价格非常', '2017-11-07 16:48:04', '2', '1', '5');
INSERT INTO `t_comment` VALUES ('10', '很优秀的手机', '2017-11-10 08:59:56', '2', '17', '1');
INSERT INTO `t_comment` VALUES ('11', '很好的手机', '2017-11-10 09:00:08', '2', '17', '2');
INSERT INTO `t_comment` VALUES ('12', '没有肾来买了', '2017-11-10 09:00:49', '2', '4', '1');
INSERT INTO `t_comment` VALUES ('13', '啦啦啦', '2017-11-10 09:01:00', '2', '4', '2');
INSERT INTO `t_comment` VALUES ('14', '测试', '2017-11-10 10:43:19', '93108', '1', '7');
INSERT INTO `t_comment` VALUES ('15', '测试', '2017-11-10 10:43:27', '93108', '1', '8');

-- ----------------------------
-- Table structure for t_login_log
-- ----------------------------
DROP TABLE IF EXISTS `t_login_log`;
CREATE TABLE `t_login_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user` bigint(20) NOT NULL COMMENT '用户',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '登录日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='登录日志';

-- ----------------------------
-- Records of t_login_log
-- ----------------------------
INSERT INTO `t_login_log` VALUES ('1', '1', '2017-11-08 21:23:02');
INSERT INTO `t_login_log` VALUES ('2', '1', '2017-11-08 21:23:23');
INSERT INTO `t_login_log` VALUES ('3', '2', '2017-11-08 21:32:57');
INSERT INTO `t_login_log` VALUES ('4', '1', '2017-11-07 22:36:30');
INSERT INTO `t_login_log` VALUES ('5', '2', '2017-11-07 22:36:36');
INSERT INTO `t_login_log` VALUES ('6', '1', '2017-11-07 22:36:40');
INSERT INTO `t_login_log` VALUES ('7', '1', '2017-11-06 22:36:43');
INSERT INTO `t_login_log` VALUES ('8', '1', '2017-11-06 22:36:47');
INSERT INTO `t_login_log` VALUES ('9', '1', '2017-11-05 22:36:51');
INSERT INTO `t_login_log` VALUES ('10', '1', '2017-11-05 22:36:54');
INSERT INTO `t_login_log` VALUES ('11', '1', '2017-11-05 22:36:58');
INSERT INTO `t_login_log` VALUES ('12', '1', '2017-11-05 22:37:01');
INSERT INTO `t_login_log` VALUES ('13', '1', '2017-11-04 22:37:05');
INSERT INTO `t_login_log` VALUES ('14', '1', '2017-11-04 22:37:09');
INSERT INTO `t_login_log` VALUES ('15', '2', '2017-11-09 10:50:14');
INSERT INTO `t_login_log` VALUES ('16', '2', '2017-11-09 13:24:09');
INSERT INTO `t_login_log` VALUES ('17', '2', '2017-11-09 13:30:24');
INSERT INTO `t_login_log` VALUES ('18', '2', '2017-11-09 13:33:17');
INSERT INTO `t_login_log` VALUES ('19', '2', '2017-11-10 08:50:40');
INSERT INTO `t_login_log` VALUES ('20', '2', '2017-11-10 08:57:35');
INSERT INTO `t_login_log` VALUES ('21', '93108', '2017-11-10 10:42:30');

-- ----------------------------
-- Table structure for t_manufacturer
-- ----------------------------
DROP TABLE IF EXISTS `t_manufacturer`;
CREATE TABLE `t_manufacturer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(18) NOT NULL DEFAULT '无名' COMMENT '姓名',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  `author` bigint(20) NOT NULL COMMENT '作者',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `edition` int(11) NOT NULL DEFAULT '0' COMMENT '文档版本',
  PRIMARY KEY (`id`),
  KEY `t_manufacturer_t_admin_id_fk` (`author`),
  CONSTRAINT `t_manufacturer_t_admin_id_fk` FOREIGN KEY (`author`) REFERENCES `t_admin` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='制造商';

-- ----------------------------
-- Records of t_manufacturer
-- ----------------------------
INSERT INTO `t_manufacturer` VALUES ('1', '小米', '北京市海淀区清河中街68号五彩城购物中心东区F2层', '1', '2017-11-02 16:17:36', '0');
INSERT INTO `t_manufacturer` VALUES ('5', '华为', null, '1', '2017-11-02 21:45:14', '0');
INSERT INTO `t_manufacturer` VALUES ('8', '苹果', null, '1', '2017-11-02 22:32:33', '0');
INSERT INTO `t_manufacturer` VALUES ('9', '魅族', null, '1', '2017-11-02 22:32:43', '0');
INSERT INTO `t_manufacturer` VALUES ('10', '锤子', null, '1', '2017-11-02 22:33:11', '0');
INSERT INTO `t_manufacturer` VALUES ('11', '黑莓', null, '1', '2017-11-02 22:34:59', '0');
INSERT INTO `t_manufacturer` VALUES ('12', '诺基亚', null, '1', '2017-11-02 22:48:41', '0');
INSERT INTO `t_manufacturer` VALUES ('13', '三星', null, '1', '2017-11-03 13:24:56', '0');
INSERT INTO `t_manufacturer` VALUES ('14', '小辣椒', null, '1', '2017-11-03 15:08:44', '0');
INSERT INTO `t_manufacturer` VALUES ('15', 'oppo', null, '1', '2017-11-05 20:57:26', '0');
INSERT INTO `t_manufacturer` VALUES ('16', '360', null, '1', '2017-11-05 21:00:29', '0');
INSERT INTO `t_manufacturer` VALUES ('17', '测试', null, '2', '2017-11-10 10:32:41', '0');
INSERT INTO `t_manufacturer` VALUES ('18', '测试2', null, '2', '2017-11-10 10:37:50', '0');

-- ----------------------------
-- Table structure for t_mobile_phone
-- ----------------------------
DROP TABLE IF EXISTS `t_mobile_phone`;
CREATE TABLE `t_mobile_phone` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(18) NOT NULL DEFAULT '山寨机' COMMENT '姓名',
  `cpu` varchar(18) NOT NULL DEFAULT '未知型号' COMMENT 'cpu型号',
  `memory` int(11) NOT NULL DEFAULT '0' COMMENT '运行内存',
  `storage` int(11) NOT NULL DEFAULT '0' COMMENT '存储空间',
  `price` float NOT NULL DEFAULT '0' COMMENT '价格',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `list_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开售时间',
  `size` float NOT NULL DEFAULT '4' COMMENT '屏幕尺寸',
  `width` float DEFAULT '1' COMMENT '手机宽度',
  `pixel` int(11) DEFAULT '0' COMMENT '手机像素',
  `camera_pixel` int(11) DEFAULT '0' COMMENT '相机像素',
  `height` float DEFAULT '1' COMMENT '手机高度',
  `author` bigint(20) NOT NULL COMMENT '录入人',
  `manufacturer` bigint(20) NOT NULL COMMENT '厂商',
  `length` int(11) NOT NULL DEFAULT '0' COMMENT '手机长度',
  `edition` int(11) NOT NULL DEFAULT '0' COMMENT '文档版本',
  PRIMARY KEY (`id`),
  KEY `t_mobile_phone_t_admin_id_fk` (`author`),
  KEY `t_mobile_phone_t_manufacturer_id_fk` (`manufacturer`),
  CONSTRAINT `t_mobile_phone_t_admin_id_fk` FOREIGN KEY (`author`) REFERENCES `t_admin` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `t_mobile_phone_t_manufacturer_id_fk` FOREIGN KEY (`manufacturer`) REFERENCES `t_manufacturer` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='手机';

-- ----------------------------
-- Records of t_mobile_phone
-- ----------------------------
INSERT INTO `t_mobile_phone` VALUES ('1', '小米5', '骁龙820', '0', '0', '500', '2017-11-03 17:53:06', '2017-11-03 00:00:00', '4', '1', '0', '0', '1', '1', '1', '0', '8');
INSERT INTO `t_mobile_phone` VALUES ('2', '红米5A', '未知型号', '0', '0', '5445', '2017-11-04 11:40:40', '2017-11-04 00:00:00', '0', '0', '0', '0', '0', '1', '1', '0', '2');
INSERT INTO `t_mobile_phone` VALUES ('3', 'OPPO R11s', '高通骁龙660', '4', '64', '2999', '2017-11-05 20:59:54', '2017-11-01 00:00:00', '6.01', '75.5', '0', '0', '7.1', '1', '15', '0', '0');
INSERT INTO `t_mobile_phone` VALUES ('4', 'iphoneX', '苹果A11', '0', '64', '8388', '2017-11-06 12:52:11', '2017-11-09 00:00:00', '5.8', '70.9', '0', '0', '7.7', '1', '8', '0', '0');
INSERT INTO `t_mobile_phone` VALUES ('5', '华为Mate10', '海思kirin970', '4', '64', '3899', '2017-11-06 12:56:37', '2017-10-09 00:00:00', '5.9', '77.8', '0', '0', '8.2', '1', '5', '0', '0');
INSERT INTO `t_mobile_phone` VALUES ('6', '华为P10', '海思kirin960', '4', '64', '3788', '2017-11-06 12:58:13', '2017-02-02 00:00:00', '5.1', '77.8', '0', '0', '8.2', '1', '5', '0', '0');
INSERT INTO `t_mobile_phone` VALUES ('7', 'iphone6s', '苹果A9', '2', '16', '3788', '2017-11-06 13:00:51', '2015-09-02 00:00:00', '4.7', '67.1', '0', '0', '7.1', '1', '8', '0', '0');
INSERT INTO `t_mobile_phone` VALUES ('8', 'iphone7', '苹果A10', '2', '32', '4499', '2017-11-06 13:02:12', '2012-09-04 00:00:00', '4.7', '67.1', '0', '0', '7.1', '1', '8', '0', '0');
INSERT INTO `t_mobile_phone` VALUES ('9', 'iphone6plus', '苹果A8', '2', '16', '3288', '2017-11-06 13:04:04', '2012-09-04 00:00:00', '5.5', '77.8', '0', '0', '7.1', '1', '8', '0', '0');
INSERT INTO `t_mobile_phone` VALUES ('10', 'iphone6', '苹果A8', '1', '64', '3288', '2017-11-06 13:07:30', '2012-09-04 00:00:00', '5.5', '67', '0', '0', '6.9', '1', '8', '0', '0');
INSERT INTO `t_mobile_phone` VALUES ('11', '华为P10plus', '海思Kirin960', '6', '128', '4888', '2017-11-06 13:13:16', '2017-02-01 00:00:00', '5.5', '74.2', '0', '0', '6.98', '1', '5', '0', '0');
INSERT INTO `t_mobile_phone` VALUES ('12', '华为Mate9', '海思Kirin960', '6', '128', '4199', '2017-11-06 13:14:57', '2017-02-01 00:00:00', '5.5', '78.9', '0', '0', '7.9', '1', '5', '0', '0');
INSERT INTO `t_mobile_phone` VALUES ('13', '荣耀Magic', '海思Kirin950', '4', '0', '4199', '2017-11-06 13:17:19', '2016-12-01 00:00:00', '5.09', '69.9', '0', '0', '6.8', '1', '5', '0', '0');
INSERT INTO `t_mobile_phone` VALUES ('14', '荣耀V9(尊享版)', '海思Kirin960', '6', '128', '3499', '2017-11-06 13:19:20', '2016-12-01 00:00:00', '5.7', '77.5', '0', '0', '6.97', '1', '5', '0', '0');
INSERT INTO `t_mobile_phone` VALUES ('15', '魅族PRO6s', '联发科helio X25', '4', '64', '2299', '2017-11-06 13:22:06', '2016-10-01 00:00:00', '5.2', '70.8', '0', '0', '7.3', '1', '9', '0', '0');
INSERT INTO `t_mobile_phone` VALUES ('16', '魅族MX6', '联发科helio X20', '3', '32', '1599', '2017-11-06 13:25:22', '2016-10-01 00:00:00', '5.5', '75.2', '0', '0', '7.25', '1', '9', '0', '0');
INSERT INTO `t_mobile_phone` VALUES ('17', '魅族PRO7', '联发科helio P25', '3', '64', '2499', '2017-11-06 13:27:02', '2016-10-01 00:00:00', '5.2', '70.72', '0', '0', '7.3', '1', '9', '0', '0');
INSERT INTO `t_mobile_phone` VALUES ('18', '魅族PRO7plus', '联发科helio X30', '6', '128', '4080', '2017-11-06 13:28:39', '2016-10-01 00:00:00', '5.7', '77.24', '0', '0', '7.3', '1', '9', '0', '0');
INSERT INTO `t_mobile_phone` VALUES ('21', '测试', '未知型号', '456', '546', '45645', '2017-11-09 12:55:08', '2017-11-16 00:00:00', '45', '456', '0', '0', '456', '2', '5', '0', '0');
INSERT INTO `t_mobile_phone` VALUES ('22', '测是', '未知', '0', '0', '0', '2017-11-10 10:40:11', '2017-11-21 00:00:00', '2', '2', '0', '0', '22', '2', '18', '0', '0');

-- ----------------------------
-- Table structure for t_operate
-- ----------------------------
DROP TABLE IF EXISTS `t_operate`;
CREATE TABLE `t_operate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `remark` varchar(200) NOT NULL DEFAULT '暂无详情' COMMENT '备注',
  `admin` bigint(20) NOT NULL COMMENT '管理员',
  `user` bigint(20) NOT NULL COMMENT '用户',
  PRIMARY KEY (`id`),
  KEY `t_operate_t_admin_id_fk` (`admin`),
  KEY `t_operate_t_user_id_fk` (`user`),
  CONSTRAINT `t_operate_t_admin_id_fk` FOREIGN KEY (`admin`) REFERENCES `t_admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_operate_t_user_id_fk` FOREIGN KEY (`user`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作记录';

-- ----------------------------
-- Records of t_operate
-- ----------------------------

-- ----------------------------
-- Table structure for t_sale
-- ----------------------------
DROP TABLE IF EXISTS `t_sale`;
CREATE TABLE `t_sale` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(18) NOT NULL DEFAULT '无名' COMMENT '姓名',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  `edition` int(11) NOT NULL DEFAULT '0' COMMENT '文档版本',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `author` bigint(20) NOT NULL COMMENT '作者',
  `phone` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `t_sale_t_admin_id_fk` (`author`),
  CONSTRAINT `t_sale_t_admin_id_fk` FOREIGN KEY (`author`) REFERENCES `t_admin` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='商家';

-- ----------------------------
-- Records of t_sale
-- ----------------------------
INSERT INTO `t_sale` VALUES ('1', '黑店', 'https://www.taobao.com/', '5', '2017-11-03 12:52:04', '1', '113213123');
INSERT INTO `t_sale` VALUES ('2', '天猫', null, '0', '2017-11-03 13:12:33', '1', null);
INSERT INTO `t_sale` VALUES ('3', '死神', null, '0', '2017-11-03 13:23:50', '1', null);

-- ----------------------------
-- Table structure for t_sell
-- ----------------------------
DROP TABLE IF EXISTS `t_sell`;
CREATE TABLE `t_sell` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `price` float NOT NULL DEFAULT '0' COMMENT '销售价格',
  `mobile_phone` bigint(20) NOT NULL DEFAULT '0' COMMENT '手机',
  `sale` bigint(20) NOT NULL DEFAULT '0' COMMENT '商家',
  `author` bigint(20) NOT NULL DEFAULT '0' COMMENT '作者',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `edtion` int(11) NOT NULL DEFAULT '0' COMMENT '文档版本',
  PRIMARY KEY (`id`),
  KEY `t_sell_t_admin_id_fk` (`author`),
  KEY `t_sell_t_mobile_phone_id_fk` (`mobile_phone`),
  KEY `t_sell_t_sale_id_fk` (`sale`),
  CONSTRAINT `t_sell_t_admin_id_fk` FOREIGN KEY (`author`) REFERENCES `t_admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_sell_t_mobile_phone_id_fk` FOREIGN KEY (`mobile_phone`) REFERENCES `t_mobile_phone` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_sell_t_sale_id_fk` FOREIGN KEY (`sale`) REFERENCES `t_sale` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='销售';

-- ----------------------------
-- Records of t_sell
-- ----------------------------
INSERT INTO `t_sell` VALUES ('1', '0', '1', '1', '1', '2017-11-04 14:55:33', '0');
INSERT INTO `t_sell` VALUES ('2', '1500', '1', '2', '1', '2017-11-06 16:59:55', '0');

-- ----------------------------
-- Table structure for t_storey_count
-- ----------------------------
DROP TABLE IF EXISTS `t_storey_count`;
CREATE TABLE `t_storey_count` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `count` int(11) NOT NULL DEFAULT '1' COMMENT '楼层数',
  `mobile_phone` bigint(20) NOT NULL COMMENT '手机',
  PRIMARY KEY (`id`),
  KEY `t_storey_count_t_mobile_phone_id_fk` (`mobile_phone`),
  CONSTRAINT `t_storey_count_t_mobile_phone_id_fk` FOREIGN KEY (`mobile_phone`) REFERENCES `t_mobile_phone` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='楼层记录';

-- ----------------------------
-- Records of t_storey_count
-- ----------------------------
INSERT INTO `t_storey_count` VALUES ('17', '9', '1');
INSERT INTO `t_storey_count` VALUES ('18', '1', '2');
INSERT INTO `t_storey_count` VALUES ('19', '1', '3');
INSERT INTO `t_storey_count` VALUES ('20', '3', '4');
INSERT INTO `t_storey_count` VALUES ('21', '1', '5');
INSERT INTO `t_storey_count` VALUES ('22', '1', '6');
INSERT INTO `t_storey_count` VALUES ('23', '1', '7');
INSERT INTO `t_storey_count` VALUES ('24', '1', '8');
INSERT INTO `t_storey_count` VALUES ('25', '1', '9');
INSERT INTO `t_storey_count` VALUES ('26', '1', '10');
INSERT INTO `t_storey_count` VALUES ('27', '1', '11');
INSERT INTO `t_storey_count` VALUES ('28', '1', '12');
INSERT INTO `t_storey_count` VALUES ('29', '1', '13');
INSERT INTO `t_storey_count` VALUES ('30', '1', '14');
INSERT INTO `t_storey_count` VALUES ('31', '1', '15');
INSERT INTO `t_storey_count` VALUES ('32', '1', '16');
INSERT INTO `t_storey_count` VALUES ('33', '3', '17');
INSERT INTO `t_storey_count` VALUES ('34', '1', '18');
INSERT INTO `t_storey_count` VALUES ('37', '1', '21');
INSERT INTO `t_storey_count` VALUES ('38', '1', '22');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(18) NOT NULL DEFAULT '阿卡林' COMMENT '姓名',
  `password` varchar(18) NOT NULL DEFAULT '123456' COMMENT '密码',
  `gender` tinyint(4) DEFAULT '1' COMMENT '1男2女',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `birthday` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生日',
  `phone` varchar(13) DEFAULT NULL COMMENT '手机',
  `email` varchar(18) DEFAULT NULL COMMENT '邮箱',
  `edition` int(11) NOT NULL DEFAULT '0' COMMENT '文档版本',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93109 DEFAULT CHARSET=utf8 COMMENT='用户';

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', '李哥', '123456', '2', '2017-11-01 17:35:00', '2017-10-31 00:00:00', null, null, '7');
INSERT INTO `t_user` VALUES ('2', '夜吹', '123456', '1', '2017-11-01 17:35:00', '2017-10-31 00:00:00', null, null, '6');
INSERT INTO `t_user` VALUES ('3', '阿卡', '123456', '1', '2017-11-01 17:35:00', '2017-10-31 00:00:00', null, null, '2');
INSERT INTO `t_user` VALUES ('4', '卡', '123456', '1', '2017-11-01 17:35:21', '2017-10-31 18:18:00', null, null, '1');
INSERT INTO `t_user` VALUES ('5', '阿卡林', '123456', '1', '2017-11-01 17:35:21', '2017-10-31 18:18:00', null, null, '1');
INSERT INTO `t_user` VALUES ('6', '小智', '123456', '1', '2017-11-01 17:35:00', '2017-10-31 00:00:00', null, null, '3');
INSERT INTO `t_user` VALUES ('7', '阿卡林', '123456', '1', '2017-11-01 17:35:21', '2017-10-31 18:18:00', null, null, '1');
INSERT INTO `t_user` VALUES ('8', '狗贼', '123456', '1', '2017-11-01 17:35:21', '2017-10-31 18:18:00', null, null, '1');
INSERT INTO `t_user` VALUES ('9', '涛妹', '123456', '1', '2017-11-01 17:35:00', '2017-10-31 00:00:00', null, null, '2');
INSERT INTO `t_user` VALUES ('10', '小漠', '123456', '1', '2017-11-02 21:58:00', '2017-11-02 00:00:00', null, null, '1');
INSERT INTO `t_user` VALUES ('12', '阿卡林', '123456', '1', '2017-11-02 21:59:24', '2017-11-02 21:59:24', null, null, '0');
INSERT INTO `t_user` VALUES ('13', '张三', '123456', '1', '2017-11-05 20:08:13', '2017-11-05 20:08:13', null, null, '0');
INSERT INTO `t_user` VALUES ('14', '张三', '123456', '1', '2017-11-05 20:08:13', '2017-11-05 20:08:13', null, null, '0');
INSERT INTO `t_user` VALUES ('15', '张三', '123456', '1', '2017-11-05 20:08:13', '2017-11-05 20:08:13', null, null, '0');
INSERT INTO `t_user` VALUES ('16', '张三', '123456', '1', '2017-11-05 20:08:13', '2017-11-05 20:08:13', null, null, '0');
INSERT INTO `t_user` VALUES ('17', '张三', '123456', '1', '2017-11-05 20:08:13', '2017-11-05 20:08:13', null, null, '0');
INSERT INTO `t_user` VALUES ('18', '张三', '123456', '1', '2017-11-05 20:08:13', '2017-11-05 20:08:13', null, null, '0');
INSERT INTO `t_user` VALUES ('19', '张三', '123456', '1', '2017-11-05 20:08:13', '2017-11-05 20:08:13', null, null, '0');
INSERT INTO `t_user` VALUES ('20', '张三', '123456', '1', '2017-11-05 20:08:13', '2017-11-05 20:08:13', null, null, '0');
INSERT INTO `t_user` VALUES ('93003', '张三', '123456', '1', '2017-11-05 20:18:19', '2017-11-05 20:18:19', null, null, '0');
INSERT INTO `t_user` VALUES ('93004', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93005', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93006', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93007', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93008', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93009', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93010', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93011', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93012', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93013', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93014', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93015', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93016', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93017', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93018', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93019', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93020', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93021', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93022', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93023', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93024', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93025', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93026', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93027', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93028', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93029', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93030', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93031', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93032', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93033', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93034', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93035', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93036', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93037', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93038', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93039', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93040', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93041', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93042', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93043', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93044', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93045', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93046', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93047', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93048', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93049', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93050', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93051', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93052', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93053', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93054', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93055', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93056', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93057', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93058', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93059', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93060', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93061', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93062', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93063', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93064', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93065', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93066', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93067', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93068', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93069', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93070', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93071', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93072', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93073', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93074', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93075', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93076', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93077', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93078', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93079', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93080', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93081', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93082', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93083', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93084', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93085', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93086', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93087', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93088', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93089', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93090', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93091', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93092', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93093', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93094', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93095', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93096', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93097', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93098', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93099', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93100', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93101', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93102', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93103', '李四', '123456', '1', '2017-11-05 20:22:25', '2017-11-05 20:22:25', null, null, '0');
INSERT INTO `t_user` VALUES ('93104', '小不懂', '123456', '1', '2017-11-08 14:43:14', '2017-11-08 14:43:14', null, null, '0');
INSERT INTO `t_user` VALUES ('93105', '小不懂', '123456', '1', '2017-11-08 14:43:21', '2017-11-08 14:43:21', null, null, '0');
INSERT INTO `t_user` VALUES ('93106', '杨过', '123456', '1', '2017-11-08 14:55:48', '2017-11-08 14:55:48', null, null, '0');
INSERT INTO `t_user` VALUES ('93107', '黑崎一护', '123456', '1', '2017-11-08 16:51:09', '2017-11-08 16:51:09', null, null, '0');
INSERT INTO `t_user` VALUES ('93108', '测试', '123456', '1', '2017-11-10 10:42:11', '2017-11-10 10:42:11', null, null, '0');

-- ----------------------------
-- Procedure structure for p_get_page
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_get_page`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_get_page`(IN `_fields` varchar(2000), IN `_tables` varchar(1000), IN `_where` varchar(2000), IN `_order_by` varchar(200), IN `_page_index` int, IN `_page_size` int, OUT `_total_count` int, OUT `_page_count` int)
begin
    -- name：分页查询
    -- @param：_fields     要查询的字段用逗号隔开
    -- @param：_tables     要查询的表
    -- @param：_where      查询条件
    -- @param：_order_by    排序字段
    -- @param：_page       当前页计数从1开始
    -- @param：_page_size   每页大小
    -- @param：_total_count 总记录数
    -- @param：_page_count  总页数
    set @start_row = _page_size*(_page_index -1);
    set @page_size = _page_size;  set @row_index = 0;
    set @str_sql = CONCAT(
        'SELECT SQL_CALC_FOUND_ROWS ',_fields,' FROM ',_tables,case ifnull(_where,'') when '' then '' else concat(' WHERE ',_where) end,' ORDER BY ',_order_by,' LIMIT ',@start_row,',',@page_size);
    prepare str_sql from @str_sql;
    execute str_sql;
    deallocate prepare str_sql;
    set _total_count = found_rows();

    if (_total_count <= _page_size) then
      set _page_count = 1;
    else if (_total_count % _page_size > 0) then
      set _page_count = _total_count / _page_size + 1;
    else
      set _page_count = _total_count / _page_size;
    end if;
    end if;
  end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_insert_comment
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_insert_comment`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_insert_comment`(IN `_content` varchar(200), IN `_mobile_phone` bigint, IN `_author` bigint)
BEGIN
    DECLARE sequence INT;
    DECLARE rtn BIGINT DEFAULT 0;
    DECLARE t_error INTEGER DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET t_error=1;

    START TRANSACTION;
    SELECT count INTO sequence FROM t_storey_count WHERE t_storey_count.mobile_phone=_mobile_phone;
    INSERT INTO t_comment (content, created, author, mobile_phone, storey) VALUES (ifnull(_content,""),current_timestamp,_author,_mobile_phone,sequence);
    UPDATE t_storey_count SET count=count+1 WHERE t_storey_count.mobile_phone=_mobile_phone;
    SELECT max(id) INTO rtn FROM t_comment;
    IF t_error = 1 THEN
      ROLLBACK;
    ELSE
      COMMIT;
    END IF;

    SELECT rtn;
  END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_insert_mobile_phone
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_insert_mobile_phone`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_insert_mobile_phone`(IN `_name` varchar(18), IN `_cpu` varchar(18), IN `_memory` int, IN `_storage` int, IN `_price` float, IN `_list_time` timestamp, IN `_size` float, IN `_width` float, IN `_height` float, IN `_pixel` int, IN `_camera_pixel` int, IN `_author` int(20), IN `_manufacturer` bigint)
BEGIN
    DECLARE mobile_phone_id BIGINT(20);
    DECLARE t_error INTEGER DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET t_error=1;

    START TRANSACTION;
    INSERT INTO t_mobile_phone (name,cpu,memory,storage,price,created,list_time,size,width,height,pixel,camera_pixel,author,manufacturer)
    VALUES (ifnull(_name,"山寨机"),ifnull(_cpu,"未知型号"),ifnull(_memory,0),ifnull(_storage,0),ifnull(_price,0),
                                current_timestamp,ifnull(_list_time,current_timestamp),ifnull(_size,0),ifnull(_width,0),
                                ifnull(_height,0),ifnull(_pixel,0),ifnull(_camera_pixel,0),_author,_manufacturer);
    select max(id) from t_mobile_phone into mobile_phone_id;
    INSERT INTO t_storey_count (mobile_phone) VALUES (mobile_phone_id);
    IF t_error = 1 THEN
      ROLLBACK;
      SELECT 0;
    ELSE
      COMMIT;
      select mobile_phone_id;
    END IF;


  END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_target_collection
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_target_collection`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_target_collection`(IN `_mobile_phone` bigint, IN `_user` bigint)
BEGIN
    DECLARE count BIGINT DEFAULT 0;
    DECLARE t_error INTEGER DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET t_error=1;

    START TRANSACTION;

    SELECT count(*) INTO count FROM t_collection WHERE mobile_phone=_mobile_phone AND user=_user;

    if count=0 THEN
      INSERT INTO t_collection(mobile_phone, user)VALUES (_mobile_phone,_user);
      SET count=1;
    ELSE
      DELETE FROM t_collection WHERE mobile_phone=_mobile_phone AND user=_user;
      SET count=2;
    END IF;

    IF t_error = 1 THEN
      ROLLBACK;
    ELSE
      COMMIT;
    END IF;

    SELECT count;

  END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_user_login
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_user_login`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_user_login`(IN `_id` bigint, IN `_password` varchar(18))
BEGIN
    DECLARE t_error INTEGER DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET t_error=1;

    START TRANSACTION;

    SELECT name FROM t_user WHERE id=_id AND password=_password;
    IF found_rows()>0 THEN
      INSERT INTO t_login_log(user)VALUES (_id);
    END IF;

    IF t_error = 1 THEN
      ROLLBACK;
    ELSE
      COMMIT;
    END IF;

  END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for test
-- ----------------------------
DROP PROCEDURE IF EXISTS `test`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `test`()
BEGIN
    DECLARE a INT DEFAULT 100;
    WHILE a>0
    DO
      INSERT INTO t_user(name)VALUES ("李四");
      SET a=a-1;
    END WHILE;
  END
;;
DELIMITER ;
