package com.example.crm.controller;

import com.example.crm.interfacePackage.UserLoginToken;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HomeController {

    @GetMapping("/home")
    @UserLoginToken
    public String home(){
        return "home";
    }

}
