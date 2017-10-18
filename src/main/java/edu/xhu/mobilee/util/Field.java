package edu.xhu.mobilee.util;

import java.util.EnumMap;
import java.util.HashMap;
import java.util.Map;

//抽象出表单的域，方便template.jsp的渲染
public class Field {

    public static Map<String,Object> textField(String value,String type){
        Map<String, Object> map= new HashMap<String, Object>();
        map.put("value",value);
        map.put("type",type);
        return map;
    }

    public static Map<String,Object> optField(String value, String type, EnumMap enumMap){
        Map<String, Object> map= new HashMap<String, Object>();
        map.put("value",value);
        map.put("type",type);
        map.put("opt", GenderEnum.getMap());
        return map;
    }

}
