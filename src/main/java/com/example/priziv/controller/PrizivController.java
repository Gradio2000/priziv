package com.example.priziv.controller;

import com.example.priziv.dto.PrizivDto;
import com.example.priziv.model.Ill;
import com.example.priziv.model.Priziv;
import com.example.priziv.model.User;
import com.example.priziv.repository.IllRepository;
import com.example.priziv.repository.PrizivRepository;
import com.example.priziv.service.PrizivService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.net.http.HttpRequest;
import java.util.List;
import java.util.Map;

@Controller
@Slf4j
public class PrizivController {
    private final PrizivRepository prizivRepository;
    private final PrizivService prizivService;
    private final IllRepository illRepository;

    public PrizivController(PrizivRepository prizivRepository, PrizivService prizivService, IllRepository illRepository) {
        this.prizivRepository = prizivRepository;
        this.prizivService = prizivService;
        this.illRepository = illRepository;
    }

    @PostMapping("/priziv")
    public String getAllPriziv(Model model, @RequestBody User user){
        log.info(new Object(){}.getClass().getEnclosingMethod().getName() + " " + user.getName());

        prizivService.getAllPriziv(user, model);
        return "priziv";
    }

    @GetMapping ("/priziv/ill")
    public String getAllIll(@RequestParam User user, Model model){
        log.info(new Object(){}.getClass().getEnclosingMethod().getName() + " " + user.getName());

        prizivService.getAllPriziv(user, model);
        return "priziv/ill";
    }

    @PostMapping("/priziv/change")
    @ResponseBody
    public Integer prizivChange(@ModelAttribute PrizivDto prizivDto,
                                @RequestParam User user){
        log.info(new Object(){}.getClass().getEnclosingMethod().getName() + " " + user.getName());

        if (prizivDto.getGetPassports() == null){
            prizivDto.setGetPassports(false);
        }
        if (prizivDto.getProcessed() == null){
            prizivDto.setProcessed(false);
        }
        if (prizivDto.getIssued() == null){
            prizivDto.setIssued(0);
        }

        prizivRepository.save(Priziv.getInstance(prizivDto));

        return prizivRepository.findAll().stream()
                .mapToInt(Priziv::getIssued)
                .sum();
    }

    @PostMapping("/addPriziv")
    public String addPriziv(@ModelAttribute PrizivDto prizivDto,
                            @RequestParam User user){
        log.info(new Object(){}.getClass().getEnclosingMethod().getName() + " " + user.getName());

        prizivDto.setProcessed(false);
        prizivDto.setGetPassports(false);
        prizivDto.setIssued(0);
        if (prizivDto.getPeopleAmmount() == null){
            prizivDto.setPeopleAmmount(0);
        }
        prizivRepository.save(Priziv.getInstance(prizivDto));
        return "redirect:/priziv";
    }

    @PostMapping("/priziv/addIlled")
    @ResponseBody
    public Priziv addIlled(@RequestParam Integer prizivId, @RequestParam String fio,
                           @RequestParam User user){
        log.info(new Object(){}.getClass().getEnclosingMethod().getName() + " " + user.getName());

        Priziv priziv = prizivRepository.findById(prizivId).orElse(null);
        assert priziv != null;
        List<Ill> illList = priziv.getIllList();
        illList.add(new Ill(fio, prizivId));
        priziv.setIllList(illList);
        return prizivRepository.save(priziv);
    }

    @GetMapping("priziv/{prizivId}")
    @ResponseBody
    public Priziv getPrizivById(@PathVariable Integer prizivId,
                                @RequestParam User user){
        log.info(new Object(){}.getClass().getEnclosingMethod().getName() + " " + user.getName());

        return prizivRepository.findById(prizivId).orElse(null);
    }

    @PostMapping("/priziv/deleteIlled")
    @ResponseBody
    public Priziv deleteIlled(@RequestParam Integer illedId,
                              @RequestParam Integer prizivId,
                              @RequestParam User user){
        log.info(new Object(){}.getClass().getEnclosingMethod().getName() + " " + user.getName());

        illRepository.deleteById(illedId);
        return prizivRepository.findById(prizivId).orElse(null);
    }

    @GetMapping("/prizivWithTotalIssued/{prizivId}")
    @ResponseBody
    public Map<String,Object> getPrizivWithTotalIssued(@PathVariable Integer prizivId,
                                                       @RequestParam User user){
        log.info(new Object(){}.getClass().getEnclosingMethod().getName() + " " + user.getName());

        return prizivService.getResultMapService(prizivId);
    }

}

