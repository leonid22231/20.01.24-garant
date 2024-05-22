package com.thedeveloper.garant.controller;

import com.thedeveloper.garant.entity.CreditEntity;
import com.thedeveloper.garant.entity.DealEntity;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class UserHistory{
    List<CreditEntity> credits;
    List<DealEntity> deals;
}
