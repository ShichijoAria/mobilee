package edu.xhu.mobilee.util;

import org.springframework.core.convert.converter.Converter;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateConvert implements Converter<String, Timestamp> {

    @Override
    public Timestamp convert(String stringDate) {
        DateFormat dateFormat;
        if(stringDate.length()>10)
            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm");
        else
            dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        Date date = new Date();
        try {
            date=dateFormat.parse(stringDate);
            return new Timestamp(date.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
        }
        try {
            return null;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
