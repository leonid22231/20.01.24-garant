package com.thedeveloper.garant.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "requisites")
@Getter
@Setter
public class RequisitesEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    String id;
    String bankName;

    @Column(unique = true)
    String cardNumber;

    String bikNumber;
    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user", referencedColumnName = "phone")
    UserEntity user;
}
