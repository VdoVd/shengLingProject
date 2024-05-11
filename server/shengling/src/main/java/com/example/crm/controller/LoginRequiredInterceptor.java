package com.example.crm.controller;

import com.alibaba.fastjson.JSON;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.example.crm.interfacePackage.UserLoginToken;
import com.example.crm.util.jwtTool;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

@Component
public class LoginRequiredInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,Object handler) throws Exception{

        String token = request.getHeader("token");

        System.out.println("token:"+token);

        if(handler instanceof HandlerMethod){

            HandlerMethod handlerMethod=(HandlerMethod) handler;

            Method method = handlerMethod.getMethod();

            System.out.println("method"+method.toString());

            if(method.isAnnotationPresent(UserLoginToken.class)){

                UserLoginToken userLoginToken = method.getAnnotation(UserLoginToken.class);

                System.out.println("userLogin:"+userLoginToken.required());
                if(userLoginToken.required()){
                    System.out.println("token is empty");
                    if (token==null){
                        returnJson(response,"token为空,请重新登录");
                        throw new RuntimeException("token为空,请重新登录");
                    }
                    System.out.println("token is not empty");
                    boolean result= jwtTool.verify(token);
                    if(result){
                        System.out.println("token is true");
                        return true;
                    }else {
                        System.out.println("token is false");
                        returnJson(response,"token错误");
                        return false;
                    }
                }
            }
        }
        return false;
    }

    private void returnJson(HttpServletResponse response, String message) throws Exception{
        PrintWriter writer = null;
        // 注意点1：这边返回配置为josn格式
        response.setContentType("application/json;charset=UTF-8");
        try {
            Map<String, Object> result = new HashMap<>();
            result.put("state", "false");
            result.put("msg", message);
            writer = response.getWriter();
            // 注意点2，这样要用fastjson转换一下后，返回的前端才是格式化后的json格式
            writer.print(JSON.toJSONString(result));
        } catch (IOException e) {
        } finally {
            if (writer != null)
                writer.close();
        }
    }


}
