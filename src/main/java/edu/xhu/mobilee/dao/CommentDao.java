package edu.xhu.mobilee.dao;

import edu.xhu.mobilee.entity.CommentEntity;

import java.util.List;

public interface CommentDao {
    CommentEntity findCommentById(long id);

    int deleteComment(List<String> id);

    long insertComment(CommentEntity commentEntity);
}
