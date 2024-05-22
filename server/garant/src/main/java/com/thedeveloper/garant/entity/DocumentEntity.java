package com.thedeveloper.garant.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "documents")
@Getter
@Setter
public class DocumentEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    String id;
    private String fileName;
}
