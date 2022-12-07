package com.example.priziv.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "p_ill")
@Getter
@Setter
public class Ill {
    @Id
    @Column
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column
    private String fio;

    @Column( name = "priziv_id")
    private Integer prizivId;

    public Ill() {
    }

    public Ill(String fio, Integer prizivId) {
        this.fio = fio;
        this.prizivId = prizivId;
    }
}
