create table t_admin
(
    id bigint auto_increment
        primary key,
    name varchar(18) default '阿卡林' null,
    password varchar(18) default '123456' null
)
    comment '管理员'
;

create table t_collection
(
    id bigint auto_increment
        primary key,
    mobile_phone bigint not null,
    user bigint not null,
    created timestamp default CURRENT_TIMESTAMP not null
)
;

create index t_collection_t_mobile_phone_id_fk
    on t_collection (mobile_phone)
;

create index t_collection_t_user_id_fk
    on t_collection (user)
;

create table t_comment
(
    id bigint auto_increment
        primary key,
    content varchar(200) default '' not null,
    created timestamp default CURRENT_TIMESTAMP not null,
    author bigint default '0' not null,
    mobile_phone bigint default '0' not null,
    storey int default '0' not null
)
;

create index t_comment_t_mobile_phone_id_fk
    on t_comment (mobile_phone)
;

create index t_comment_t_user_id_fk
    on t_comment (author)
;

create table t_manufacturer
(
    id bigint auto_increment
        primary key,
    name varchar(18) default '无名' not null,
    address varchar(200) null,
    author bigint not null,
    created timestamp default CURRENT_TIMESTAMP not null,
    edition int default '0' not null,
    constraint t_manufacturer_t_admin_id_fk
    foreign key (author) references t_admin (id)
        on update cascade
)
    comment '制造商'
;

create index t_manufacturer_t_admin_id_fk
    on t_manufacturer (author)
;

create table t_mobile_phone
(
    id bigint auto_increment
        primary key,
    name varchar(18) default '山寨机' not null,
    cpu varchar(18) default '未知型号' not null,
    memory int default '0' not null,
    storage int default '0' not null,
    price float default '0' not null,
    created timestamp default CURRENT_TIMESTAMP not null,
    list_time timestamp default CURRENT_TIMESTAMP not null,
    size float default '4' not null,
    width float default '1' null,
    pixel int default '0' null,
    camera_pixel int default '0' null,
    height float default '1' null,
    author bigint not null,
    manufacturer bigint not null,
    length int default '0' not null,
    edition int default '0' not null,
    constraint t_mobile_phone_t_admin_id_fk
    foreign key (author) references t_admin (id)
        on update cascade,
    constraint t_mobile_phone_t_manufacturer_id_fk
    foreign key (manufacturer) references t_manufacturer (id)
        on update cascade
)
;

create index t_mobile_phone_t_admin_id_fk
    on t_mobile_phone (author)
;

create index t_mobile_phone_t_manufacturer_id_fk
    on t_mobile_phone (manufacturer)
;

alter table t_collection
    add constraint t_collection_t_mobile_phone_id_fk
foreign key (mobile_phone) references t_mobile_phone (id)
    on update cascade on delete cascade
;

alter table t_comment
    add constraint t_comment_t_mobile_phone_id_fk
foreign key (mobile_phone) references t_mobile_phone (id)
    on update cascade on delete cascade
;

create table t_operate
(
    id bigint auto_increment
        primary key,
    created timestamp default CURRENT_TIMESTAMP not null,
    remark varchar(200) default '暂无详情' not null,
    admin bigint not null,
    user bigint not null,
    constraint t_operate_t_admin_id_fk
    foreign key (admin) references t_admin (id)
        on update cascade on delete cascade
)
;

create index t_operate_t_admin_id_fk
    on t_operate (admin)
;

create index t_operate_t_user_id_fk
    on t_operate (user)
;

create table t_sale
(
    id bigint auto_increment
        primary key,
    name varchar(18) default '无名' not null,
    address varchar(200) null,
    edition int default '0' not null,
    created timestamp default CURRENT_TIMESTAMP not null,
    author bigint not null,
    constraint t_sale_t_admin_id_fk
    foreign key (author) references t_admin (id)
        on update cascade
)
;

create index t_sale_t_admin_id_fk
    on t_sale (author)
;

create table t_sell
(
    id bigint auto_increment
        primary key,
    price float default '0' not null,
    mobile_phone bigint default '0' not null,
    sale bigint default '0' not null,
    author bigint default '0' not null,
    created timestamp default CURRENT_TIMESTAMP null,
    edtion int default '0' not null,
    constraint t_sell_t_mobile_phone_id_fk
    foreign key (mobile_phone) references t_mobile_phone (id)
        on update cascade on delete cascade,
    constraint t_sell_t_sale_id_fk
    foreign key (sale) references t_sale (id)
        on update cascade on delete cascade,
    constraint t_sell_t_admin_id_fk
    foreign key (author) references t_admin (id)
        on update cascade on delete cascade
)
;

create index t_sell_t_admin_id_fk
    on t_sell (author)
;

create index t_sell_t_mobile_phone_id_fk
    on t_sell (mobile_phone)
;

create index t_sell_t_sale_id_fk
    on t_sell (sale)
;

create table t_storey_count
(
    id bigint auto_increment
        primary key,
    count int default '0' not null,
    mobile_phone bigint not null,
    constraint t_storey_count_t_mobile_phone_id_fk
    foreign key (mobile_phone) references t_mobile_phone (id)
        on update cascade on delete cascade
)
;

create index t_storey_count_t_mobile_phone_id_fk
    on t_storey_count (mobile_phone)
;

create table t_user
(
    id bigint not null
        primary key,
    name varchar(18) default '阿卡林' not null,
    password varchar(18) default '123456' not null,
    gender tinyint default '1' null comment '1男2女',
    created timestamp default CURRENT_TIMESTAMP not null,
    birthday timestamp default CURRENT_TIMESTAMP not null,
    phone varchar(13) null,
    email varchar(18) null,
    edition int default '0' not null
)
;

alter table t_collection
    add constraint t_collection_t_user_id_fk
foreign key (user) references t_user (id)
    on update cascade on delete cascade
;

alter table t_comment
    add constraint t_comment_t_user_id_fk
foreign key (author) references t_user (id)
    on update cascade on delete cascade
;

alter table t_operate
    add constraint t_operate_t_user_id_fk
foreign key (user) references t_user (id)
    on update cascade on delete cascade
;

create procedure p_get_page (IN `_fields` varchar(2000), IN `_tables` varchar(1000), IN `_where` varchar(2000), IN `_order_by` varchar(200), IN `_page_index` int, IN `_page_size` int, OUT `_total_count` int, OUT `_page_count` int)
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
    end;

create procedure p_insert_comment (IN `_content` varchar(200), IN `_mobile_phone` bigint, IN `_author` bigint)
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
    END;

create procedure p_insert_mobile_phone (IN `_name` varchar(18), IN `_cpu` varchar(18), IN `_memory` int, IN `_storage` int, IN `_price` float, IN `_list_time` timestamp, IN `_size` float, IN `_width` float, IN `_height` float, IN `_pixel` int, IN `_camera_pixel` int, IN `_author` int(20), IN `_manufacturer` bigint)
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


    END;

