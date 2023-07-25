package com.wso2.entity;

public class Owner {
    
    private String email;
    private String houseNo;
    private String nic;
    private String name;
    private String phoneNo;

    public Owner(){}

    public String getEmail(){
        return email;
    }

    public void setEmail(String email){
        this.email = email;
    }

    public String getHouseNo(){
        return this.houseNo;
    }

    public void setHouseNo(String houseNo){
        this.houseNo = houseNo;
    }

    public String getNic(){
        return this.nic;
    }

    public void setNic(String nic){
        this.nic = nic;
    }

    public String getName(){
        return this.name;
    }

    public void setName(String name){
        this.name = name;
    }

    public String getPhoneNo(){
        return this.phoneNo;
    }

    public void setPhoneNo(String phoneNo){
        this.phoneNo = phoneNo;
    }

}
