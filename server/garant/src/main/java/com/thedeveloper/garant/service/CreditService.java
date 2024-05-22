package com.thedeveloper.garant.service;

import com.thedeveloper.garant.entity.CreditEntity;
import com.thedeveloper.garant.entity.UserEntity;
import com.thedeveloper.garant.entity.enums.CreditStatus;
import com.thedeveloper.garant.repository.CreditRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
@AllArgsConstructor
public class CreditService {
    CreditRepository repository;
    public CreditEntity findCreditById(String id){
        return repository.findCreditEntityById(id);
    }
    public void save(CreditEntity credit){
        repository.save(credit);
    }
    public List<CreditEntity> findAll(UserEntity borrower){
        List<CreditEntity> list = repository.findAllByBorrowerIsNot(borrower);
        List<CreditEntity> list_ = new ArrayList<>();
        for(CreditEntity credit: list){
            if(credit.getStatuses().get(credit.getStatuses().size()-1).getStatus()== CreditStatus.SEARCH){
                if(credit.getLender()==null){
                    if(Objects.equals(credit.getNumber(), borrower.getPhone())){
                        credit.setLender(borrower);
                        repository.save(credit);
                        list_.add(credit);
                    }
                    if(credit.getNumber()==null){
                        list_.add(credit);
                    }
                }else if(Objects.equals(credit.getLender().getPhone(), borrower.getPhone())){
                    list_.add(credit);
                }

            }
        }
        return list_;
    }
    public List<CreditEntity> findAllByNumber(String number){
        return repository.findAllByNumber(number);
    }
    public List<CreditEntity> findActive(UserEntity user){
        List<CreditEntity> list = new ArrayList<>();
        for(CreditEntity credit : repository.findAllByBorrower(user)){
            if(credit.getStatuses().get(credit.getStatuses().size()-1).getStatus()!=CreditStatus.CONFIRMED){
                list.add(credit);
            }
        }
        for(CreditEntity credit : repository.findAllByLender(user)){
            if(credit.getStatuses().get(credit.getStatuses().size()-1).getStatus()!=CreditStatus.CONFIRMED){
                if(credit.getStartDate()!=null){
                    list.add(credit);
                }
            }
        }
        return  list;
    }
}
