package edu.xhu.mobilee.dao;

import edu.xhu.mobilee.entity.SellEntity;

import java.util.List;

public interface SellDao {

    SellEntity findSellById(long id);

    int updateSellById(SellEntity sellEntity);

    int deleteSell(List<String> id);

    long insertSell(SellEntity sellEntity);
}
