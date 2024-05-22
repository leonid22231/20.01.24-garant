package com.thedeveloper.garant.entity.responses;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Response {
    private int statusCode;
    private String message;
}
