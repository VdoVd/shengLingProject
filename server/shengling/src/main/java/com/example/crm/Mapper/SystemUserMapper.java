package com.example.crm.Mapper;

import com.example.crm.pojo.SystemUser;
import com.example.crm.pojo.TestClass;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface SystemUserMapper {
    public SystemUser queryByName(String username);

}
