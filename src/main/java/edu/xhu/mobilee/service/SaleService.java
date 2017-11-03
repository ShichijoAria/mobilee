package edu.xhu.mobilee.service;

import edu.xhu.mobilee.entity.SaleEntity;

import java.util.List;

public interface SaleService {

    SaleEntity findSaleById(long id);

    int updateSaleById(SaleEntity saleEntity);

    int deleteSale(List<String> id);

    int insertSale(SaleEntity saleEntity);
}
