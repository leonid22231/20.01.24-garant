package com.thedeveloper.garant.repository;

import com.thedeveloper.garant.entity.CodeEntity;
import com.thedeveloper.garant.entity.UserEntity;
import com.thedeveloper.garant.entity.enums.CodeStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CodeRepository extends JpaRepository<CodeEntity, Float> {
    List<CodeEntity> findCodeEntitiesByUser(UserEntity user);
    List<CodeEntity> findCodeEntitiesByUserAndStatus(UserEntity user, CodeStatus status);
}
