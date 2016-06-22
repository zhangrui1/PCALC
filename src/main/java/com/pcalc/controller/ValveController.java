package com.pcalc.controller;

import com.pcalc.dto.ValveForm;
import com.pcalc.entity.User;
import com.pcalc.entity.Valve;
import com.pcalc.service.ValveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

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
    /**
     * 弁　新規登録
     *
     * @param valveForm 新規弁情報
     *
     * @return String　弁一覧画面パス
     * */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addValveKiki(@ModelAttribute("ValveForm")ValveForm valveForm, ModelMap modelMap,HttpSession session) throws IOException {

        User user = (User) session.getAttribute("user");
        if(user == null){
            return "login";
        } else {
            //valve table 更新
            Valve valve=new Valve();
            valve.makeupValveByForm(valveForm);
            valve.setUserterm(user.getUserid());
            valve=valveService.addValve(valve);

            session.setAttribute("valve",valve);
            return "redirect:/";
        }

    }

    /**
     * 弁番号　削除
     *
     * @return String　工事リスト
     * */
    @RequestMapping(value = "/deleteValve", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public  String deleteValve(@RequestParam("valveId")String valveId,ModelMap modelMap,HttpSession session){

        valveService.deleteValve(valveId);
        return "";
    }
}
