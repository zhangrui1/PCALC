package com.pcalc.dao;

import com.pcalc.entity.User;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * Created by Lsr on 10/9/14.
 */
public interface UserMapper {

    /**useridからユーザを取得*/
    @Select("select * from user where userId=#{userId}")
    public User findByUserId(String userid);

    public User findByUser(User user);

    /**User 新規追加*/
    public void insertUser(User user);

    /**user情報を更新*/
    public void updateUser(User user);

    /**ユーザイメージ写真以外の情報を更新*/
    void updateUserWithoutProfile(User user);

    /**ユーザイメージ写真名を更新*/
    void updateUserProfileById(String userid, String profile);

    /**ユーザイメージ写真名を更新*/
    void updateUserProfileByUser(User user);

    public List<User> findAllUser();

    void deleteUserById(String userid);
}