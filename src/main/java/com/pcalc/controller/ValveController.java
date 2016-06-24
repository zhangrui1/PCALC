package com.pcalc.controller;

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
     * 弁　編集
     *
     * @param valveForm 弁 更新後情報
     *
     * @return String　弁情報編集画面パス
     * */
    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public String edit(@ModelAttribute("ValveForm")ValveForm valveForm, ModelMap modelMap, HttpSession session) throws IOException {
        User user = (User) session.getAttribute("user");
        if(user == null){
            return "login";
        } else {
            //valveFormからValveに変更し,弁IDと作成日付を追加
            Valve valve = new Valve();
            valve.makeupValveByForm(valveForm);
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
