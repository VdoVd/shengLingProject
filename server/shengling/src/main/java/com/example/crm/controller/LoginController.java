package com.example.crm.controller;
import com.example.crm.Mapper.UserMapper;
import com.example.crm.pojo.User;
import com.example.crm.pojo.req.Login;
import com.example.crm.result.AllReturn;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class LoginController {

    @Autowired
    UserMapper userMapper;

    @Autowired
    AllReturn allReturn;

    @PostMapping("/login")
    public String login(@RequestBody Login login){

        Map<String,Object> map=new HashMap<>();

        map.put("name",login.getName());
        map.put("password",login.getPass());
        List<User> list=userMapper.selectByMap(map);

        allReturn.setCode(200);
        allReturn.setMessage("登录成功");
        allReturn.setSuccess(true);
        allReturn.setData(new Gson().toJson(list.get(0)));

        System.out.println(new Gson().toJson(allReturn));

        return new Gson().toJson(allReturn);

    }
}
