package com.example.priziv.model;

import com.example.priziv.dto.PrizivDto;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

import static com.example.priziv.service.DateConverter.convertStringToDate;

@Entity
@Table(name = "p_priziv")
@Getter
@Setter
public class Priziv {
    @Id
    @Column(name = "priziv_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer prizivId;

    @Column(name = "command_name")
    private String commandName;

    @Column(name = "get_passports")
    private Boolean getPassports;

    @Column(name = "processed")
    private Boolean processed;

    @Column(name = "issued")
    private Integer issued;

    @Column(name = "date_arrival")
    private Date dateArrival;

    @Column(name = "date_departure")
    private Date dateDeparture;

    @Column(name = "people_ammount")
    private Integer peopleAmmount;

    @OneToMany(targetEntity = Ill.class, cascade = CascadeType.ALL,
            fetch = FetchType.EAGER, mappedBy = "prizivId")
    @OrderBy("fio")
    private List<Ill> illList;

    public Priziv() {
    }

    public Priziv(Integer prizivId, String commandName, Boolean getPassports, Boolean processed,
                  Integer issued, Date dateArrival, Date dateDeparture,
                  Integer peopleAmmount, List<Ill>illList) {
        this.prizivId = prizivId;
        this.commandName = commandName;
        this.getPassports = getPassports;
        this.processed = processed;
        this.issued = issued;
        this.dateArrival = dateArrival;
        this.dateDeparture = dateDeparture;
        this.peopleAmmount = peopleAmmount;
        this.illList = illList;
    }

    public static Priziv getInstance(PrizivDto prizivDto){
        return new Priziv(prizivDto.getPrizivId(), prizivDto.getCommandName(), prizivDto.getGetPassports(),
                 prizivDto.getProcessed(), prizivDto.getIssued(),
                convertStringToDate(prizivDto.getDateArrival()), convertStringToDate(prizivDto.getDateDeparture()),
                prizivDto.getPeopleAmmount(), prizivDto.getIllList());
    }
}
