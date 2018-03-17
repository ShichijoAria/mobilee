package org.yorha.mobilee.entity;

import java.sql.Timestamp;

public class MobilePhoneEntity {
    private long id;
    private String name;
    private String cpu;
    private int memory;
    private int storage;
    private float price;
    private Timestamp created;
    private Timestamp listTime;
    private float size;
    private float length;
    private float width;
    private float height;
    private int pixel;
    private int cameraPixel;
    private int edition;
    private AdminEntity author;
    private ManufacturerEntity manufacturer;

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

    public String getCpu() {
        return cpu;
    }

    public void setCpu(String cpu) {
        this.cpu = cpu;
    }

    public int getMemory() {
        return memory;
    }

    public void setMemory(int memory) {
        this.memory = memory;
    }

    public int getStorage() {
        return storage;
    }

    public void setStorage(int storage) {
        this.storage = storage;
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

    public Timestamp getListTime() {
        return listTime;
    }

    public void setListTime(Timestamp listTime) {
        this.listTime = listTime;
    }

    public float getSize() {
        return size;
    }

    public void setSize(float size) {
        this.size = size;
    }

    public float getLength() {
        return length;
    }

    public void setLength(float length) {
        this.length = length;
    }

    public float getWidth() {
        return width;
    }

    public void setWidth(float width) {
        this.width = width;
    }

    public float getHeight() {
        return height;
    }

    public void setHeight(float height) {
        this.height = height;
    }

    public int getPixel() {
        return pixel;
    }

    public void setPixel(int pixel) {
        this.pixel = pixel;
    }

    public int getCameraPixel() {
        return cameraPixel;
    }

    public void setCameraPixel(int cameraPixel) {
        this.cameraPixel = cameraPixel;
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

    public ManufacturerEntity getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(ManufacturerEntity manufacturer) {
        this.manufacturer = manufacturer;
    }
}
