package com.example.priziv.dto;

import com.example.priziv.model.Ill;
import com.example.priziv.model.Priziv;
import lombok.Getter;
import lombok.Setter;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Getter
@Setter
public class PrizivDto {
    private Integer prizivId;
    private String commandName;
    private Boolean getPassports;
    private Boolean processed;
    private Integer issued;
    private String dateArrival;
    private String dateDeparture;
    private Integer peopleAmmount;

    private List<Ill> illList;

    public PrizivDto(Integer prizivId, String commandName, Boolean getPassports,
                     Boolean processed, Integer issued,
                     String dateArrival, String dateDeparture, Integer peopleAmmount, List<Ill>illList) {
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

    public static PrizivDto getInstance(Priziv priziv){
        return new PrizivDto(priziv.getPrizivId(), priziv.getCommandName(), priziv.getGetPassports(),
                priziv.getProcessed(), priziv.getIssued(),
                convetToString(priziv.getDateArrival()), convetToString(priziv.getDateDeparture()),
                priziv.getPeopleAmmount(), priziv.getIllList());
    }

    public static String convetToString(Date date){
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        if (date != null){
            return dateFormat.format(date);
        }
        else return "";
    }
}
