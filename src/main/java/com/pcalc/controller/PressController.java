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
import java.math.BigDecimal;
import java.util.DoubleSummaryStatistics;
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
            press.setPressHigh(1);
            //pressNum 設定
            List<Press> pressList=pressService.getPressByValveId(valveId);
            if(pressList.size()>0){
                press.setPressNum(pressMapper.getLastpressNumByValveId(Integer.parseInt(valveId))+1);
                Press tmpPress=new Press();
                tmpPress=pressService.getLastPressByValveId(valveId);
                if(tmpPress!=null){
                    press.setKeisu(tmpPress.getKeisu());
                }
            }else{
                press.setPressNum(1);
            }

            press=pressService.addPress(press);//新規空データ追加した
            //valveIDのすべてのPressを取得する
            pressList=pressService.getPressByValveId(valveId);
            //Press件数を取得
            Integer pressListNum=0;
            if(pressList!=null){
                pressListNum=pressList.size();
            }


            Gson gson=new Gson();
            System.out.println("press="+gson.toJson(press));

            return ""+gson.toJson(pressList);
        }


    }

    /**
     * Press　新規登録
     *
     * @return String　弁一覧画面パス
     * */
    @RequestMapping(value = "/calculatePress", method = RequestMethod.GET)
    @ResponseBody
    public String calculatePress(@RequestParam("pressId")String pressId,@RequestParam("base")String base,@RequestParam("pressG")String pressG,@RequestParam("pressHigh")String pressHigh,@RequestParam("keisu")String keisu,@RequestParam("adjust")String adjust,HttpSession session){
        User user = (User) session.getAttribute("user");
        if(user == null){
            return "login";
        } else {
            //変数
            double Doubase=Double.parseDouble(base);
            double DouPressG=Double.parseDouble(pressG);
            double DouHigh=Double.parseDouble(pressHigh);
            double DouKeisu=Double.parseDouble(keisu);
            double DouAdjust=Double.parseDouble(adjust);

            Press press=new Press();
            press.setPressId(Integer.parseInt(pressId));
            press.setUserterm(user.getUserid());
            press.setBase(Doubase);
            press.setPressG(DouPressG);
            press.setPressHigh(DouHigh);
            press.setKeisu(DouKeisu);
            press.setAdjust(DouAdjust);

            double result=0;
            if(DouKeisu>0){
                result=Doubase+((DouPressG-0.00863*DouHigh)/DouKeisu);
            }
            //元データをBigDecimal型にする
            BigDecimal bd = new BigDecimal(result);
            BigDecimal bd3 = bd.setScale(2, BigDecimal.ROUND_DOWN);  //切り捨て　小数第3位
            result=bd3.doubleValue();
            press.setPressResult(result);

            //DB更新する
            pressService.editPress(press);
            return ""+result;
        }
    }

    /**
     * Press　逆計算
     *
     * @return String　弁一覧画面パス
     * */
    @RequestMapping(value = "/reCalculatePress", method = RequestMethod.GET)
    @ResponseBody
    public String reCalculatePress(@RequestParam("pressId")String pressId,@RequestParam("base")String base,@RequestParam("pressResult")String pressResult,@RequestParam("pressHigh")String pressHigh,@RequestParam("keisu")String keisu,@RequestParam("adjust")String adjust,HttpSession session){
        User user = (User) session.getAttribute("user");
        if(user == null){
            return "login";
        } else {
            //変数
            double Doubase=Double.parseDouble(base);
            double DouPressResult=Double.parseDouble(pressResult);
            double DouHigh=Double.parseDouble(pressHigh);
            double DouKeisu=Double.parseDouble(keisu);
            double DouAdjust=Double.parseDouble(adjust);

            Press press=new Press();
            press.setPressId(Integer.parseInt(pressId));
            press.setUserterm(user.getUserid());
            press.setBase(Doubase);
            press.setPressResult(DouPressResult);
            press.setPressHigh(DouHigh);
            press.setKeisu(DouKeisu);
            press.setAdjust(DouAdjust);

            double pressG=0;
            pressG=((DouPressResult-Doubase)*DouKeisu)+(0.00863*DouHigh);
            //元データをBigDecimal型にする
            BigDecimal bd = new BigDecimal(pressG);
            BigDecimal bd3 = bd.setScale(2, BigDecimal.ROUND_HALF_UP);  //四捨五入する　小数第3位
            pressG=bd3.doubleValue();

            press.setPressG(pressG);

            //DB更新する
            pressService.editPress(press);
            return ""+pressG;
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
