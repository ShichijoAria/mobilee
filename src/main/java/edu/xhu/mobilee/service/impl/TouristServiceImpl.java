package edu.xhu.mobilee.service.impl;

import edu.xhu.mobilee.dao.*;
import edu.xhu.mobilee.entity.CollectionEntity;
import edu.xhu.mobilee.entity.MobilePhoneEntity;
import edu.xhu.mobilee.entity.UserEntity;
import edu.xhu.mobilee.service.TouristService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service("touristService")
public class TouristServiceImpl implements TouristService{
    @Autowired
    private MobilePhoneDao mobilePhoneDao;
    @Autowired
    private CommentDao commentDao;
    @Autowired
    private SaleDao saleDao;
    @Autowired
    private CollectionDao collectionDao;
    @Autowired
    private UserDao userDao;

    @Transactional
    @Override
    public Map<String, Object> getMobilePhoneDetail(long id,long touristId) {
        Map<String,Object> map=new HashMap<String, Object>();
        CollectionEntity collectionEntity=new CollectionEntity();
        UserEntity userEntity=new UserEntity();
        MobilePhoneEntity mobilePhoneEntity=new MobilePhoneEntity();
        userEntity.setId(touristId);
        mobilePhoneEntity.setId(id);
        collectionEntity.setUser(userEntity);
        collectionEntity.setMobilePhone(mobilePhoneEntity);
        map.put("isCollected",collectionDao.isCollected(collectionEntity));
        map.put("mobilePhone",mobilePhoneDao.findMobilePhoneForTouristById(id));
        map.put("comment",commentDao.selectCommentByMobilePhoneId(id));
        map.put("sale",saleDao.selectSaleByMobilePhoneId(id));
        return map;
    }

    @Transactional
    @Override
    public Map<String, Object> getMobilePhoneIndex() {
        Map<String,Object> map=new HashMap<String, Object>();
        map.put("mobilePhone",mobilePhoneDao.selectMobile());
        map.put("newMobilePhone",mobilePhoneDao.selectNewMobilePhone());
        return map;
    }

    @Override
    public long register(UserEntity userEntity) {
        return userDao.insertUser(userEntity);
    }

    @Override
    public UserEntity userLogin(UserEntity userEntity) {
        return userDao.userLogin(userEntity);
    }
}
