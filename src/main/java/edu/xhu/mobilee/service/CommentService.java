package edu.xhu.mobilee.service;

import edu.xhu.mobilee.entity.CommentEntity;

import java.util.List;

public interface CommentService {
    CommentEntity findCommentById(long id);

    int deleteComment(List<String> id);

    long insertComment(CommentEntity commentEntity);
}
