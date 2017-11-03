package edu.xhu.mobilee.entity;

import java.sql.Timestamp;

public class SaleEntity {
    private long id;
    private String name;
    private String address;
    private Timestamp created;
    private int edition;
    private AdminEntity author;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Timestamp getCreated() {
        return created;
    }

    public void setCreated(Timestamp created) {
        this.created = created;
    }

    public int getEdition() {
        return edition;
    }

    public void setEdition(int edition) {
        this.edition = edition;
    }

    public AdminEntity getAuthor() {
        return author;
    }

    public void setAuthor(AdminEntity author) {
        this.author = author;
    }
}
