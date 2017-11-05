package edu.xhu.mobilee.dao;

import edu.xhu.mobilee.entity.SaleEntity;

import java.util.HashMap;
import java.util.List;

public interface SaleDao {

    SaleEntity findSaleById(long id);

    int updateSaleById(SaleEntity saleEntity);

    int deleteSale(List<String> id);

    int insertSale(SaleEntity saleEntity);

    List<HashMap<String,Object>> selectSaleByMobilePhoneId(long id);

}
