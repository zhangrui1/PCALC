package com.pcalc.service;

import com.pcalc.dao.PressMapper;
import com.pcalc.entity.Press;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by Lsr on 10/9/14.
 */

@Service
public class PressService {

    @Resource
    PressMapper pressMapper;

    /**valveIDにより　データを抽出する*/
    public List<Press> getPressByValveId(String valveId){
        Press press=new Press();
        press.setValveId(Integer.parseInt(valveId));
        press.setDelFlg("0");

        List<Press> pressList = pressMapper.findAllPressByValveId(press);
        return pressList;
    }

    /**valveIDにより　データを抽出する*/
    public Press getPressByPressId(String pressId){
        Press press=new Press();
        press = pressMapper.findPressByPressId(Integer.parseInt(pressId));
        return press;
    }

    /**弁新規*/
    public Press addPress(Press press){

        //append Date
        Date date = new Date();
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd");
        press.setTrkDate(sdf1.format(date));
        press.setUpdDate(sdf1.format(date));
        press.setDelFlg("0");

        pressMapper.insertPress(press);
        press=pressMapper.findPressByPressId(pressMapper.getLastInsertId());

        return press;
    }

    /**pressIdにより　削除*/
    public void deletePressByPressId(String pressId){

        Press press=new Press();
        press.setPressId(Integer.parseInt(pressId));
        press.setDelFlg("1");

        //append Date
        Date date = new Date();
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd");
        press.setUpdDate(sdf1.format(date));
        pressMapper.deleteByPressId(press);

    }

    /**valveIdにより　削除*/
    public void deletePressByValveId(String valveId){

        Press press=new Press();
        press.setValveId(Integer.parseInt(valveId));
        press.setDelFlg("1");

        //append Date
        Date date = new Date();
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd");
        press.setUpdDate(sdf1.format(date));
        pressMapper.deleteByValveId(press);

    }
}
