package edu.xhu.mobilee.service.impl;

import edu.xhu.mobilee.dao.CollectionDao;
import edu.xhu.mobilee.entity.CollectionEntity;
import edu.xhu.mobilee.service.CollectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("collectionService")
public class CollectionServiceImpl implements CollectionService{
    @Autowired
    private CollectionDao collectionDao;

    @Override
    public CollectionEntity findCollectionById(long id) {
        return collectionDao.findCollectionById(id);
    }
}
