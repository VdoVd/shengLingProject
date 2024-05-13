package com.example.crm;

import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.LineCaptcha;
import com.example.crm.Mapper.UserMapper;
import com.example.crm.pojo.User;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.StringRedisTemplate;

import java.time.Duration;
import java.util.List;

@SpringBootTest
class CrmApplicationTests {


    @Autowired
    private UserMapper userMapper;

    @Autowired
    StringRedisTemplate redisTemplate;



    Logger log=org.slf4j.LoggerFactory.getLogger(CrmApplicationTests.class);

    @Test
    public void testAll(){
        System.out.println("-----select all----");
        List<User> list=userMapper.selectList(null);
        list.forEach(System.out::println);
    }

    @Test
    public void testRedis(){

        this.redisTemplate.opsForValue().set("name","zhangsan", Duration.ofMinutes(5));

        String val = this.redisTemplate.opsForValue().get("name");

        log.info("val：{}",val);

    }

    @Test
    public void saveImg(){
        LineCaptcha lineCaptcha= CaptchaUtil.createLineCaptcha(200,100);
        lineCaptcha.write("D://captcha.png");
    }
}
