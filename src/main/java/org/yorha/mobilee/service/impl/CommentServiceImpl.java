package org.yorha.mobilee.service.impl;

import org.yorha.mobilee.dao.CommentDao;
import org.yorha.mobilee.entity.CommentEntity;
import org.yorha.mobilee.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("commentService")
public class CommentServiceImpl implements CommentService{
    @Autowired
    private CommentDao commentDao;

    @Override
    public CommentEntity findCommentById(long id) {
        return commentDao.findCommentById(id);
    }

    @Override
    public int deleteComment(List<String> id) {
        return commentDao.deleteComment(id);
    }

    @Override
    public long insertComment(CommentEntity commentEntity) {
        return commentDao.insertComment(commentEntity);
    }
}
