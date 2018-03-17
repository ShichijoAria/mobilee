package org.yorha.mobilee.service;

import org.yorha.mobilee.entity.SaleEntity;

import java.util.List;

public interface SaleService {

    SaleEntity findSaleById(long id);

    int updateSaleById(SaleEntity saleEntity);

    int deleteSale(List<String> id);

    long insertSale(SaleEntity saleEntity);
}
