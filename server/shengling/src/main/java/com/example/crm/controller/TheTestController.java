package com.example.crm.controller;


import com.alibaba.fastjson.JSONObject;
import com.example.crm.Mapper.TestClassMapper;
import com.example.crm.interfacePackage.UserLoginToken;
import com.example.crm.pojo.TestClass;
import com.example.crm.util.jwtTool;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class TheTestController {


    @Autowired
    TestClassMapper testClass;


    public void toTest(){
        List<TestClass> all = testClass.all();
        all.forEach(e-> System.out.println(e));
    }
    @Autowired
    kk k;

    @UserLoginToken
    @GetMapping("/test")
    public String test(){

        JSONObject jsonObject=new JSONObject();

        jsonObject.put("test","ok");

        return jsonObject.toJSONString();

    }
}
