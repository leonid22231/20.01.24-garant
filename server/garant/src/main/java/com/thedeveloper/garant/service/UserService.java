package com.thedeveloper.garant.service;

import com.thedeveloper.garant.entity.UserEntity;
import com.thedeveloper.garant.repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class UserService {
    UserRepository repository;

    public UserEntity findUserByPhone(String phone){
        return repository.findUserEntityByPhone(phone);
    }
    public UserEntity findUserByIdentityCard(String identityCard){
        return repository.findUserEntityByIdentityCard(identityCard);
    }
    public void delete(UserEntity user){
        repository.delete(user);
    }
    public void save(UserEntity user){
        repository.save(user);
    }
}
