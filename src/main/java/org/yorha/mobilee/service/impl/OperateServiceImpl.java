package org.yorha.mobilee.service.impl;

import org.yorha.mobilee.dao.OperateDao;
import org.yorha.mobilee.entity.OperateEntity;
import org.yorha.mobilee.service.OperateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("operateService")
public class OperateServiceImpl implements OperateService{
    @Autowired
    private OperateDao operateDao;

    @Override
    public OperateEntity findOperateById(long id) {
        return operateDao.findOperateById(id);
    }
}
