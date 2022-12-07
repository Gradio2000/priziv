package com.example.priziv.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;


public class DateConverter {

    public static Date convertStringToDate(String str){
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date date;
        try {
            if (str.equals("")){
                date = null;
            }else {
                date = formatter.parse(str);
            }

        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        return date;
    }
}
