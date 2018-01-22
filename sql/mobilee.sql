-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2018-01-22 15:24:16
-- 服务器版本： 5.7.20-0ubuntu0.16.04.1
-- PHP Version: 7.0.22-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mobilee`
--

DELIMITER $$
--
-- 存储过程
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_get_page` (IN `_fields` VARCHAR(2000), IN `_tables` VARCHAR(1000), IN `_where` VARCHAR(2000), IN `_order_by` VARCHAR(200), IN `_page_index` INT, IN `_page_size` INT, OUT `_total_count` INT, OUT `_page_count` INT)  begin
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
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p_insert_comment` (IN `_content` VARCHAR(200), IN `_mobile_phone` BIGINT, IN `_author` BIGINT)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p_insert_mobile_phone` (IN `_name` VARCHAR(18), IN `_cpu` VARCHAR(18), IN `_memory` INT, IN `_storage` INT, IN `_price` FLOAT, IN `_list_time` TIMESTAMP, IN `_size` FLOAT, IN `_width` FLOAT, IN `_height` FLOAT, IN `_pixel` INT, IN `_camera_pixel` INT, IN `_author` INT(20), IN `_manufacturer` BIGINT)  BEGIN
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


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p_target_collection` (IN `_mobile_phone` BIGINT, IN `_user` BIGINT)  BEGIN
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

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p_user_login` (IN `_temp` NVARCHAR(18), IN `_password` VARCHAR(18), IN `_type` INT)  BEGIN
  DECLARE t_error INTEGER DEFAULT 0;
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET t_error=1;

  START TRANSACTION;

  IF _type=0 THEN
    SELECT id,name,password,gender,created,birthday,phone,email FROM t_user WHERE name=`_temp` AND password=_password;
  ELSEIF _type=1 THEN
    SELECT id,name,password,gender,created,birthday,phone,email FROM t_user WHERE phone=`_temp` AND password=_password;
  ELSE
    SELECT id,name,password,gender,created,birthday,phone,email FROM t_user WHERE email=`_temp` AND password=_password;
  END IF;

  IF found_rows()>0 THEN
    INSERT INTO t_login_log(user)VALUES (`_temp`);
  END IF;

  IF t_error = 1 THEN
    ROLLBACK;
  ELSE
    COMMIT;
  END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `test` ()  BEGIN
  DECLARE a INT DEFAULT 100;
  WHILE a>0
  DO
    INSERT INTO t_user(name)VALUES ("李四");
    SET a=a-1;
  END WHILE;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `t_admin`
--

CREATE TABLE `t_admin` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(18) DEFAULT '阿卡林' COMMENT '姓名',
  `password` varchar(18) DEFAULT '123456' COMMENT '密码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员';

--
-- 转存表中的数据 `t_admin`
--

INSERT INTO `t_admin` (`id`, `name`, `password`) VALUES
  (1, '龙傲天', '123456'),
  (2, '叶良辰d', '123456'),
  (3, '赵日天', '123456');

-- --------------------------------------------------------

--
-- 表的结构 `t_collection`
--

CREATE TABLE `t_collection` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `mobile_phone` bigint(20) NOT NULL COMMENT '手机',
  `user` bigint(20) NOT NULL COMMENT '用户',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收藏';

--
-- 转存表中的数据 `t_collection`
--

INSERT INTO `t_collection` (`id`, `mobile_phone`, `user`, `created`) VALUES
  (12, 1, 2, '2017-11-07 14:10:43'),
  (14, 1, 1, '2017-11-08 14:45:51'),
  (15, 1, 2, '2017-11-08 14:45:51'),
  (16, 2, 3, '2017-11-08 14:45:51'),
  (17, 4, 1, '2017-11-08 14:45:51'),
  (18, 5, 1, '2017-11-08 14:45:51'),
  (19, 6, 1, '2017-11-08 14:45:51'),
  (20, 7, 1, '2017-11-08 14:45:51'),
  (21, 8, 1, '2017-11-08 14:45:51'),
  (22, 9, 2, '2017-11-08 14:45:51'),
  (23, 10, 3, '2017-11-08 14:45:51'),
  (24, 11, 2, '2017-11-08 14:45:51'),
  (25, 4, 2, '2017-11-09 05:24:13');

-- --------------------------------------------------------

--
-- 表的结构 `t_comment`
--

CREATE TABLE `t_comment` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `content` varchar(200) NOT NULL DEFAULT '' COMMENT '评论',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `author` bigint(20) NOT NULL DEFAULT '0' COMMENT '作者',
  `mobile_phone` bigint(20) NOT NULL DEFAULT '0' COMMENT '手机',
  `storey` int(11) NOT NULL DEFAULT '0' COMMENT '楼层'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论';

--
-- 转存表中的数据 `t_comment`
--

INSERT INTO `t_comment` (`id`, `content`, `created`, `author`, `mobile_phone`, `storey`) VALUES
  (1, '垃圾手机', '2017-11-04 11:18:46', 1, 1, 1),
  (4, '发的规划及地方了；交给对方考虑；价格；东方丽景的法规尽快的发生过', '2017-11-05 03:29:28', 1, 1, 2),
  (6, '打发时间过来看；地方见过了；金顶佛光；极度分裂；感觉发了；的建设管理；发生的经过了；地方就是看了个技术的反馈结果看了的房间观看了就是地方了感觉了；是否见过了； ', '2017-11-06 14:38:00', 1, 1, 3),
  (7, '我S8要回来的！SSG fuck you～', '2017-11-06 14:38:28', 1, 1, 4),
  (8, '性价比高', '2017-11-07 04:15:46', 2, 1, 5),
  (9, '规范和冬季减肥计划分工会经费和价格非常', '2017-11-07 08:48:04', 2, 1, 5),
  (10, '很优秀的手机', '2017-11-10 00:59:56', 2, 17, 1),
  (11, '很好的手机', '2017-11-10 01:00:08', 2, 17, 2),
  (12, '没有肾来买了', '2017-11-10 01:00:49', 2, 4, 1),
  (13, '啦啦啦', '2017-11-10 01:01:00', 2, 4, 2);

-- --------------------------------------------------------

--
-- 表的结构 `t_login_log`
--

CREATE TABLE `t_login_log` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user` bigint(20) NOT NULL COMMENT '用户',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '登录日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='登录日志';

--
-- 转存表中的数据 `t_login_log`
--

INSERT INTO `t_login_log` (`id`, `user`, `created`) VALUES
  (1, 1, '2017-11-08 13:23:02'),
  (2, 1, '2017-11-08 13:23:23'),
  (3, 2, '2017-11-08 13:32:57'),
  (4, 1, '2017-11-07 14:36:30'),
  (5, 2, '2017-11-07 14:36:36'),
  (6, 1, '2017-11-07 14:36:40'),
  (7, 1, '2017-11-06 14:36:43'),
  (8, 1, '2017-11-06 14:36:47'),
  (9, 1, '2017-11-05 14:36:51'),
  (10, 1, '2017-11-05 14:36:54'),
  (11, 1, '2017-11-05 14:36:58'),
  (12, 1, '2017-11-05 14:37:01'),
  (13, 1, '2017-11-04 14:37:05'),
  (14, 1, '2017-11-04 14:37:09'),
  (15, 2, '2017-11-09 02:50:14'),
  (16, 2, '2017-11-09 05:24:09'),
  (17, 2, '2017-11-09 05:30:24'),
  (18, 2, '2017-11-09 05:33:17'),
  (19, 2, '2017-11-10 00:50:40'),
  (20, 2, '2017-11-10 00:57:35'),
  (21, 93108, '2017-11-10 02:42:30'),
  (22, 15, '2018-01-21 05:29:16'),
  (23, 15, '2018-01-21 05:30:10'),
  (24, 15, '2018-01-21 05:30:38'),
  (25, 15, '2018-01-21 05:31:10'),
  (26, 15, '2018-01-21 05:49:55'),
  (27, 15, '2018-01-21 05:59:46'),
  (28, 15, '2018-01-21 09:54:33'),
  (29, 15, '2018-01-21 10:24:00'),
  (30, 1, '2018-01-21 14:28:39'),
  (31, 1, '2018-01-21 14:45:17'),
  (32, 1, '2018-01-21 14:48:27');

-- --------------------------------------------------------

--
-- 表的结构 `t_manufacturer`
--

CREATE TABLE `t_manufacturer` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(18) NOT NULL DEFAULT '无名' COMMENT '姓名',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  `author` bigint(20) NOT NULL COMMENT '作者',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `edition` int(11) NOT NULL DEFAULT '0' COMMENT '文档版本'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='制造商';

--
-- 转存表中的数据 `t_manufacturer`
--

INSERT INTO `t_manufacturer` (`id`, `name`, `address`, `author`, `created`, `edition`) VALUES
  (1, '小米', '北京市海淀区清河中街68号五彩城购物中心东区F2层', 1, '2017-11-02 08:17:36', 0),
  (5, '华为', NULL, 1, '2017-11-02 13:45:14', 0),
  (8, '苹果', NULL, 1, '2017-11-02 14:32:33', 0),
  (9, '魅族', NULL, 1, '2017-11-02 14:32:43', 0),
  (10, '锤子', NULL, 1, '2017-11-02 14:33:11', 0),
  (11, '黑莓', NULL, 1, '2017-11-02 14:34:59', 0),
  (12, '诺基亚', NULL, 1, '2017-11-02 14:48:41', 0),
  (13, '三星', NULL, 1, '2017-11-03 05:24:56', 0),
  (14, '小辣椒', NULL, 1, '2017-11-03 07:08:44', 0),
  (15, 'oppo', NULL, 1, '2017-11-05 12:57:26', 0),
  (16, '360', NULL, 1, '2017-11-05 13:00:29', 0),
  (17, '测试', NULL, 2, '2017-11-10 02:32:41', 0),
  (18, '测试2', NULL, 2, '2017-11-10 02:37:50', 0);

-- --------------------------------------------------------

--
-- 表的结构 `t_mobile_phone`
--

CREATE TABLE `t_mobile_phone` (
  `id` bigint(20) NOT NULL COMMENT '主键',
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
  `edition` int(11) NOT NULL DEFAULT '0' COMMENT '文档版本'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='手机';

--
-- 转存表中的数据 `t_mobile_phone`
--

INSERT INTO `t_mobile_phone` (`id`, `name`, `cpu`, `memory`, `storage`, `price`, `created`, `list_time`, `size`, `width`, `pixel`, `camera_pixel`, `height`, `author`, `manufacturer`, `length`, `edition`) VALUES
  (1, '小米5', '骁龙820', 0, 0, 500, '2017-11-03 09:53:06', '2017-11-02 16:00:00', 4, 1, 0, 0, 1, 1, 1, 0, 8),
  (2, '红米5A', '未知型号', 0, 0, 5445, '2017-11-04 03:40:40', '2017-11-03 16:00:00', 0, 0, 0, 0, 0, 1, 1, 0, 2),
  (3, 'OPPO R11s', '高通骁龙660', 4, 64, 2999, '2017-11-05 12:59:54', '2017-10-31 16:00:00', 6.01, 75.5, 0, 0, 7.1, 1, 15, 0, 0),
  (4, 'iphoneX', '苹果A11', 0, 64, 8388, '2017-11-06 04:52:11', '2017-11-08 16:00:00', 5.8, 70.9, 0, 0, 7.7, 1, 8, 0, 0),
  (5, '华为Mate10', '海思kirin970', 4, 64, 3899, '2017-11-06 04:56:37', '2017-10-08 16:00:00', 5.9, 77.8, 0, 0, 8.2, 1, 5, 0, 0),
  (6, '华为P10', '海思kirin960', 4, 64, 3788, '2017-11-06 04:58:13', '2017-02-01 16:00:00', 5.1, 77.8, 0, 0, 8.2, 1, 5, 0, 0),
  (7, 'iphone6s', '苹果A9', 2, 16, 3788, '2017-11-06 05:00:51', '2015-09-01 16:00:00', 4.7, 67.1, 0, 0, 7.1, 1, 8, 0, 0),
  (8, 'iphone7', '苹果A10', 2, 32, 4499, '2017-11-06 05:02:12', '2012-09-03 16:00:00', 4.7, 67.1, 0, 0, 7.1, 1, 8, 0, 0),
  (9, 'iphone6plus', '苹果A8', 2, 16, 3288, '2017-11-06 05:04:04', '2012-09-03 16:00:00', 5.5, 77.8, 0, 0, 7.1, 1, 8, 0, 0),
  (10, 'iphone6', '苹果A8', 1, 64, 3288, '2017-11-06 05:07:30', '2012-09-03 16:00:00', 5.5, 67, 0, 0, 6.9, 1, 8, 0, 0),
  (11, '华为P10plus', '海思Kirin960', 6, 128, 4888, '2017-11-06 05:13:16', '2017-01-31 16:00:00', 5.5, 74.2, 0, 0, 6.98, 1, 5, 0, 0),
  (12, '华为Mate9', '海思Kirin960', 6, 128, 4199, '2017-11-06 05:14:57', '2017-01-31 16:00:00', 5.5, 78.9, 0, 0, 7.9, 1, 5, 0, 0),
  (13, '荣耀Magic', '海思Kirin950', 4, 0, 4199, '2017-11-06 05:17:19', '2016-11-30 16:00:00', 5.09, 69.9, 0, 0, 6.8, 1, 5, 0, 0),
  (14, '荣耀V9(尊享版)', '海思Kirin960', 6, 128, 3499, '2017-11-06 05:19:20', '2016-11-30 16:00:00', 5.7, 77.5, 0, 0, 6.97, 1, 5, 0, 0),
  (15, '魅族PRO6s', '联发科helio X25', 4, 64, 2299, '2017-11-06 05:22:06', '2016-09-30 16:00:00', 5.2, 70.8, 0, 0, 7.3, 1, 9, 0, 0),
  (16, '魅族MX6', '联发科helio X20', 3, 32, 1599, '2017-11-06 05:25:22', '2016-09-30 16:00:00', 5.5, 75.2, 0, 0, 7.25, 1, 9, 0, 0),
  (17, '魅族PRO7', '联发科helio P25', 3, 64, 2499, '2017-11-06 05:27:02', '2016-09-30 16:00:00', 5.2, 70.72, 0, 0, 7.3, 1, 9, 0, 0),
  (18, '魅族PRO7plus', '联发科helio X30', 6, 128, 4080, '2017-11-06 05:28:39', '2016-09-30 16:00:00', 5.7, 77.24, 0, 0, 7.3, 1, 9, 0, 0),
  (21, '测试', '未知型号', 456, 546, 45645, '2017-11-09 04:55:08', '2017-11-15 16:00:00', 45, 456, 0, 0, 456, 2, 5, 0, 0),
  (22, '测是', '未知', 0, 0, 0, '2017-11-10 02:40:11', '2017-11-20 16:00:00', 2, 2, 0, 0, 22, 2, 18, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `t_operate`
--

CREATE TABLE `t_operate` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `remark` varchar(200) NOT NULL DEFAULT '暂无详情' COMMENT '备注',
  `admin` bigint(20) NOT NULL COMMENT '管理员',
  `user` bigint(20) NOT NULL COMMENT '用户'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作记录';

-- --------------------------------------------------------

--
-- 表的结构 `t_sale`
--

CREATE TABLE `t_sale` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(18) NOT NULL DEFAULT '无名' COMMENT '姓名',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  `edition` int(11) NOT NULL DEFAULT '0' COMMENT '文档版本',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `author` bigint(20) NOT NULL COMMENT '作者',
  `phone` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家';

--
-- 转存表中的数据 `t_sale`
--

INSERT INTO `t_sale` (`id`, `name`, `address`, `edition`, `created`, `author`, `phone`) VALUES
  (1, '黑店', 'https://www.taobao.com/', 5, '2017-11-03 04:52:04', 1, '113213123'),
  (2, '天猫', NULL, 0, '2017-11-03 05:12:33', 1, NULL),
  (3, '死神', NULL, 0, '2017-11-03 05:23:50', 1, NULL),
  (4, '4', '4', 0, '2018-01-22 06:49:07', 1, NULL),
  (5, '???', '??', 1, '2018-01-22 06:49:17', 1, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `t_sell`
--

CREATE TABLE `t_sell` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `price` float NOT NULL DEFAULT '0' COMMENT '销售价格',
  `mobile_phone` bigint(20) NOT NULL DEFAULT '0' COMMENT '手机',
  `sale` bigint(20) NOT NULL DEFAULT '0' COMMENT '商家',
  `author` bigint(20) NOT NULL DEFAULT '0' COMMENT '作者',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `edtion` int(11) NOT NULL DEFAULT '0' COMMENT '文档版本'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='销售';

--
-- 转存表中的数据 `t_sell`
--

INSERT INTO `t_sell` (`id`, `price`, `mobile_phone`, `sale`, `author`, `created`, `edtion`) VALUES
  (1, 0, 1, 1, 1, '2017-11-04 06:55:33', 0),
  (2, 1500, 1, 2, 1, '2017-11-06 08:59:55', 0);

-- --------------------------------------------------------

--
-- 表的结构 `t_storey_count`
--

CREATE TABLE `t_storey_count` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `count` int(11) NOT NULL DEFAULT '1' COMMENT '楼层数',
  `mobile_phone` bigint(20) NOT NULL COMMENT '手机'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='楼层记录';

--
-- 转存表中的数据 `t_storey_count`
--

INSERT INTO `t_storey_count` (`id`, `count`, `mobile_phone`) VALUES
  (17, 9, 1),
  (18, 1, 2),
  (19, 1, 3),
  (20, 3, 4),
  (21, 1, 5),
  (22, 1, 6),
  (23, 1, 7),
  (24, 1, 8),
  (25, 1, 9),
  (26, 1, 10),
  (27, 1, 11),
  (28, 1, 12),
  (29, 1, 13),
  (30, 1, 14),
  (31, 1, 15),
  (32, 1, 16),
  (33, 3, 17),
  (34, 1, 18),
  (37, 1, 21),
  (38, 1, 22);

-- --------------------------------------------------------

--
-- 表的结构 `t_user`
--

CREATE TABLE `t_user` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(18) NOT NULL COMMENT '姓名',
  `password` varchar(18) NOT NULL DEFAULT '123456' COMMENT '密码',
  `gender` tinyint(4) DEFAULT '1' COMMENT '1男2女',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `birthday` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生日',
  `phone` varchar(13) DEFAULT NULL COMMENT '手机',
  `email` varchar(18) DEFAULT NULL COMMENT '邮箱',
  `edition` int(11) NOT NULL DEFAULT '0' COMMENT '文档版本'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户';

--
-- 转存表中的数据 `t_user`
--

INSERT INTO `t_user` (`id`, `name`, `password`, `gender`, `created`, `birthday`, `phone`, `email`, `edition`) VALUES
  (1, '李哥', '123456', 2, '2017-11-01 09:35:00', '2017-10-30 16:00:00', NULL, NULL, 7),
  (2, '夜吹df', '123456', 1, '2017-11-01 09:35:00', '2017-10-30 16:00:00', NULL, NULL, 6),
  (3, '阿卡', '123456', 1, '2017-11-01 09:35:00', '2017-10-30 16:00:00', NULL, NULL, 2),
  (4, '卡fd', '123456', 1, '2017-11-01 09:35:21', '2017-10-31 10:18:00', NULL, NULL, 1),
  (5, '阿卡林112', '123456', 1, '2017-11-01 09:35:21', '2017-10-31 10:18:00', NULL, NULL, 1),
  (6, '小智df', '123456', 1, '2017-11-01 09:35:00', '2017-10-30 16:00:00', NULL, NULL, 3),
  (7, '阿卡林1', '123456', 1, '2017-11-01 09:35:21', '2017-10-31 10:18:00', NULL, NULL, 1),
  (8, '狗贼', '123456', 1, '2017-11-01 09:35:21', '2017-10-31 10:18:00', NULL, NULL, 1),
  (9, '涛妹', '123456', 1, '2017-11-01 09:35:00', '2017-10-30 16:00:00', NULL, NULL, 2),
  (10, '小漠fdf', '123456', 1, '2017-11-02 13:58:00', '2017-11-01 16:00:00', NULL, NULL, 1),
  (12, '阿卡林3', '123456', 1, '2017-11-02 13:59:24', '2017-11-02 13:59:24', NULL, NULL, 0),
  (13, '张三78', '123456', 1, '2017-11-05 12:08:13', '2017-11-05 12:08:13', NULL, NULL, 0),
  (14, '张三45', '123456', 1, '2017-11-05 12:08:13', '2017-11-05 12:08:13', NULL, NULL, 0),
  (15, 'a5', '123456', 1, '2017-11-05 12:08:13', '2017-11-05 12:08:13', NULL, NULL, 0),
  (16, '张三5gh', '123456', 1, '2017-11-05 12:08:13', '2017-11-05 12:08:13', NULL, NULL, 0),
  (17, '张三df', '123456', 1, '2017-11-05 12:08:13', '2017-11-05 12:08:13', NULL, NULL, 0),
  (18, '张三54', '123456', 1, '2017-11-05 12:08:13', '2017-11-05 12:08:13', NULL, NULL, 0),
  (19, '张三132', '123456', 1, '2017-11-05 12:08:13', '2017-11-05 12:08:13', NULL, NULL, 0),
  (20, '张三321', '123456', 1, '2017-11-05 12:08:13', '2017-11-05 12:08:13', NULL, NULL, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `t_admin`
--
ALTER TABLE `t_admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_collection`
--
ALTER TABLE `t_collection`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_collection_t_mobile_phone_id_fk` (`mobile_phone`),
  ADD KEY `t_collection_t_user_id_fk` (`user`);

--
-- Indexes for table `t_comment`
--
ALTER TABLE `t_comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_comment_t_mobile_phone_id_fk` (`mobile_phone`),
  ADD KEY `t_comment_t_user_id_fk` (`author`);

--
-- Indexes for table `t_login_log`
--
ALTER TABLE `t_login_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_manufacturer`
--
ALTER TABLE `t_manufacturer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_manufacturer_t_admin_id_fk` (`author`);

--
-- Indexes for table `t_mobile_phone`
--
ALTER TABLE `t_mobile_phone`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_mobile_phone_t_admin_id_fk` (`author`),
  ADD KEY `t_mobile_phone_t_manufacturer_id_fk` (`manufacturer`);

--
-- Indexes for table `t_operate`
--
ALTER TABLE `t_operate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_operate_t_admin_id_fk` (`admin`),
  ADD KEY `t_operate_t_user_id_fk` (`user`);

--
-- Indexes for table `t_sale`
--
ALTER TABLE `t_sale`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_sale_t_admin_id_fk` (`author`);

--
-- Indexes for table `t_sell`
--
ALTER TABLE `t_sell`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_sell_t_admin_id_fk` (`author`),
  ADD KEY `t_sell_t_mobile_phone_id_fk` (`mobile_phone`),
  ADD KEY `t_sell_t_sale_id_fk` (`sale`);

--
-- Indexes for table `t_storey_count`
--
ALTER TABLE `t_storey_count`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_storey_count_t_mobile_phone_id_fk` (`mobile_phone`);

--
-- Indexes for table `t_user`
--
ALTER TABLE `t_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `t_user_name_uindex` (`name`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `t_admin`
--
ALTER TABLE `t_admin`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=4;
--
-- 使用表AUTO_INCREMENT `t_collection`
--
ALTER TABLE `t_collection`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=26;
--
-- 使用表AUTO_INCREMENT `t_comment`
--
ALTER TABLE `t_comment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=14;
--
-- 使用表AUTO_INCREMENT `t_login_log`
--
ALTER TABLE `t_login_log`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=33;
--
-- 使用表AUTO_INCREMENT `t_manufacturer`
--
ALTER TABLE `t_manufacturer`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=19;
--
-- 使用表AUTO_INCREMENT `t_mobile_phone`
--
ALTER TABLE `t_mobile_phone`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=23;
--
-- 使用表AUTO_INCREMENT `t_operate`
--
ALTER TABLE `t_operate`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键';
--
-- 使用表AUTO_INCREMENT `t_sale`
--
ALTER TABLE `t_sale`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=6;
--
-- 使用表AUTO_INCREMENT `t_sell`
--
ALTER TABLE `t_sell`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `t_storey_count`
--
ALTER TABLE `t_storey_count`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=39;
--
-- 使用表AUTO_INCREMENT `t_user`
--
ALTER TABLE `t_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=21;
--
-- 限制导出的表
--

--
-- 限制表 `t_collection`
--
ALTER TABLE `t_collection`
  ADD CONSTRAINT `t_collection_t_mobile_phone_id_fk` FOREIGN KEY (`mobile_phone`) REFERENCES `t_mobile_phone` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `t_collection_t_user_id_fk` FOREIGN KEY (`user`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 限制表 `t_comment`
--
ALTER TABLE `t_comment`
  ADD CONSTRAINT `t_comment_t_mobile_phone_id_fk` FOREIGN KEY (`mobile_phone`) REFERENCES `t_mobile_phone` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `t_comment_t_user_id_fk` FOREIGN KEY (`author`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 限制表 `t_manufacturer`
--
ALTER TABLE `t_manufacturer`
  ADD CONSTRAINT `t_manufacturer_t_admin_id_fk` FOREIGN KEY (`author`) REFERENCES `t_admin` (`id`) ON UPDATE CASCADE;

--
-- 限制表 `t_mobile_phone`
--
ALTER TABLE `t_mobile_phone`
  ADD CONSTRAINT `t_mobile_phone_t_admin_id_fk` FOREIGN KEY (`author`) REFERENCES `t_admin` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `t_mobile_phone_t_manufacturer_id_fk` FOREIGN KEY (`manufacturer`) REFERENCES `t_manufacturer` (`id`) ON UPDATE CASCADE;

--
-- 限制表 `t_operate`
--
ALTER TABLE `t_operate`
  ADD CONSTRAINT `t_operate_t_admin_id_fk` FOREIGN KEY (`admin`) REFERENCES `t_admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `t_operate_t_user_id_fk` FOREIGN KEY (`user`) REFERENCES `t_user` (`id`);

--
-- 限制表 `t_sale`
--
ALTER TABLE `t_sale`
  ADD CONSTRAINT `t_sale_t_admin_id_fk` FOREIGN KEY (`author`) REFERENCES `t_admin` (`id`) ON UPDATE CASCADE;

--
-- 限制表 `t_sell`
--
ALTER TABLE `t_sell`
  ADD CONSTRAINT `t_sell_t_admin_id_fk` FOREIGN KEY (`author`) REFERENCES `t_admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `t_sell_t_mobile_phone_id_fk` FOREIGN KEY (`mobile_phone`) REFERENCES `t_mobile_phone` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `t_sell_t_sale_id_fk` FOREIGN KEY (`sale`) REFERENCES `t_sale` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 限制表 `t_storey_count`
--
ALTER TABLE `t_storey_count`
  ADD CONSTRAINT `t_storey_count_t_mobile_phone_id_fk` FOREIGN KEY (`mobile_phone`) REFERENCES `t_mobile_phone` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2018-01-22 15:24:16
-- 服务器版本： 5.7.20-0ubuntu0.16.04.1
-- PHP Version: 7.0.22-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mobilee`
--

DELIMITER $$
--
-- 存储过程
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_get_page` (IN `_fields` VARCHAR(2000), IN `_tables` VARCHAR(1000), IN `_where` VARCHAR(2000), IN `_order_by` VARCHAR(200), IN `_page_index` INT, IN `_page_size` INT, OUT `_total_count` INT, OUT `_page_count` INT)  begin
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
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p_insert_comment` (IN `_content` VARCHAR(200), IN `_mobile_phone` BIGINT, IN `_author` BIGINT)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p_insert_mobile_phone` (IN `_name` VARCHAR(18), IN `_cpu` VARCHAR(18), IN `_memory` INT, IN `_storage` INT, IN `_price` FLOAT, IN `_list_time` TIMESTAMP, IN `_size` FLOAT, IN `_width` FLOAT, IN `_height` FLOAT, IN `_pixel` INT, IN `_camera_pixel` INT, IN `_author` INT(20), IN `_manufacturer` BIGINT)  BEGIN
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


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p_target_collection` (IN `_mobile_phone` BIGINT, IN `_user` BIGINT)  BEGIN
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

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p_user_login` (IN `_temp` NVARCHAR(18), IN `_password` VARCHAR(18), IN `_type` INT)  BEGIN
  DECLARE t_error INTEGER DEFAULT 0;
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET t_error=1;

  START TRANSACTION;

  IF _type=0 THEN
    SELECT id,name,password,gender,created,birthday,phone,email FROM t_user WHERE name=`_temp` AND password=_password;
  ELSEIF _type=1 THEN
    SELECT id,name,password,gender,created,birthday,phone,email FROM t_user WHERE phone=`_temp` AND password=_password;
  ELSE
    SELECT id,name,password,gender,created,birthday,phone,email FROM t_user WHERE email=`_temp` AND password=_password;
  END IF;

  IF found_rows()>0 THEN
    INSERT INTO t_login_log(user)VALUES (`_temp`);
  END IF;

  IF t_error = 1 THEN
    ROLLBACK;
  ELSE
    COMMIT;
  END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `test` ()  BEGIN
  DECLARE a INT DEFAULT 100;
  WHILE a>0
  DO
    INSERT INTO t_user(name)VALUES ("李四");
    SET a=a-1;
  END WHILE;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `t_admin`
--

CREATE TABLE `t_admin` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(18) DEFAULT '阿卡林' COMMENT '姓名',
  `password` varchar(18) DEFAULT '123456' COMMENT '密码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员';

--
-- 转存表中的数据 `t_admin`
--

INSERT INTO `t_admin` (`id`, `name`, `password`) VALUES
  (1, '龙傲天', '123456'),
  (2, '叶良辰d', '123456'),
  (3, '赵日天', '123456');

-- --------------------------------------------------------

--
-- 表的结构 `t_collection`
--

CREATE TABLE `t_collection` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `mobile_phone` bigint(20) NOT NULL COMMENT '手机',
  `user` bigint(20) NOT NULL COMMENT '用户',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收藏';

--
-- 转存表中的数据 `t_collection`
--

INSERT INTO `t_collection` (`id`, `mobile_phone`, `user`, `created`) VALUES
  (12, 1, 2, '2017-11-07 14:10:43'),
  (14, 1, 1, '2017-11-08 14:45:51'),
  (15, 1, 2, '2017-11-08 14:45:51'),
  (16, 2, 3, '2017-11-08 14:45:51'),
  (17, 4, 1, '2017-11-08 14:45:51'),
  (18, 5, 1, '2017-11-08 14:45:51'),
  (19, 6, 1, '2017-11-08 14:45:51'),
  (20, 7, 1, '2017-11-08 14:45:51'),
  (21, 8, 1, '2017-11-08 14:45:51'),
  (22, 9, 2, '2017-11-08 14:45:51'),
  (23, 10, 3, '2017-11-08 14:45:51'),
  (24, 11, 2, '2017-11-08 14:45:51'),
  (25, 4, 2, '2017-11-09 05:24:13');

-- --------------------------------------------------------

--
-- 表的结构 `t_comment`
--

CREATE TABLE `t_comment` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `content` varchar(200) NOT NULL DEFAULT '' COMMENT '评论',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `author` bigint(20) NOT NULL DEFAULT '0' COMMENT '作者',
  `mobile_phone` bigint(20) NOT NULL DEFAULT '0' COMMENT '手机',
  `storey` int(11) NOT NULL DEFAULT '0' COMMENT '楼层'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论';

--
-- 转存表中的数据 `t_comment`
--

INSERT INTO `t_comment` (`id`, `content`, `created`, `author`, `mobile_phone`, `storey`) VALUES
  (1, '垃圾手机', '2017-11-04 11:18:46', 1, 1, 1),
  (4, '发的规划及地方了；交给对方考虑；价格；东方丽景的法规尽快的发生过', '2017-11-05 03:29:28', 1, 1, 2),
  (6, '打发时间过来看；地方见过了；金顶佛光；极度分裂；感觉发了；的建设管理；发生的经过了；地方就是看了个技术的反馈结果看了的房间观看了就是地方了感觉了；是否见过了； ', '2017-11-06 14:38:00', 1, 1, 3),
  (7, '我S8要回来的！SSG fuck you～', '2017-11-06 14:38:28', 1, 1, 4),
  (8, '性价比高', '2017-11-07 04:15:46', 2, 1, 5),
  (9, '规范和冬季减肥计划分工会经费和价格非常', '2017-11-07 08:48:04', 2, 1, 5),
  (10, '很优秀的手机', '2017-11-10 00:59:56', 2, 17, 1),
  (11, '很好的手机', '2017-11-10 01:00:08', 2, 17, 2),
  (12, '没有肾来买了', '2017-11-10 01:00:49', 2, 4, 1),
  (13, '啦啦啦', '2017-11-10 01:01:00', 2, 4, 2);

-- --------------------------------------------------------

--
-- 表的结构 `t_login_log`
--

CREATE TABLE `t_login_log` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user` bigint(20) NOT NULL COMMENT '用户',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '登录日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='登录日志';

--
-- 转存表中的数据 `t_login_log`
--

INSERT INTO `t_login_log` (`id`, `user`, `created`) VALUES
  (1, 1, '2017-11-08 13:23:02'),
  (2, 1, '2017-11-08 13:23:23'),
  (3, 2, '2017-11-08 13:32:57'),
  (4, 1, '2017-11-07 14:36:30'),
  (5, 2, '2017-11-07 14:36:36'),
  (6, 1, '2017-11-07 14:36:40'),
  (7, 1, '2017-11-06 14:36:43'),
  (8, 1, '2017-11-06 14:36:47'),
  (9, 1, '2017-11-05 14:36:51'),
  (10, 1, '2017-11-05 14:36:54'),
  (11, 1, '2017-11-05 14:36:58'),
  (12, 1, '2017-11-05 14:37:01'),
  (13, 1, '2017-11-04 14:37:05'),
  (14, 1, '2017-11-04 14:37:09'),
  (15, 2, '2017-11-09 02:50:14'),
  (16, 2, '2017-11-09 05:24:09'),
  (17, 2, '2017-11-09 05:30:24'),
  (18, 2, '2017-11-09 05:33:17'),
  (19, 2, '2017-11-10 00:50:40'),
  (20, 2, '2017-11-10 00:57:35'),
  (21, 93108, '2017-11-10 02:42:30'),
  (22, 15, '2018-01-21 05:29:16'),
  (23, 15, '2018-01-21 05:30:10'),
  (24, 15, '2018-01-21 05:30:38'),
  (25, 15, '2018-01-21 05:31:10'),
  (26, 15, '2018-01-21 05:49:55'),
  (27, 15, '2018-01-21 05:59:46'),
  (28, 15, '2018-01-21 09:54:33'),
  (29, 15, '2018-01-21 10:24:00'),
  (30, 1, '2018-01-21 14:28:39'),
  (31, 1, '2018-01-21 14:45:17'),
  (32, 1, '2018-01-21 14:48:27');

-- --------------------------------------------------------

--
-- 表的结构 `t_manufacturer`
--

CREATE TABLE `t_manufacturer` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(18) NOT NULL DEFAULT '无名' COMMENT '姓名',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  `author` bigint(20) NOT NULL COMMENT '作者',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `edition` int(11) NOT NULL DEFAULT '0' COMMENT '文档版本'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='制造商';

--
-- 转存表中的数据 `t_manufacturer`
--

INSERT INTO `t_manufacturer` (`id`, `name`, `address`, `author`, `created`, `edition`) VALUES
  (1, '小米', '北京市海淀区清河中街68号五彩城购物中心东区F2层', 1, '2017-11-02 08:17:36', 0),
  (5, '华为', NULL, 1, '2017-11-02 13:45:14', 0),
  (8, '苹果', NULL, 1, '2017-11-02 14:32:33', 0),
  (9, '魅族', NULL, 1, '2017-11-02 14:32:43', 0),
  (10, '锤子', NULL, 1, '2017-11-02 14:33:11', 0),
  (11, '黑莓', NULL, 1, '2017-11-02 14:34:59', 0),
  (12, '诺基亚', NULL, 1, '2017-11-02 14:48:41', 0),
  (13, '三星', NULL, 1, '2017-11-03 05:24:56', 0),
  (14, '小辣椒', NULL, 1, '2017-11-03 07:08:44', 0),
  (15, 'oppo', NULL, 1, '2017-11-05 12:57:26', 0),
  (16, '360', NULL, 1, '2017-11-05 13:00:29', 0),
  (17, '测试', NULL, 2, '2017-11-10 02:32:41', 0),
  (18, '测试2', NULL, 2, '2017-11-10 02:37:50', 0);

-- --------------------------------------------------------

--
-- 表的结构 `t_mobile_phone`
--

CREATE TABLE `t_mobile_phone` (
  `id` bigint(20) NOT NULL COMMENT '主键',
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
  `edition` int(11) NOT NULL DEFAULT '0' COMMENT '文档版本'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='手机';

--
-- 转存表中的数据 `t_mobile_phone`
--

INSERT INTO `t_mobile_phone` (`id`, `name`, `cpu`, `memory`, `storage`, `price`, `created`, `list_time`, `size`, `width`, `pixel`, `camera_pixel`, `height`, `author`, `manufacturer`, `length`, `edition`) VALUES
  (1, '小米5', '骁龙820', 0, 0, 500, '2017-11-03 09:53:06', '2017-11-02 16:00:00', 4, 1, 0, 0, 1, 1, 1, 0, 8),
  (2, '红米5A', '未知型号', 0, 0, 5445, '2017-11-04 03:40:40', '2017-11-03 16:00:00', 0, 0, 0, 0, 0, 1, 1, 0, 2),
  (3, 'OPPO R11s', '高通骁龙660', 4, 64, 2999, '2017-11-05 12:59:54', '2017-10-31 16:00:00', 6.01, 75.5, 0, 0, 7.1, 1, 15, 0, 0),
  (4, 'iphoneX', '苹果A11', 0, 64, 8388, '2017-11-06 04:52:11', '2017-11-08 16:00:00', 5.8, 70.9, 0, 0, 7.7, 1, 8, 0, 0),
  (5, '华为Mate10', '海思kirin970', 4, 64, 3899, '2017-11-06 04:56:37', '2017-10-08 16:00:00', 5.9, 77.8, 0, 0, 8.2, 1, 5, 0, 0),
  (6, '华为P10', '海思kirin960', 4, 64, 3788, '2017-11-06 04:58:13', '2017-02-01 16:00:00', 5.1, 77.8, 0, 0, 8.2, 1, 5, 0, 0),
  (7, 'iphone6s', '苹果A9', 2, 16, 3788, '2017-11-06 05:00:51', '2015-09-01 16:00:00', 4.7, 67.1, 0, 0, 7.1, 1, 8, 0, 0),
  (8, 'iphone7', '苹果A10', 2, 32, 4499, '2017-11-06 05:02:12', '2012-09-03 16:00:00', 4.7, 67.1, 0, 0, 7.1, 1, 8, 0, 0),
  (9, 'iphone6plus', '苹果A8', 2, 16, 3288, '2017-11-06 05:04:04', '2012-09-03 16:00:00', 5.5, 77.8, 0, 0, 7.1, 1, 8, 0, 0),
  (10, 'iphone6', '苹果A8', 1, 64, 3288, '2017-11-06 05:07:30', '2012-09-03 16:00:00', 5.5, 67, 0, 0, 6.9, 1, 8, 0, 0),
  (11, '华为P10plus', '海思Kirin960', 6, 128, 4888, '2017-11-06 05:13:16', '2017-01-31 16:00:00', 5.5, 74.2, 0, 0, 6.98, 1, 5, 0, 0),
  (12, '华为Mate9', '海思Kirin960', 6, 128, 4199, '2017-11-06 05:14:57', '2017-01-31 16:00:00', 5.5, 78.9, 0, 0, 7.9, 1, 5, 0, 0),
  (13, '荣耀Magic', '海思Kirin950', 4, 0, 4199, '2017-11-06 05:17:19', '2016-11-30 16:00:00', 5.09, 69.9, 0, 0, 6.8, 1, 5, 0, 0),
  (14, '荣耀V9(尊享版)', '海思Kirin960', 6, 128, 3499, '2017-11-06 05:19:20', '2016-11-30 16:00:00', 5.7, 77.5, 0, 0, 6.97, 1, 5, 0, 0),
  (15, '魅族PRO6s', '联发科helio X25', 4, 64, 2299, '2017-11-06 05:22:06', '2016-09-30 16:00:00', 5.2, 70.8, 0, 0, 7.3, 1, 9, 0, 0),
  (16, '魅族MX6', '联发科helio X20', 3, 32, 1599, '2017-11-06 05:25:22', '2016-09-30 16:00:00', 5.5, 75.2, 0, 0, 7.25, 1, 9, 0, 0),
  (17, '魅族PRO7', '联发科helio P25', 3, 64, 2499, '2017-11-06 05:27:02', '2016-09-30 16:00:00', 5.2, 70.72, 0, 0, 7.3, 1, 9, 0, 0),
  (18, '魅族PRO7plus', '联发科helio X30', 6, 128, 4080, '2017-11-06 05:28:39', '2016-09-30 16:00:00', 5.7, 77.24, 0, 0, 7.3, 1, 9, 0, 0),
  (21, '测试', '未知型号', 456, 546, 45645, '2017-11-09 04:55:08', '2017-11-15 16:00:00', 45, 456, 0, 0, 456, 2, 5, 0, 0),
  (22, '测是', '未知', 0, 0, 0, '2017-11-10 02:40:11', '2017-11-20 16:00:00', 2, 2, 0, 0, 22, 2, 18, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `t_operate`
--

CREATE TABLE `t_operate` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `remark` varchar(200) NOT NULL DEFAULT '暂无详情' COMMENT '备注',
  `admin` bigint(20) NOT NULL COMMENT '管理员',
  `user` bigint(20) NOT NULL COMMENT '用户'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作记录';

-- --------------------------------------------------------

--
-- 表的结构 `t_sale`
--

CREATE TABLE `t_sale` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(18) NOT NULL DEFAULT '无名' COMMENT '姓名',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  `edition` int(11) NOT NULL DEFAULT '0' COMMENT '文档版本',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `author` bigint(20) NOT NULL COMMENT '作者',
  `phone` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家';

--
-- 转存表中的数据 `t_sale`
--

INSERT INTO `t_sale` (`id`, `name`, `address`, `edition`, `created`, `author`, `phone`) VALUES
  (1, '黑店', 'https://www.taobao.com/', 5, '2017-11-03 04:52:04', 1, '113213123'),
  (2, '天猫', NULL, 0, '2017-11-03 05:12:33', 1, NULL),
  (3, '死神', NULL, 0, '2017-11-03 05:23:50', 1, NULL),
  (4, '4', '4', 0, '2018-01-22 06:49:07', 1, NULL),
  (5, '???', '??', 1, '2018-01-22 06:49:17', 1, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `t_sell`
--

CREATE TABLE `t_sell` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `price` float NOT NULL DEFAULT '0' COMMENT '销售价格',
  `mobile_phone` bigint(20) NOT NULL DEFAULT '0' COMMENT '手机',
  `sale` bigint(20) NOT NULL DEFAULT '0' COMMENT '商家',
  `author` bigint(20) NOT NULL DEFAULT '0' COMMENT '作者',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `edtion` int(11) NOT NULL DEFAULT '0' COMMENT '文档版本'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='销售';

--
-- 转存表中的数据 `t_sell`
--

INSERT INTO `t_sell` (`id`, `price`, `mobile_phone`, `sale`, `author`, `created`, `edtion`) VALUES
  (1, 0, 1, 1, 1, '2017-11-04 06:55:33', 0),
  (2, 1500, 1, 2, 1, '2017-11-06 08:59:55', 0);

-- --------------------------------------------------------

--
-- 表的结构 `t_storey_count`
--

CREATE TABLE `t_storey_count` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `count` int(11) NOT NULL DEFAULT '1' COMMENT '楼层数',
  `mobile_phone` bigint(20) NOT NULL COMMENT '手机'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='楼层记录';

--
-- 转存表中的数据 `t_storey_count`
--

INSERT INTO `t_storey_count` (`id`, `count`, `mobile_phone`) VALUES
  (17, 9, 1),
  (18, 1, 2),
  (19, 1, 3),
  (20, 3, 4),
  (21, 1, 5),
  (22, 1, 6),
  (23, 1, 7),
  (24, 1, 8),
  (25, 1, 9),
  (26, 1, 10),
  (27, 1, 11),
  (28, 1, 12),
  (29, 1, 13),
  (30, 1, 14),
  (31, 1, 15),
  (32, 1, 16),
  (33, 3, 17),
  (34, 1, 18),
  (37, 1, 21),
  (38, 1, 22);

-- --------------------------------------------------------

--
-- 表的结构 `t_user`
--

CREATE TABLE `t_user` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(18) NOT NULL COMMENT '姓名',
  `password` varchar(18) NOT NULL DEFAULT '123456' COMMENT '密码',
  `gender` tinyint(4) DEFAULT '1' COMMENT '1男2女',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `birthday` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生日',
  `phone` varchar(13) DEFAULT NULL COMMENT '手机',
  `email` varchar(18) DEFAULT NULL COMMENT '邮箱',
  `edition` int(11) NOT NULL DEFAULT '0' COMMENT '文档版本'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户';

--
-- 转存表中的数据 `t_user`
--

INSERT INTO `t_user` (`id`, `name`, `password`, `gender`, `created`, `birthday`, `phone`, `email`, `edition`) VALUES
  (1, '李哥', '123456', 2, '2017-11-01 09:35:00', '2017-10-30 16:00:00', NULL, NULL, 7),
  (2, '夜吹df', '123456', 1, '2017-11-01 09:35:00', '2017-10-30 16:00:00', NULL, NULL, 6),
  (3, '阿卡', '123456', 1, '2017-11-01 09:35:00', '2017-10-30 16:00:00', NULL, NULL, 2),
  (4, '卡fd', '123456', 1, '2017-11-01 09:35:21', '2017-10-31 10:18:00', NULL, NULL, 1),
  (5, '阿卡林112', '123456', 1, '2017-11-01 09:35:21', '2017-10-31 10:18:00', NULL, NULL, 1),
  (6, '小智df', '123456', 1, '2017-11-01 09:35:00', '2017-10-30 16:00:00', NULL, NULL, 3),
  (7, '阿卡林1', '123456', 1, '2017-11-01 09:35:21', '2017-10-31 10:18:00', NULL, NULL, 1),
  (8, '狗贼', '123456', 1, '2017-11-01 09:35:21', '2017-10-31 10:18:00', NULL, NULL, 1),
  (9, '涛妹', '123456', 1, '2017-11-01 09:35:00', '2017-10-30 16:00:00', NULL, NULL, 2),
  (10, '小漠fdf', '123456', 1, '2017-11-02 13:58:00', '2017-11-01 16:00:00', NULL, NULL, 1),
  (12, '阿卡林3', '123456', 1, '2017-11-02 13:59:24', '2017-11-02 13:59:24', NULL, NULL, 0),
  (13, '张三78', '123456', 1, '2017-11-05 12:08:13', '2017-11-05 12:08:13', NULL, NULL, 0),
  (14, '张三45', '123456', 1, '2017-11-05 12:08:13', '2017-11-05 12:08:13', NULL, NULL, 0),
  (15, 'a5', '123456', 1, '2017-11-05 12:08:13', '2017-11-05 12:08:13', NULL, NULL, 0),
  (16, '张三5gh', '123456', 1, '2017-11-05 12:08:13', '2017-11-05 12:08:13', NULL, NULL, 0),
  (17, '张三df', '123456', 1, '2017-11-05 12:08:13', '2017-11-05 12:08:13', NULL, NULL, 0),
  (18, '张三54', '123456', 1, '2017-11-05 12:08:13', '2017-11-05 12:08:13', NULL, NULL, 0),
  (19, '张三132', '123456', 1, '2017-11-05 12:08:13', '2017-11-05 12:08:13', NULL, NULL, 0),
  (20, '张三321', '123456', 1, '2017-11-05 12:08:13', '2017-11-05 12:08:13', NULL, NULL, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `t_admin`
--
ALTER TABLE `t_admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_collection`
--
ALTER TABLE `t_collection`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_collection_t_mobile_phone_id_fk` (`mobile_phone`),
  ADD KEY `t_collection_t_user_id_fk` (`user`);

--
-- Indexes for table `t_comment`
--
ALTER TABLE `t_comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_comment_t_mobile_phone_id_fk` (`mobile_phone`),
  ADD KEY `t_comment_t_user_id_fk` (`author`);

--
-- Indexes for table `t_login_log`
--
ALTER TABLE `t_login_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_manufacturer`
--
ALTER TABLE `t_manufacturer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_manufacturer_t_admin_id_fk` (`author`);

--
-- Indexes for table `t_mobile_phone`
--
ALTER TABLE `t_mobile_phone`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_mobile_phone_t_admin_id_fk` (`author`),
  ADD KEY `t_mobile_phone_t_manufacturer_id_fk` (`manufacturer`);

--
-- Indexes for table `t_operate`
--
ALTER TABLE `t_operate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_operate_t_admin_id_fk` (`admin`),
  ADD KEY `t_operate_t_user_id_fk` (`user`);

--
-- Indexes for table `t_sale`
--
ALTER TABLE `t_sale`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_sale_t_admin_id_fk` (`author`);

--
-- Indexes for table `t_sell`
--
ALTER TABLE `t_sell`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_sell_t_admin_id_fk` (`author`),
  ADD KEY `t_sell_t_mobile_phone_id_fk` (`mobile_phone`),
  ADD KEY `t_sell_t_sale_id_fk` (`sale`);

--
-- Indexes for table `t_storey_count`
--
ALTER TABLE `t_storey_count`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_storey_count_t_mobile_phone_id_fk` (`mobile_phone`);

--
-- Indexes for table `t_user`
--
ALTER TABLE `t_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `t_user_name_uindex` (`name`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `t_admin`
--
ALTER TABLE `t_admin`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=4;
--
-- 使用表AUTO_INCREMENT `t_collection`
--
ALTER TABLE `t_collection`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=26;
--
-- 使用表AUTO_INCREMENT `t_comment`
--
ALTER TABLE `t_comment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=14;
--
-- 使用表AUTO_INCREMENT `t_login_log`
--
ALTER TABLE `t_login_log`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=33;
--
-- 使用表AUTO_INCREMENT `t_manufacturer`
--
ALTER TABLE `t_manufacturer`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=19;
--
-- 使用表AUTO_INCREMENT `t_mobile_phone`
--
ALTER TABLE `t_mobile_phone`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=23;
--
-- 使用表AUTO_INCREMENT `t_operate`
--
ALTER TABLE `t_operate`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键';
--
-- 使用表AUTO_INCREMENT `t_sale`
--
ALTER TABLE `t_sale`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=6;
--
-- 使用表AUTO_INCREMENT `t_sell`
--
ALTER TABLE `t_sell`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `t_storey_count`
--
ALTER TABLE `t_storey_count`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=39;
--
-- 使用表AUTO_INCREMENT `t_user`
--
ALTER TABLE `t_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=21;
--
-- 限制导出的表
--

--
-- 限制表 `t_collection`
--
ALTER TABLE `t_collection`
  ADD CONSTRAINT `t_collection_t_mobile_phone_id_fk` FOREIGN KEY (`mobile_phone`) REFERENCES `t_mobile_phone` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `t_collection_t_user_id_fk` FOREIGN KEY (`user`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 限制表 `t_comment`
--
ALTER TABLE `t_comment`
  ADD CONSTRAINT `t_comment_t_mobile_phone_id_fk` FOREIGN KEY (`mobile_phone`) REFERENCES `t_mobile_phone` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `t_comment_t_user_id_fk` FOREIGN KEY (`author`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 限制表 `t_manufacturer`
--
ALTER TABLE `t_manufacturer`
  ADD CONSTRAINT `t_manufacturer_t_admin_id_fk` FOREIGN KEY (`author`) REFERENCES `t_admin` (`id`) ON UPDATE CASCADE;

--
-- 限制表 `t_mobile_phone`
--
ALTER TABLE `t_mobile_phone`
  ADD CONSTRAINT `t_mobile_phone_t_admin_id_fk` FOREIGN KEY (`author`) REFERENCES `t_admin` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `t_mobile_phone_t_manufacturer_id_fk` FOREIGN KEY (`manufacturer`) REFERENCES `t_manufacturer` (`id`) ON UPDATE CASCADE;

--
-- 限制表 `t_operate`
--
ALTER TABLE `t_operate`
  ADD CONSTRAINT `t_operate_t_admin_id_fk` FOREIGN KEY (`admin`) REFERENCES `t_admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `t_operate_t_user_id_fk` FOREIGN KEY (`user`) REFERENCES `t_user` (`id`);

--
-- 限制表 `t_sale`
--
ALTER TABLE `t_sale`
  ADD CONSTRAINT `t_sale_t_admin_id_fk` FOREIGN KEY (`author`) REFERENCES `t_admin` (`id`) ON UPDATE CASCADE;

--
-- 限制表 `t_sell`
--
ALTER TABLE `t_sell`
  ADD CONSTRAINT `t_sell_t_admin_id_fk` FOREIGN KEY (`author`) REFERENCES `t_admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `t_sell_t_mobile_phone_id_fk` FOREIGN KEY (`mobile_phone`) REFERENCES `t_mobile_phone` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `t_sell_t_sale_id_fk` FOREIGN KEY (`sale`) REFERENCES `t_sale` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 限制表 `t_storey_count`
--
ALTER TABLE `t_storey_count`
  ADD CONSTRAINT `t_storey_count_t_mobile_phone_id_fk` FOREIGN KEY (`mobile_phone`) REFERENCES `t_mobile_phone` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
