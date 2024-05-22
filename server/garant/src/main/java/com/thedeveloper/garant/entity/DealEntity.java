package com.thedeveloper.garant.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Entity
@Table(name = "deals")
@Getter
@Setter
public class DealEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    String id;

    String name;
    String description;
    int duration;
    double price;
    Date startDate;
    Date endDate;
    String type;
    String file;
    String code;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "seller", referencedColumnName = "phone")
    UserEntity seller;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "buyer", referencedColumnName = "phone")
    UserEntity buyer;
}
