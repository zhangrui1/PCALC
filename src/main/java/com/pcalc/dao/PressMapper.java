package com.pcalc.dao;

import com.pcalc.entity.Press;

import java.util.List;

/**
 * Created by Lsr on 10/9/14.
 */
public interface PressMapper {

    /**ユーザIDにより　データを抽出する*/
    public List<Press> findAllPressByValveId(Press press);

    /**IDからデータを取得する*/
    public Press findPressByPressId(int pressId);

    /**valveテーブルの最後のIDを取得*/
    public int getLastInsertId();

    /**valveテーブルのPageのIDを取得*/
    public int getLastpressNumByValveId(int valveId);

    /**データをテーブルに追加する*/
    public void insertPress(Press press);

    /**データを更新する*/
    public void updatePress(Press press);

    /**データを削除する*/
    public void deleteByPressId(Press press);

    /**データを削除する*/
    public void deleteByValveId(Press press);

}