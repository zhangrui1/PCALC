package com.pcalc.controller;


import com.pcalc.entity.User;
import com.pcalc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * Created by Lsr on 11/14/14.
 */

@Controller
@RequestMapping("/")
public class IndexController {

    @Autowired
    private UserService userService;
    /**
     * ログイン後のTopページ
     *
     * @return  String 最新作成、更新した弁(１０個)
     *
     * */
    @RequestMapping(method = RequestMethod.GET)
    public String index(HttpSession session, ModelMap modelMap) throws IOException {

        User user = (User) session.getAttribute("user");
        if(user == null){
            return "login";
        } else {
            List<User> userList=userService.getAllUser();
            session.setAttribute("userList",userList);
            modelMap.addAttribute("userList", userList);

            return "user";
        }
}


    /**
     * ログアウト
     * */
    @RequestMapping(value="/logout", method=RequestMethod.GET)
    public String logout(HttpSession session){
        session.removeAttribute("user");
        return "login";
    }
}
