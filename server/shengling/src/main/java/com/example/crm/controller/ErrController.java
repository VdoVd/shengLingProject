package com.example.crm.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ErrController {

    @GetMapping("/404")
    public String err404()
    {
        return "404";
    }
}
