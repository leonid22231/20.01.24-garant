package com.thedeveloper.garant.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "guarantors")
@Getter
@Setter
public class GuarantorEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    String id;
    private String name;
    private String surname;
    private String patronymic;
    private String identityCard;
    @Column(unique = true)
    private String phone;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user", referencedColumnName = "phone")
    private UserEntity user;
}
