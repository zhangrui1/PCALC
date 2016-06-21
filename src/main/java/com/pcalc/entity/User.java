package com.pcalc.entity;

import com.pcalc.dto.UserForm;

import java.io.Serializable;

/**
 * Created by zhang on 2015/6/1.
 * Userエンティティ
 */

public class User implements Serializable {


    public String userid;
    public String password;
    public String username;
    public String kengen;
    public String profile;
    public String department;

    /**
     * LocationFormからlocationに変換
     * */
    public void makeupUserByForm(UserForm userForm){
        setUserid(userForm.getUserid());
        setPassword(userForm.getPassword());
        setUsername(userForm.getUsername());
        setKengen(userForm.getKengen());
//        setProfile(userForm.getProfile());
        setDepartment(userForm.getDepartment());
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getKengen() {
        return kengen;
    }

    public void setKengen(String kengen) {
        this.kengen = kengen;
    }

    public String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        this.profile = profile;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }
}
