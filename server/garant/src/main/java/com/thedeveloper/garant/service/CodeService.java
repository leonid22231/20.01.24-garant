package com.thedeveloper.garant.service;

import com.thedeveloper.garant.entity.CodeEntity;
import com.thedeveloper.garant.entity.UserEntity;
import com.thedeveloper.garant.entity.enums.CodeStatus;
import com.thedeveloper.garant.repository.CodeRepository;
import com.thedeveloper.garant.util.Globals;
import com.thedeveloper.garant.util.MessageService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.Date;
import java.util.List;

@Service
@AllArgsConstructor
public class CodeService {
    CodeRepository repository;
    public void sendRegisterCode(UserEntity user){
        List<CodeEntity> existCode = repository.findCodeEntitiesByUser(user);
        if(existCode.size()>0){
            for(CodeEntity code : existCode){
                if(code.getStatus().equals(CodeStatus.WAIT)){
                    code.setStatus(CodeStatus.CLOSE);
                    code.setEndDate(new Date());
                    repository.save(code);
                }
            }
        }
        CodeEntity codeEntity = new CodeEntity();
        codeEntity.setUser(user);
        codeEntity.setCode(Globals.codeGenerator());
        codeEntity.setSendDate(new Date());
        codeEntity.setStatus(CodeStatus.WAIT);
        repository.save(codeEntity);
        try {
            MessageService.sendMessageRegisterCode(user.getPhone(), codeEntity.getCode());
        } catch (IOException | URISyntaxException | InterruptedException e) {
            throw new RuntimeException(e);
        }
    }
    public List<CodeEntity> findCodesByUser(UserEntity user){
        return repository.findCodeEntitiesByUser(user);
    }
    public void delete(CodeEntity codeEntity){
        repository.delete(codeEntity);
    }
    public CodeEntity currentCodeUser(UserEntity user){
        return repository.findCodeEntitiesByUserAndStatus(user, CodeStatus.WAIT).get(0);
    }
    public void save(CodeEntity codeEntity){
        repository.save(codeEntity);
    }
}
