package edu.xhu.mobilee.entity;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "T_PHONE", schema = "C##MOBILEE", catalog = "")
public class PhoneEntity {
    private long id;
    private String name;
    private String cpu;
    private Long memory;
    private Long storage;
    private String picture;
    private Timestamp listingTime;
    private Double size;
    private Long length;
    private Long pixel;
    private Long cameraPixel;

    @Id
    @Column(name = "ID")
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "NAME")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "CPU")
    public String getCpu() {
        return cpu;
    }

    public void setCpu(String cpu) {
        this.cpu = cpu;
    }

    @Basic
    @Column(name = "MEMORY")
    public Long getMemory() {
        return memory;
    }

    public void setMemory(Long memory) {
        this.memory = memory;
    }

    @Basic
    @Column(name = "STORAGE")
    public Long getStorage() {
        return storage;
    }

    public void setStorage(Long storage) {
        this.storage = storage;
    }

    @Basic
    @Column(name = "PICTURE")
    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    @Basic
    @Column(name = "LISTING_TIME")
    public Timestamp getListingTime() {
        return listingTime;
    }

    public void setListingTime(Timestamp listingTime) {
        this.listingTime = listingTime;
    }

    @Basic
    @Column(name = "SIZE")
    public Double getSize() {
        return size;
    }

    public void setSize(Double size) {
        this.size = size;
    }

    @Basic
    @Column(name = "LENGTH")
    public Long getLength() {
        return length;
    }

    public void setLength(Long length) {
        this.length = length;
    }

    @Basic
    @Column(name = "PIXEL")
    public Long getPixel() {
        return pixel;
    }

    public void setPixel(Long pixel) {
        this.pixel = pixel;
    }

    @Basic
    @Column(name = "CAMERA_PIXEL")
    public Long getCameraPixel() {
        return cameraPixel;
    }

    public void setCameraPixel(Long cameraPixel) {
        this.cameraPixel = cameraPixel;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PhoneEntity that = (PhoneEntity) o;

        if (id != that.id) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (cpu != null ? !cpu.equals(that.cpu) : that.cpu != null) return false;
        if (memory != null ? !memory.equals(that.memory) : that.memory != null) return false;
        if (storage != null ? !storage.equals(that.storage) : that.storage != null) return false;
        if (picture != null ? !picture.equals(that.picture) : that.picture != null) return false;
        if (listingTime != null ? !listingTime.equals(that.listingTime) : that.listingTime != null) return false;
        if (size != null ? !size.equals(that.size) : that.size != null) return false;
        if (length != null ? !length.equals(that.length) : that.length != null) return false;
        if (pixel != null ? !pixel.equals(that.pixel) : that.pixel != null) return false;
        if (cameraPixel != null ? !cameraPixel.equals(that.cameraPixel) : that.cameraPixel != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (cpu != null ? cpu.hashCode() : 0);
        result = 31 * result + (memory != null ? memory.hashCode() : 0);
        result = 31 * result + (storage != null ? storage.hashCode() : 0);
        result = 31 * result + (picture != null ? picture.hashCode() : 0);
        result = 31 * result + (listingTime != null ? listingTime.hashCode() : 0);
        result = 31 * result + (size != null ? size.hashCode() : 0);
        result = 31 * result + (length != null ? length.hashCode() : 0);
        result = 31 * result + (pixel != null ? pixel.hashCode() : 0);
        result = 31 * result + (cameraPixel != null ? cameraPixel.hashCode() : 0);
        return result;
    }
}
