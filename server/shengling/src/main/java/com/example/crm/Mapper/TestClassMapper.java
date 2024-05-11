package com.example.crm.Mapper;

import com.example.crm.pojo.TestClass;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface TestClassMapper {

    public List<TestClass>all();

    public int add(TestClass testClass);

    public TestClass queryByName(String name);

}
