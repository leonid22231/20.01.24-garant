package com.thedeveloper.garant.repository;

import com.thedeveloper.garant.entity.DealEntity;
import com.thedeveloper.garant.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DealsRepository extends JpaRepository<DealEntity, String> {
    DealEntity findDealEntitiesByCode(String code);
    DealEntity findDealEntitiesById(String id);
    List<DealEntity> findDealEntitiesByBuyer(UserEntity user);
    List<DealEntity> findDealEntitiesBySeller(UserEntity user);
}
