package edu.xhu.mobilee.entity;

import java.sql.Timestamp;

public class SellEntity {
    private long id;
    private float price;
    private Timestamp created;
    private AdminEntity author;
    private MobilePhoneEntity mobilePhone;
    private SaleEntity sale;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public Timestamp getCreated() {
        return created;
    }

    public void setCreated(Timestamp created) {
        this.created = created;
    }

    public AdminEntity getAuthor() {
        return author;
    }

    public void setAuthor(AdminEntity author) {
        this.author = author;
    }

    public MobilePhoneEntity getMobilePhone() {
        return mobilePhone;
    }

    public void setMobilePhone(MobilePhoneEntity mobilePhone) {
        this.mobilePhone = mobilePhone;
    }

    public SaleEntity getSale() {
        return sale;
    }

    public void setSale(SaleEntity sale) {
        this.sale = sale;
    }
}
