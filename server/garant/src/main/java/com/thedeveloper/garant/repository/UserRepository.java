package com.thedeveloper.garant.repository;

import com.thedeveloper.garant.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, String> {
    UserEntity findUserEntityByPhone(String phone);
    UserEntity findUserEntityByIdentityCard(String identityCard);
}
