package com.example.crm.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class SystemUser {
    Long user_id;
    Long dept_id;//
    String user_name;
    String nick_name;//
    String user_type;
    String email;//
    String phonenumber;//
    String sex;//
    String avatar;//
    String password;//
    String status;
    String del_flag;//
    String login_ip;//
    Date login_date;//
    String create_by;///
    Date create_time;//
    String update_by;
    Date update_time;
    String remark;//

}
