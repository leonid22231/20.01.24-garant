package com.thedeveloper.garant.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.thedeveloper.garant.entity.enums.CreditStatus;
import com.thedeveloper.garant.util.Globals;
import jakarta.persistence.*;
import jdk.jfr.Enabled;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "credits")
@Getter
@Setter
public class CreditEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    String id;

    private float value;

    private double percent;
    private String number;
    private int duration;

    private Date startDate;

    @JsonProperty()
    String getLastStatus(){
        return Globals.getStatusFromString(statuses.get(statuses.size()-1).getStatus());
    }
    @JsonProperty
    Date getLastStatusTime(){
        return statuses.get(statuses.size()-1).getDate();
    }
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "requisites", referencedColumnName = "cardNumber")
    private RequisitesEntity requisites;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "borrower", referencedColumnName = "phone")
    private UserEntity borrower;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lender", referencedColumnName = "phone")
    private UserEntity lender;

    @OneToOne
    @JoinColumn(name = "guarant", referencedColumnName = "phone")
    private GuarantorEntity guarant;

    @OneToOne
    @JoinColumn(name = "doc", referencedColumnName = "id")
    private DocumentEntity doc;
    @JsonIgnore
    @ManyToMany
    private List<StatusEntity> statuses = new ArrayList<>();
}
