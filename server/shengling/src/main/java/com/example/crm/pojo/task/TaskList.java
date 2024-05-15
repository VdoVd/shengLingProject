package com.example.crm.pojo.task;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Data
@Component
@AllArgsConstructor
@NoArgsConstructor
public class TaskList {
    Integer counts;
    TaskListItem[] items;
    String page;
    Integer pageSize;
    Integer pages;
}
