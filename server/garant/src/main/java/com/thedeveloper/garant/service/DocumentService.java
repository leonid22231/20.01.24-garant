package com.thedeveloper.garant.service;

import com.thedeveloper.garant.entity.DocumentEntity;
import com.thedeveloper.garant.repository.DocumentRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class DocumentService {
    DocumentRepository repository;
    public void save(DocumentEntity document){
        repository.save(document);
    }
}
