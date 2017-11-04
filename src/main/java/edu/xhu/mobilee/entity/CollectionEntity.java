package edu.xhu.mobilee.entity;

//收藏
public class CollectionEntity {
    private long id;
    private ManufacturerEntity manufacturerEntity;
    private UserEntity userEntity;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public ManufacturerEntity getManufacturerEntity() {
        return manufacturerEntity;
    }

    public void setManufacturerEntity(ManufacturerEntity manufacturerEntity) {
        this.manufacturerEntity = manufacturerEntity;
    }

    public UserEntity getUserEntity() {
        return userEntity;
    }

    public void setUserEntity(UserEntity userEntity) {
        this.userEntity = userEntity;
    }
}
