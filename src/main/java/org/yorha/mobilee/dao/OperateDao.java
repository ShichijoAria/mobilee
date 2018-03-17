package org.yorha.mobilee.dao;

import org.yorha.mobilee.entity.OperateEntity;

public interface OperateDao {
    OperateEntity findOperateById(long id);
}
