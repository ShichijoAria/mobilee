package org.yorha.mobilee.service.impl;

import org.yorha.mobilee.dao.CollectionDao;
import org.yorha.mobilee.entity.CollectionEntity;
import org.yorha.mobilee.service.CollectionService;
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

    @Override
    public long targetCollection(CollectionEntity collectionEntity) {
        return collectionDao.targetCollection(collectionEntity);
    }
}
