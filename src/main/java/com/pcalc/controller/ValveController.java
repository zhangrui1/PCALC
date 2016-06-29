package com.pcalc.controller;

import com.pcalc.controller.utilities.StringUtil;
import com.pcalc.dao.ValveMapper;
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
@RequestMapping("/valve")
public class ValveController {


    @Autowired
    private ValveService valveService;
    @Autowired
    private PressService pressService;
    @Resource
    ValveMapper valveMapper;

    /**
     * 弁　新規登録
     *
     *
     * @return String　弁一覧画面パス
     * */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addValveKiki(@RequestParam("valdacNo")String valdacNo, @RequestParam("biko")String biko,ModelMap modelMap,HttpSession session) throws IOException {

        User user = (User) session.getAttribute("user");
        if(user == null){
            return "login";
        } else {
            //UTF-8に修正
            String tmpBiko = StringUtil.changeToUTF8(biko);
            String tmpValdacNo = StringUtil.changeToUTF8(valdacNo);

            //valve table 更新
            Valve valve=new Valve();
            valve.setBiko(tmpBiko);
            valve.setValdacNo(tmpValdacNo);
            valve.setUserterm(user.getUserid());
            valve=valveService.addValve(valve);

            session.setAttribute("valve",valve);
            return "redirect:/";
        }

    }
    /**
     * 弁　編集
     *
     *
     * @return String　弁情報編集画面パス
     * */
    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public String edit(@RequestParam("valveId")String valveId,@RequestParam("valdacNo")String valdacNo, @RequestParam("biko")String biko, ModelMap modelMap, HttpSession session) throws IOException {
        User user = (User) session.getAttribute("user");
        if(user == null){
            return "login";
        } else {
            //UTF-8に修正
            String tmpBiko = StringUtil.changeToUTF8(biko);
            String tmpValdacNo = StringUtil.changeToUTF8(valdacNo);


            //valve table 更新
            Valve valve = new Valve();
            valve.setValveId(Integer.parseInt(valveId));
            valve.setBiko(tmpBiko);
            valve.setValdacNo(tmpValdacNo);
            valve.setUserterm(user.getUserid());
            //DB更新
            valve=valveService.editValve(valve);

            modelMap.addAttribute("valve",valve);
            modelMap.addAttribute("message","更新完了");
            session.setAttribute("valve",valve);

            return "press";
        }

    }

    /**
     * valveの詳細ページへ遷移すう
     *
     *
     * */
    @RequestMapping(value = "/{valveId}", method = RequestMethod.GET)
    public String getPressByValveId(@PathVariable("valveId")String valveId, ModelMap modelMap,HttpSession session) throws IOException {
        User user = (User) session.getAttribute("user");
        if(user == null){
            return "login";
        } else {
            List<Press> pressList=pressService.getPressByValveId(valveId);
            //Press件数を取得
            Integer pressListNum=0;
            if(pressList!=null){
                pressListNum=pressList.size();
            }
            Valve valve=valveMapper.findAllValveByValveId(Integer.parseInt(valveId));
            session.setAttribute("pressListNum",pressListNum);
            session.setAttribute("pressList",pressList);
            session.setAttribute("valve",valve);
            modelMap.addAttribute("pressList", pressList);
            return "press";
        }
    }

    /**
     * 弁番号　削除
     *
     * @return String　工事リスト
     * */
    @RequestMapping(value = "/{valveId}/deleteValve", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    public  String deleteValve(@PathVariable("valveId")String valveId,HttpSession session){

        valveService.deleteValve(valveId);
        return "redirect:/";
    }
}
