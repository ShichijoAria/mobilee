package edu.xhu.mobilee.entity;

public class ManufacturerEntity {
    private long id;
    private String name;
    private String address;
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

    public AdminEntity getAuthor() {
        return author;
    }

    public void setAuthor(AdminEntity author) {
        this.author = author;
    }
}
