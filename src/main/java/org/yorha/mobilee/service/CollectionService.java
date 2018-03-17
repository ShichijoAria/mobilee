package org.yorha.mobilee.service;

import org.yorha.mobilee.entity.CollectionEntity;

public interface CollectionService {

    CollectionEntity findCollectionById(long id);

    long targetCollection(CollectionEntity collectionEntity);
}
