package com.example.crm.pojo.task;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@AllArgsConstructor
@Data
@NoArgsConstructor
@Component
public class TaskListItem {
    String actualArrivalTime;
    String actualDepartureTime;
    String created;
    String driverId;
    boolean enablePickUp;
    String endAddress;
    Integer endAgencyId;
    String id;
    String planArrivalTime;
    String planDepartureTime;
    String startAddress;
    String startAgencyId;
    String startHandover;
    String status;
    String transportTaskId;
}
