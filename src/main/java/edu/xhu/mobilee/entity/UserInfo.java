package edu.xhu.mobilee.entity;

import javax.persistence.Column;
import javax.persistence.Entity;  
import javax.persistence.Id;  
import javax.persistence.Table;  

@Entity  
@Table(name = "user_info", catalog = "mobilee")
public class UserInfo implements java.io.Serializable {  

    private static final long serialVersionUID = 5127853981202454040L;  
    private int id;  
    private String name;  
    private Integer age;  
    private String telephone;  
  
    public UserInfo() {  
    }  
  
    public UserInfo(int id, String name) {  
        this.id = id;  
        this.name = name;  
    }  
  
    public UserInfo(int id, String name, Integer age, String telephone) {  
        this.id = id;  
        this.name = name;  
        this.age = age;  
        this.telephone = telephone;  
    }  
  
    @Id  
    @Column(name = "id", unique = true, nullable = false)  
    public int getId() {  
        return this.id;  
    }  
  
    public void setId(int id) {  
        this.id = id;  
    }  
  
    @Column(name = "name", nullable = false)  
    public String getName() {  
        return this.name;  
    }  
  
    public void setName(String name) {  
        this.name = name;  
    }  
  
    @Column(name = "age")  
    public Integer getAge() {  
        return this.age;  
    }  
  
    public void setAge(Integer age) {  
        this.age = age;  
    }  
  
    @Column(name = "telephone")  
    public String getTelephone() {  
        return this.telephone;  
    }  
  
    public void setTelephone(String telephone) {  
        this.telephone = telephone;  
    }  
  
}  