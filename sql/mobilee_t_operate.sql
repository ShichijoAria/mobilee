CREATE TABLE mobilee.t_operate
(
    id bigint(20) PRIMARY KEY NOT NULL COMMENT '主键' AUTO_INCREMENT,
    created timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    remark varchar(200) DEFAULT '暂无详情' NOT NULL COMMENT '备注',
    admin bigint(20) NOT NULL COMMENT '管理员',
    user bigint(20) NOT NULL COMMENT '用户',
    CONSTRAINT t_operate_t_admin_id_fk FOREIGN KEY (admin) REFERENCES t_admin (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT t_operate_t_user_id_fk FOREIGN KEY (user) REFERENCES t_user (id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX t_operate_t_admin_id_fk ON mobilee.t_operate (admin);
CREATE INDEX t_operate_t_user_id_fk ON mobilee.t_operate (user);