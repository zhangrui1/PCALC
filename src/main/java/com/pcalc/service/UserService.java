package com.pcalc.service;

import com.pcalc.dao.UserMapper;
import com.pcalc.entity.User;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Lsr on 10/9/14.
 */

@Service
public class UserService {

    @Resource
    UserMapper userMapper;

    /**全てのユーザを抽出する*/
    public List<User> getAllUser(){
        List<User> userList = userMapper.findAllUser();
        return userList;
    }

    /**Userを新規*/
    public User addUser(User user){
        userMapper.insertUser(user);
        return user;
    }

    /**Userを削除する*/
    public String deleteUserById(String id){
        userMapper.deleteUserById(id);
        return "";
    }

    /**useridからユーザを取得*/
    public User loginByUserid(String userid) {

        User user = userMapper.findByUserId(userid);

        return user;
    }

    /**userid,passwordからユーザを取得*/
    public User getUserByUseridAndPassword(String userid,String password){
        User userTem=new User();
        userTem.setUserid(userid);
        userTem.setPassword(password);

        User user = userMapper.findByUser(userTem);

        if(user!=null){
            return user;
        } else {
            return null;
        }
    }

    /**useridからユーザを取得*/
    public User getUserProfile(String userid) {

        User user = userMapper.findByUserId(userid);

        if(user != null){
            return user;
        } else {
            return null;
        }

    }

    /**user情報を更新*/
    public User updateUser(String userId,String username,String password,String department) {
        User newUser=new User();
        newUser.setUserid(userId);
        newUser.setPassword(password);
        newUser.setDepartment(department);
        newUser.setUsername(username);
        newUser.setKengen("6");

        userMapper.updateUser(newUser);
        User user = userMapper.findByUserId(userId);
        if(user != null){
            return user;
        } else {
            return null;
        }

    }

    /**ユーザイメージ写真以外の情報を更新*/
    public void updateUserWithoutProfile(User user){
        userMapper.updateUserWithoutProfile(user);
    }

    /**ユーザイメージ写真名を更新*/
    public void updateUserProfileById(String userid, String profile) {
        userMapper.updateUserProfileById(userid,profile);
    }

    /**ユーザイメージ写真名を更新*/
    public void updateUserProfileByUser(User user) {
        userMapper.updateUserProfileByUser(user);
    }
}
