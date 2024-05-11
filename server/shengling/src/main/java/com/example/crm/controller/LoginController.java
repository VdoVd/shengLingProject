package com.example.crm.controller;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSONPObject;
import com.example.crm.Mapper.SystemUserMapper;
import com.example.crm.pojo.SystemLoginRequest;
import com.example.crm.pojo.SystemUserWithToken;
import com.example.crm.result.AllReturn;
import com.example.crm.util.jwtTool;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
public class LoginController {

    @Autowired
    SystemUserMapper systemUserMapper;

    @Autowired
    AllReturn allReturn;

    @Autowired
    SystemUserWithToken systemUserWithToken;

    @PostMapping("/login")
    public String postLogin(@RequestBody SystemLoginRequest systemLoginRequest){
        var user=systemUserMapper.queryByName(systemLoginRequest.getUsername());
        JSONObject jsonObject=new JSONObject();
        JSONPObject jsonpObject=new JSONPObject();
        jsonpObject.addParameter(user);
        System.out.println(new Gson().toJson(user));
        Gson gson=new Gson();
        String res="";
        if(user.getPassword().equals(systemLoginRequest.getPassword())){
            String token=jwtTool.getToken(systemLoginRequest.getUsername(),systemLoginRequest.getPassword());
            allReturn.setCode(200);
            allReturn.setMsg("登录成功");
            allReturn.setSuccess(true);
            allReturn.setData(user);
            systemUserWithToken.setSystemUser(user);
            systemUserWithToken.setToken(token);
            allReturn.setData(systemUserWithToken);
            System.out.println("---------------------------");
            System.out.println("Login");
            return new Gson().toJson(allReturn);
        }else {
            allReturn.setCode(400);
            allReturn.setMsg("登录失败");
            allReturn.setSuccess(false);
            allReturn.setData(new Object());
            System.out.println("---------------------------");
            System.out.println("failed to Login");
            return new Gson().toJson(allReturn);
        }

    }
}
