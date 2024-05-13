package com.example.crm.controller;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSONPObject;
import com.example.crm.Mapper.UserMapper;
import com.example.crm.pojo.User;
import com.example.crm.pojo.req.Login;
import com.example.crm.result.AllReturn;
import com.example.crm.util.jwtTool;
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

        map.put("name",login.getUsername());
        map.put("password",login.getPassword());
        List<User> list=userMapper.selectByMap(map);

        allReturn.setCode(200);
        allReturn.setMessage("登录成功");
        allReturn.setSuccess(true);
        allReturn.setData(new Gson().toJson(list.get(0)));

        System.out.println(new Gson().toJson(allReturn));

        return new Gson().toJson(allReturn);

    }
}
