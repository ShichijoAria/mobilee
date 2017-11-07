package edu.xhu.mobilee.dao;

import edu.xhu.mobilee.entity.CollectionEntity;

public interface CollectionDao {

    CollectionEntity findCollectionById(long id);

    long targetCollection(CollectionEntity collectionEntity);

    long isCollected(CollectionEntity collectionEntity);
}
