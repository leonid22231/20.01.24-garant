package com.thedeveloper.garant.service;

import com.thedeveloper.garant.entity.DealEntity;
import com.thedeveloper.garant.entity.UserEntity;
import com.thedeveloper.garant.repository.DealsRepository;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@AllArgsConstructor
public class DealsService {
    DealsRepository repository;
    public void save(DealEntity deal){
        repository.save(deal);
    }
    public DealEntity findDealByCode(String code){
        return  repository.findDealEntitiesByCode(code);
    }
    public DealEntity findDealById(String id){
        return repository.findDealEntitiesById(id);
    }
    public List<DealEntity> findDealByBuyer(UserEntity user){
        return  repository.findDealEntitiesByBuyer(user);
    }
    public List<DealEntity> findDealBySeller(UserEntity user){
        return  repository.findDealEntitiesBySeller(user);
    }
    public List<DealEntity> findActive(UserEntity user){
        List<DealEntity> list = new ArrayList<>();
        list.addAll(findDealByBuyer(user));
        list.addAll(findDealBySeller(user));
        return  list;
    }
}
