package com.thedeveloper.garant.service;

import com.thedeveloper.garant.entity.GuarantorEntity;
import com.thedeveloper.garant.entity.UserEntity;
import com.thedeveloper.garant.repository.GuarantorRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class GuarantorService {
    GuarantorRepository repository;
    public void save(GuarantorEntity guarantor){
        repository.save(guarantor);
    }
    public GuarantorEntity findGuarantorById(String id){
        return  repository.findGuarantorEntitiesById(id);
    }
    public List<GuarantorEntity> findGuarantorsByUser(UserEntity user){
        return  repository.findGuarantorEntitiesByUser(user);
    }
}
