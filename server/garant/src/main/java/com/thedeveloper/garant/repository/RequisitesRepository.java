package com.thedeveloper.garant.repository;

import com.thedeveloper.garant.entity.RequisitesEntity;
import com.thedeveloper.garant.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RequisitesRepository extends JpaRepository<RequisitesEntity, String> {
    RequisitesEntity findRequisitesEntitiesById(String id);
    List<RequisitesEntity> findRequisitesEntitiesByUser(UserEntity user);
}
