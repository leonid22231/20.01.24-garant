package com.thedeveloper.garant.entity.responses;

import com.thedeveloper.garant.entity.CreditEntity;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ResponseCreditList extends Response{
    List<CreditEntity> json;
}
