package com.thedeveloper.garant.entity.enums;

public enum StatusCode implements Code{
    OK(100),
    ERROR(101);
    private int code;
    StatusCode(int code){
        this.code = code;
    }
    public int getCode(){
        return code;
    }

    @Override
    public int code() {
        return this.code;
    }
}
