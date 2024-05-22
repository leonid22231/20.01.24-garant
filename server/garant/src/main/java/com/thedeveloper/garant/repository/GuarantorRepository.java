package com.thedeveloper.garant.repository;

import com.thedeveloper.garant.entity.GuarantorEntity;
import com.thedeveloper.garant.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GuarantorRepository extends JpaRepository<GuarantorEntity, String> {
    GuarantorEntity findGuarantorEntitiesById(String id);
    List<GuarantorEntity> findGuarantorEntitiesByUser(UserEntity user);
}
