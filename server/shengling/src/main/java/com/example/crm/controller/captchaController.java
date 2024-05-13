package com.example.crm.controller;

import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.LineCaptcha;
import com.example.crm.Mapper.UserMapper;
import com.example.crm.pojo.User;
import com.example.crm.pojo.req.Register;
import com.example.crm.result.AllReturn;
import com.google.gson.Gson;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.net.http.HttpResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class captchaController {

    @Autowired
    RedisTemplate redisTemplate;

    @Autowired
    AllReturn allReturn;

    @Autowired
    UserMapper userMapper;
    /*
     * 验证码
     * */
    @GetMapping("/captcha")
    public void createCaptcha(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 定义图形验证码的长和宽
        LineCaptcha lineCaptcha = CaptchaUtil.createLineCaptcha(200, 100);
        // 图形验证码写出，可以写出到文件，也可以写出到流
        lineCaptcha.write(response.getOutputStream());

        System.out.println("验证码：" + lineCaptcha.getCode());

        redisTemplate.opsForValue().set(request.getParameter("phone"),lineCaptcha.getCode());

        System.out.println("redis 存储:"+redisTemplate.opsForValue().get(request.getParameter("phone")));
        // 关闭流
        response.getOutputStream().close();
    }

    @GetMapping("/register/exist")
    public String exist(@RequestBody Register register) throws IOException {

        Map<String, Object> map = new HashMap<>();

        map.put("name", register.getPhone());

        List<User> list = userMapper.selectByMap(map);

        if (list.size()!= 0) {
            allReturn.setCode(200);
            allReturn.setMessage("已注册过");
            allReturn.setSuccess(true);
            allReturn.setData(new Gson().toJson(list.get(0)));
            System.out.println(new Gson().toJson(allReturn));
            return new Gson().toJson(allReturn);
        }else {
            allReturn.setSuccess(false);
            allReturn.setMessage("未注册");
            allReturn.setCode(400);
            allReturn.setData(false);
            return new Gson().toJson(allReturn);
        }

    }

    @PostMapping("/captcha/register")
    public String register(@RequestBody Register register) throws IOException {

        String code = register.getCode();
        String phone = register.getPhone();
        String redisCode = (String) redisTemplate.opsForValue().get(phone);

        if (code.toLowerCase().equals(redisCode.toLowerCase())){

                allReturn.setSuccess(true);
                allReturn.setMessage("验证码正确");
                allReturn.setCode(200);
                allReturn.setData(true);
                return new Gson().toJson(allReturn);

        }
        else {

            allReturn.setSuccess(false);
            allReturn.setMessage("验证码错误");
            allReturn.setCode(400);
            allReturn.setData(false);
            return new Gson().toJson(allReturn);

        }
    }
}
