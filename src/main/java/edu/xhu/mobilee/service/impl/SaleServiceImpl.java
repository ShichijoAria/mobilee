package edu.xhu.mobilee.service.impl;

import edu.xhu.mobilee.dao.SaleDao;
import edu.xhu.mobilee.entity.SaleEntity;
import edu.xhu.mobilee.service.SaleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("saleService")
public class SaleServiceImpl implements SaleService{

    @Autowired
    private SaleDao saleDao;

    @Override
    public SaleEntity findSaleById(long id) {
        return saleDao.findSaleById(id);
    }

    @Override
    public int updateSaleById(SaleEntity saleEntity) {
        return saleDao.updateSaleById(saleEntity);
    }

    @Override
    public int deleteSale(List<String> id) {
        return saleDao.deleteSale(id);
    }

    @Override
    public long insertSale(SaleEntity saleEntity) {
        return saleDao.insertSale(saleEntity);
    }
}
