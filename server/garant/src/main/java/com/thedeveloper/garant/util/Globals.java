package com.thedeveloper.garant.util;

import com.thedeveloper.garant.controller.UserHistory;
import com.thedeveloper.garant.entity.CreditEntity;
import com.thedeveloper.garant.entity.GuarantorEntity;
import com.thedeveloper.garant.entity.RequisitesEntity;
import com.thedeveloper.garant.entity.UserEntity;
import com.thedeveloper.garant.entity.enums.CreditStatus;
import com.thedeveloper.garant.entity.responses.*;
import com.thedeveloper.garant.entity.enums.StatusCode;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.Random;

public class Globals {
    public static String getStatusFromString(CreditStatus status){
        switch (status){
            case CREATED: return "Создан";
            case SEARCH: return "Поиск заемщика";
            case CONFIRMATION: return "Заемщик найден";
            default: return status.name();
        }
    }
    public static ResponseEntity<?> Request(StatusCode code, String text){
        Response response1 = new Response();
        response1.setStatusCode(code.getCode());
        response1.setMessage(text);
        return  new ResponseEntity<>(response1, HttpStatus.OK);
    }
    public static ResponseEntity<?> Request(StatusCode code, String text, UserHistory history){
        ResponseUserHistory response1 = new ResponseUserHistory();
        response1.setStatusCode(code.getCode());
        response1.setMessage(text);
        response1.setJson(history);
        return  new ResponseEntity<>(response1, HttpStatus.OK);
    }
    public static ResponseEntity<?> Request(StatusCode code, UserEntity user){
        ResponseUser response1 = new ResponseUser();
        response1.setStatusCode(code.getCode());
        response1.setMessage("");
        response1.setJson(user);
        return  new ResponseEntity<>(response1, HttpStatus.OK);
    }
    public static ResponseEntity<?> Request(StatusCode code, List<RequisitesEntity> requisitesEntities){
        ResponseReqList response1 = new ResponseReqList();
        response1.setStatusCode(code.getCode());
        response1.setMessage("");
        response1.setJson(requisitesEntities);
        return  new ResponseEntity<>(response1, HttpStatus.OK);
    }
    public static String codeGenerator(){
        Random random = new Random();
        return  String.format("%04d", random.nextInt(10000));
    }
    public static ResponseEntity<?> Request(StatusCode code, String text, String moreText){
        ResponseMoreText response = new ResponseMoreText();
        response.setStatusCode(code.getCode());
        response.setMessage(text);
        response.setJson(moreText);
        return  new ResponseEntity<>(response, HttpStatus.OK);
    }
    public static ResponseEntity<?> Request(StatusCode code, String text, List<CreditEntity> list){
        ResponseCreditList response = new ResponseCreditList();
        response.setStatusCode(code.getCode());
        response.setMessage(text);
        response.setJson(list);
        return  new ResponseEntity<>(response, HttpStatus.OK);
    }
}
