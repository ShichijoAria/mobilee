package edu.xhu.mobilee.service.impl;

import edu.xhu.mobilee.dao.OperateDao;
import edu.xhu.mobilee.entity.OperateEntity;
import edu.xhu.mobilee.service.OperateService;
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
