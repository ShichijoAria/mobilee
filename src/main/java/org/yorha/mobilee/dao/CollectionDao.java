package org.yorha.mobilee.dao;

import org.yorha.mobilee.entity.CollectionEntity;

public interface CollectionDao {

    CollectionEntity findCollectionById(long id);

    long targetCollection(CollectionEntity collectionEntity);

    long isCollected(CollectionEntity collectionEntity);
}
