package edu.xhu.mobilee.service;

import edu.xhu.mobilee.entity.SellEntity;

import java.util.List;

public interface SellService {

    SellEntity findSellById(long id);

    int updateSellById(SellEntity sellEntity);

    int deleteSell(List<String> id);

    long insertSell(SellEntity sellEntity);

}
