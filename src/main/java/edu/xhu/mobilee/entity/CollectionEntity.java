package edu.xhu.mobilee.entity;

import java.sql.Timestamp;

public class CollectionEntity {
    private long id;
    private MobilePhoneEntity mobilePhone;
    private UserEntity user;
    private Timestamp created;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public MobilePhoneEntity getMobilePhone() {
        return mobilePhone;
    }

    public void setMobilePhone(MobilePhoneEntity mobilePhone) {
        this.mobilePhone = mobilePhone;
    }

    public UserEntity getUser() {
        return user;
    }

    public void setUser(UserEntity user) {
        this.user = user;
    }

    public Timestamp getCreated() {
        return created;
    }

    public void setCreated(Timestamp created) {
        this.created = created;
    }
}
