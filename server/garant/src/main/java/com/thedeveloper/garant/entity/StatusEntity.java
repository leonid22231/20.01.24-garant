package com.thedeveloper.garant.entity;

import com.thedeveloper.garant.entity.enums.CreditStatus;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Entity
@Table(name = "statuses")
@Getter
@Setter
public class StatusEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @CollectionTable(name = "status", joinColumns = @JoinColumn(name = "id"))
    @Enumerated(EnumType.STRING)
    CreditStatus status;
    Date date;
}
