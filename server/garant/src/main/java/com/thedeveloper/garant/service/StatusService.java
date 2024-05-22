package com.thedeveloper.garant.service;

import com.thedeveloper.garant.entity.StatusEntity;
import com.thedeveloper.garant.repository.StatusRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class StatusService {
    StatusRepository repository;
    public void save(StatusEntity status){
        repository.save(status);
    }
}
