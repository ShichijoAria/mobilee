package org.yorha.mobilee.entity;

import java.sql.Timestamp;

public class CommentEntity {
    private long id;
    private String content;
    private Timestamp created;
    private int storey;
    private UserEntity author;
    private MobilePhoneEntity mobilePhone;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCreated() {
        return created;
    }

    public void setCreated(Timestamp created) {
        this.created = created;
    }

    public int getStorey() {
        return storey;
    }

    public void setStorey(int storey) {
        this.storey = storey;
    }

    public UserEntity getAuthor() {
        return author;
    }

    public void setAuthor(UserEntity author) {
        this.author = author;
    }

    public MobilePhoneEntity getMobilePhone() {
        return mobilePhone;
    }

    public void setMobilePhone(MobilePhoneEntity mobilePhone) {
        this.mobilePhone = mobilePhone;
    }
}
