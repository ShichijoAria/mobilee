package org.yorha.mobilee.service.impl;

import org.yorha.mobilee.dao.SellDao;
import org.yorha.mobilee.entity.SellEntity;
import org.yorha.mobilee.service.SellService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("sellService")
public class SellServiceImpl implements SellService{
    @Autowired
    private SellDao sellDao;


    @Override
    public SellEntity findSellById(long id) {
        return sellDao.findSellById(id);
    }

    @Override
    public int updateSellById(SellEntity sellEntity) {
        return sellDao.updateSellById(sellEntity);
    }

    @Override
    public int deleteSell(List<String> id) {
        return sellDao.deleteSell(id);
    }

    @Override
    public long insertSell(SellEntity sellEntity) {
        return sellDao.insertSell(sellEntity);
    }
}
