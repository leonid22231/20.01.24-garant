package com.thedeveloper.garant.repository;

import com.thedeveloper.garant.entity.CreditEntity;
import com.thedeveloper.garant.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CreditRepository extends JpaRepository<CreditEntity, String> {
    CreditEntity findCreditEntityById(String id);
    List<CreditEntity> findAllByBorrowerIsNot(UserEntity borrower);
    List<CreditEntity> findAllByBorrower(UserEntity user);
    List<CreditEntity> findAllByLender(UserEntity user);
    List<CreditEntity> findAllByNumber(String number);
}
