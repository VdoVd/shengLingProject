package com.example.crm.controller;

import com.example.crm.interfacePackage.UserLoginToken;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TaskController {

    @UserLoginToken
    @GetMapping("/driver/task/list")
    public String getTaskList(){

        return "getTaskList";
    }
}
