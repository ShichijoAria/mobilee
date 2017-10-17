package edu.xhu.mobilee.util;

import java.util.HashMap;
import java.util.Map;

//抽象出表单的域，方便template.jsp的渲染
public class Field {

    public static Map<String,Map<String,String>> textField(String value,String fieldType){
        Map<String,String> type=new HashMap<String,String>();
        Map<String,String> enumeration=new HashMap<String,String>();
        type.put("type",fieldType);
        //enumeration.put("name",GenderEnum);
        Map<String, Map<String, String>> map= new HashMap<String, Map<String, String>>();
        map.put(value,type);
        map.put("enum",enumeration);
        return map;
    }

}
