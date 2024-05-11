package com.example.crm.result;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Component
public class AllReturn {
    private int code;
    private String msg;
    private Object data;
    private boolean success;
}
