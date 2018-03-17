package org.yorha.mobilee.dao;

import org.yorha.mobilee.entity.CommentEntity;

import java.util.List;

public interface CommentDao {
    CommentEntity findCommentById(long id);

    int deleteComment(List<String> id);

    long insertComment(CommentEntity commentEntity);

    List<CommentEntity> selectCommentByMobilePhoneId(long id);
}
