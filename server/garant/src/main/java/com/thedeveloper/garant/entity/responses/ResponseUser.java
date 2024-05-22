package com.thedeveloper.garant.entity.responses;

import com.thedeveloper.garant.entity.UserEntity;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ResponseUser extends  Response{
    UserEntity json;
}
