package com.pcalc.controller;

import com.google.gson.Gson;
import com.pcalc.dao.PressMapper;
import com.pcalc.dto.ValveForm;
import com.pcalc.entity.Press;
import com.pcalc.entity.User;
import com.pcalc.entity.Valve;
import com.pcalc.service.PressService;
import com.pcalc.service.ValveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Created by 維瑞 on 2016/06/21.
 */
@Controller
@RequestMapping("/press")
public class PressController {


    @Autowired
    private PressService pressService;

    @Resource
    PressMapper pressMapper;
    /**
     * Press　新規登録
     *
     * @return String　弁一覧画面パス
     * */
    @RequestMapping(value = "/addPress", method = RequestMethod.GET)
    @ResponseBody
    public String addPress(@RequestParam("valveId")String valveId,HttpSession session){
        User user = (User) session.getAttribute("user");
        if(user == null){
            return "login";
        } else {
            Press press=new Press();
            press.setValveId(Integer.parseInt(valveId));
            press.setUserterm(user.getUserid());
            //pressNum 設定
            List<Press> pressList=pressService.getPressByValveId(valveId);
            if(pressList.size()>0){
                press.setPressNum(pressMapper.getLastpressNumByValveId(Integer.parseInt(valveId))+1);
            }else{
                press.setPressNum(1);
            }

            press=pressService.addPress(press);//新規空データ追加した

            Gson gson=new Gson();
            System.out.println("press="+gson.toJson(press));

            return ""+gson.toJson(press);
        }


    }

    /**
     * 圧力　削除
     *
     * @return String　工事リスト
     * */
    @RequestMapping(value = "/deletePressByPressId", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public  String deletePressByPressId(@RequestParam("pressId")String pressId,ModelMap modelMap,HttpSession session){

        pressService.deletePressByPressId(pressId);
        return "";
    }
}
