package com.pcalc.service;

import com.pcalc.dao.PressMapper;
import com.pcalc.dao.UserMapper;
import com.pcalc.dao.ValveMapper;
import com.pcalc.dto.ValveForm;
import com.pcalc.entity.Press;
import com.pcalc.entity.User;
import com.pcalc.entity.Valve;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by Lsr on 10/9/14.
 */

@Service
public class ValveService {

    @Resource
    ValveMapper valveMapper;
    @Autowired
    private PressService pressService;

    /**ユーザIDにより　データを抽出する*/
    public List<Valve> getAllValveByUserId(String userId){
        Valve valve=new Valve();
        valve.setUserterm(userId);
        valve.setDelFlg("0");

        List<Valve> valveList = valveMapper.findAllValveByUserId(valve);
        return valveList;
    }

    /**弁新規*/
    public Valve addValve(Valve valve){

        //append Date
        Date date = new Date();
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd");
        valve.setTrkDate(sdf1.format(date));
        valve.setUpdDate(sdf1.format(date));
        valve.setDelFlg("0");

        valveMapper.insertValve(valve);
        valve=valveMapper.findAllValveByValveId(valveMapper.getLastInsertId());

        return valve;
    }

    /**弁編集*/
    public Valve editValve(Valve valve){

        //append Date
        Date date = new Date();
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd");
        valve.setUpdDate(sdf1.format(date));

        valveMapper.updateValve(valve);
        valve=valveMapper.findAllValveByValveId(valve.getValveId());

        return valve;
    }

        /**弁　削除*/
    public void deleteValve(String valveId){

        Valve valve=new Valve();
        valve.setValveId(Integer.parseInt(valveId));
        valve.setDelFlg("1");

        //append Date
        Date date = new Date();
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd");
        valve.setUpdDate(sdf1.format(date));

         //弁削除
        valveMapper.deleteValve(valve);

        //press削除
        pressService.deletePressByValveId(valveId);

    }
}
