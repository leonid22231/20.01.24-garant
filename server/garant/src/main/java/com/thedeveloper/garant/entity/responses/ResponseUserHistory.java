package com.thedeveloper.garant.entity.responses;

import com.thedeveloper.garant.controller.UserHistory;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ResponseUserHistory extends Response{
    UserHistory json;
}
