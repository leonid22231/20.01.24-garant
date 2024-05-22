package com.thedeveloper.garant.entity.responses;

import com.thedeveloper.garant.entity.GuarantorEntity;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ResponseGuarantor extends Response{
    private List<GuarantorEntity> json;
}
