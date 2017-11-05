package edu.xhu.mobilee.service;

import edu.xhu.mobilee.entity.CollectionEntity;

public interface CollectionService {

    CollectionEntity findCollectionById(long id);

    long insertCollection(CollectionEntity collectionEntity);
}
