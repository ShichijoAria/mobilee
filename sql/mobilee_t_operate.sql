CREATE TABLE mobilee.t_operate
(
    id bigint(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    created timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    remark varchar(200) DEFAULT '暂无详情' NOT NULL,
    admin bigint(20) NOT NULL,
    user bigint(20) NOT NULL,
    CONSTRAINT t_operate_t_admin_id_fk FOREIGN KEY (admin) REFERENCES t_admin (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT t_operate_t_user_id_fk FOREIGN KEY (user) REFERENCES t_user (id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX t_operate_t_admin_id_fk ON mobilee.t_operate (admin);
CREATE INDEX t_operate_t_user_id_fk ON mobilee.t_operate (user);