package edu.xhu.mobilee.service.impl;

import edu.xhu.mobilee.dao.CommentDao;
import edu.xhu.mobilee.entity.CommentEntity;
import edu.xhu.mobilee.service.CommentService;
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
