package com.pcalc.dao;

import com.pcalc.entity.Valve;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * Created by Lsr on 10/9/14.
 */
public interface ValveMapper {

    /**ユーザIDにより　データを抽出する*/
    public List<Valve> findAllValveByUserId(Valve valve);

    /**valveテーブルの最後のIDを取得*/
    public int getLastInsertId();

    /**IDからデータを取得する*/
    public Valve findAllValveByValveId(int valveId);

    /**データをテーブルに追加する*/
    public void insertValve(Valve valve);

    /**データを更新する*/
    public void updateValve(Valve valve);

    /**データを削除する*/
    public void deleteValve(Valve valve);

}