package com.thedeveloper.garant.service;

import com.thedeveloper.garant.entity.RequisitesEntity;
import com.thedeveloper.garant.entity.UserEntity;
import com.thedeveloper.garant.repository.RequisitesRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class RequisitesService {
    RequisitesRepository repository;

    public void save(RequisitesEntity requisites){
        repository.save(requisites);
    }
    public RequisitesEntity findReqById(String id){
        return repository.findRequisitesEntitiesById(id);
    }
    public List<RequisitesEntity> findReqByUser(UserEntity user){
        return  repository.findRequisitesEntitiesByUser(user);
    }
}
