package com.pcalc.controller;

import com.pcalc.dto.UserForm;
import com.pcalc.entity.User;
import com.pcalc.service.UserService;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by zhangrui on 2014/10/16.
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;
    /**
     * 会社名と発電所により、何号機取得
     *
     * @return String　ユニットリスト
     * */
    @RequestMapping(value = "/getUserByIdFormSession", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getUserByIdFormSession(@RequestParam("id")String userid,HttpSession session,ModelMap modelMap){
        List<User> userList = (List<User>) session.getAttribute("userList");

        Gson gson = new Gson();
        User user=new User();

        //userlistがない場合はDBから取得
        if(userList.isEmpty()){
            userList=userService.getAllUser();
        }

        //sessionにある場合そのまま返す、ない場合はDBから取得
        if(!(userList.isEmpty())){
            for(User tmpUser:userList){
                if(String.valueOf(tmpUser.getUserid()).equals(userid)){
                    return gson.toJson(tmpUser);
                }
            }
        }else{
            user=userService.loginByUserid(userid);

        }
        return gson.toJson(user);
    }

    /**
     * idより、ユーザを削除
     *
     * @return String　ユニットリスト
     * */
    @RequestMapping(value = "/deleteUser", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String deleteUser(@RequestParam("id")String userid,HttpSession session,ModelMap modelMap){
        List<User> userList = (List<User>) session.getAttribute("userList");

        Gson gson = new Gson();
        User user=new User();

        //DBから削除
        userService.deleteUserById(userid);

        //userlistがない場合はDBから取得
        if(userList.isEmpty()){
            userList=userService.getAllUser();
        }

        //sessionにある場合そのまま返す、ない場合はDBから取得
        if(!(userList.isEmpty())){
            for(int i=userList.size();i>0;i--){
                if(String.valueOf(userList.get(i-1).getUserid()).equals(userid)){
                    userList.remove(i-1);
                }
            }
        }

        session.setAttribute("userList",userList);
        modelMap.addAttribute("userList", userList);


        return "";
    }
    /**
     * 全部のユーザ情報取得
     *
     * @return String　ユーザ情報編集画面
     * */
    @RequestMapping(value = "/getAllUser", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    public String getAllUser(HttpSession session,
                                 ModelMap modelMap){
        List<User> userList=userService.getAllUser();
        session.setAttribute("userList",userList);
        modelMap.addAttribute("userList", userList);

        return "/user";

    }

    /**
     * User　新規追加、編集
     *
     * @return String　ユニットリスト
     * */
    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    public String add(@ModelAttribute("UserForm")UserForm userForm,HttpSession session,ModelMap modelMap){
        List<User> userList = (List<User>) session.getAttribute("userList");

        User user=new User();
        user.makeupUserByForm(userForm);

        //user masterがない場合はDBから取得
        if(userList.isEmpty()){
            userList=userService.getAllUser();
        }
        //すでに存在するかどうかチェック
        boolean isHave=false;
        for(User tmpUser:userList){
            if(String.valueOf(user.getUserid()).equals(tmpUser.getUserid())){
                isHave=true;
                break;
            }
        }

        //存在ない場合、DBに追加
        if(isHave){
            userService.deleteUserById(user.getUserid());
            user=userService.addUser(user);
        }else{
            user=userService.addUser(user);
        }

        modelMap.addAttribute("message","更新しました。");

        return "redirect:/user/getAllUser";
    }
}
