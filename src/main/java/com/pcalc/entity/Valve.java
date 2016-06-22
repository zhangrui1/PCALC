package com.pcalc.entity;

import com.pcalc.dto.ValveForm;

import java.io.Serializable;

/**
 * Created by zhang on 2016/6/21.
 * Userエンティティ
 */

public class Valve implements Serializable {


    public int valveId;
    public String valdacNo;
    public String userterm;
    public String biko;
    public String delFlg;
    public String trkDate;
    public String updDate;


    /**
     * LocationFormからlocationに変換
     * */
    public void makeupValveByForm(ValveForm valveForm){
        setValveId(valveForm.getValveId());
        setValdacNo(valveForm.getValdacNo());
        setBiko(valveForm.getBiko());
        setUserterm(valveForm.getUserterm());
        setUpdDate(valveForm.getUpdDate());
    }
    public int getValveId() {
        return valveId;
    }

    public void setValveId(int valveId) {
        this.valveId = valveId;
    }

    public String getValdacNo() {
        return valdacNo;
    }

    public void setValdacNo(String valdacNo) {
        this.valdacNo = valdacNo;
    }

    public String getUserterm() {
        return userterm;
    }

    public void setUserterm(String userterm) {
        this.userterm = userterm;
    }

    public String getBiko() {
        return biko;
    }

    public void setBiko(String biko) { this.biko = biko;}

    public String getDelFlg() {
        return delFlg;
    }

    public void setDelFlg(String delFlg) {
        this.delFlg = delFlg;
    }

    public String getTrkDate() {
        return trkDate;
    }

    public void setTrkDate(String trkDate) {
        this.trkDate = trkDate;
    }

    public String getUpdDate() {
        return updDate;
    }

    public void setUpdDate(String updDate) {
        this.updDate = updDate;
    }

}
