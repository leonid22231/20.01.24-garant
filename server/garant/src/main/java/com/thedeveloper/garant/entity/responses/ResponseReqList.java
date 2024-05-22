package com.thedeveloper.garant.entity.responses;

import com.thedeveloper.garant.entity.CreditEntity;
import com.thedeveloper.garant.entity.RequisitesEntity;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ResponseReqList extends  Response{
    List<RequisitesEntity> json;
}
