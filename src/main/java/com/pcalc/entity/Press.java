package com.pcalc.entity;

import com.pcalc.dto.ValveForm;

import java.io.Serializable;

/**
 * Created by zhang on 2016/6/21.
 * Userエンティティ
 */

public class Press implements Serializable {


    public int pressId;
    public int valveId;
    public int pressNum;
    public double base;
    public double pressG;
    public double pressHigh;
    public double keisu;
    public double adjust;
    public double pressResult;
    public String userterm;
    public String delFlg;
    public String trkDate;
    public String updDate;


    public int getPressId() {
        return pressId;
    }

    public void setPressId(int pressId) {
        this.pressId = pressId;
    }

    public int getValveId() {
        return valveId;
    }

    public void setValveId(int valveId) {
        this.valveId = valveId;
    }

    public int getPressNum() {
        return pressNum;
    }

    public void setPressNum(int pressNum) {
        this.pressNum = pressNum;
    }

    public double getBase() {
        return base;
    }

    public void setBase(double base) {
        this.base = base;
    }

    public double getPressG() {
        return pressG;
    }

    public void setPressG(double pressG) {
        this.pressG = pressG;
    }

    public double getPressHigh() {
        return pressHigh;
    }

    public void setPressHigh(double pressHigh) {
        this.pressHigh = pressHigh;
    }

    public double getKeisu() {
        return keisu;
    }

    public void setKeisu(double keisu) {
        this.keisu = keisu;
    }

    public double getAdjust() {
        return adjust;
    }

    public void setAdjust(double adjust) {
        this.adjust = adjust;
    }

    public double getPressResult() {
        return pressResult;
    }

    public void setPressResult(double pressResult) {
        this.pressResult = pressResult;
    }

    public String getUserterm() {
        return userterm;
    }

    public void setUserterm(String userterm) {
        this.userterm = userterm;
    }

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
