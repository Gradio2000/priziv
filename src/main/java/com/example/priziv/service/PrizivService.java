package com.example.priziv.service;

import com.example.priziv.dto.PrizivDto;
import com.example.priziv.model.Priziv;
import com.example.priziv.model.User;
import com.example.priziv.repository.PrizivRepository;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

@Component
public class PrizivService {
    private final PrizivRepository prizivRepository;

    public PrizivService(PrizivRepository prizivRepository) {
        this.prizivRepository = prizivRepository;
    }

    public void getAllPriziv(User user, Model model) {

        List<PrizivDto> prizivList = prizivRepository.findAll(Sort.by("dateArrival", "dateDeparture"))
                .stream()
                .map(PrizivDto::getInstance)
                .collect(Collectors.toList());

        int totalPeopleAmount = 0;
        int totalIssued = 0;
        int totalNotIssued = 0;

        for (PrizivDto prizivDto : prizivList) {
            totalPeopleAmount += prizivDto.getPeopleAmmount();
            totalIssued += prizivDto.getIssued();
            totalNotIssued += prizivDto.getIllList().size();
        }


        model.addAttribute("user", user);
        model.addAttribute("prizivList", prizivList);
        model.addAttribute("totalPeopleAmount", totalPeopleAmount);
        model.addAttribute("totalIssued", totalIssued);
        model.addAttribute("totalNotIssued", totalNotIssued);
    }

    public Map<String,Object> getResultMapService(int prizivId){
        Map<String,Object> result = new HashMap<>();
        List<Priziv> prizivList = prizivRepository.findAll();

        result.put("priziv", prizivList.stream()
                .filter(priziv -> Objects.equals(priziv.getPrizivId(), prizivId))
                .findFirst().orElse(null));

        int totalNotIssued = 0;
        for (Priziv priziv: prizivList){
            totalNotIssued += priziv.getIllList().size();
        }
        result.put("totalNotIssued", totalNotIssued);
        return result;
    }
}
