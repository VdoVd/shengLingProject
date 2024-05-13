package com.example.crm;

import com.baomidou.mybatisplus.core.toolkit.Assert;
import com.example.crm.Mapper.UserMapper;
import com.example.crm.pojo.User;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
class CrmApplicationTests {

    @Autowired
    private UserMapper userMapper;

    @Test
    public void testAll(){
        System.out.println("-----select all----");
        List<User> list=userMapper.selectList(null);
        list.forEach(System.out::println);
    }

}
