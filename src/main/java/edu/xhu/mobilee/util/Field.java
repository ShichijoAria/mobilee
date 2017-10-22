package edu.xhu.mobilee.util;

import edu.xhu.mobilee.entity.UserEntity;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.*;

//抽象出表单的域，方便template.jsp的渲染
public class Field {

    public static Map<String,Object> textField(String entity){
        Map<String,Object> render=new LinkedHashMap<String, Object>();
        try {
            File file = new File(Field.class.getResource("/interface/"+entity+".xml").getPath());
            SAXReader reader = new SAXReader();
            Document doc = reader.read(file);
            Element root = doc.getRootElement();
            Element renderele = root.element("render");
            Element properties=root.element("properties");
            Element property;
            Map<String,Object> show=new LinkedHashMap<String, Object>();
            Map<String,Object> head=new LinkedHashMap<String, Object>();
            render.put("title",renderele.attributeValue("title"));
            render.put("extra",renderele.attributeValue("extra"));
            render.put("icon",renderele.attributeValue("icon"));
            render.put("namespace",renderele.attributeValue("namespace"));

            for (Iterator ite = properties.elementIterator(); ite.hasNext(); ) {
                property = (Element) ite.next();
                if(property.attributeValue("show").equals("true")){
                    Map<String,Object> map=new LinkedHashMap<String,Object>();
                    String key=property.attributeValue("key");
                    String value=property.attributeValue("value");
                    String type=property.attributeValue("type");
                    String range=property.attributeValue("range");
                    String edit=property.attributeValue("edit");
                    map.put("value",value);
                    map.put("type",type);
                    map.put("range",range);
                    map.put("edit",edit);
                    if(type.equals("select")){
                        Map<String,String> opt=new HashMap<String,String>();
                        if(property.element("foreign")==null) {
                            Element enums;
                            for (Iterator it = property.elementIterator("enum"); it.hasNext(); ) {
                                enums=(Element) it.next();
                                opt.put(enums.attributeValue("key"),enums.attributeValue("value"));
                            }
                        }
                        map.put("opt", opt);
                    }
                    show.put(key,map);
                    if(property.attributeValue("head").equals("true")){
                        head.put(key,map);
                    }
                }
            }
            render.put("head",head);
            render.put("show",show);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return render;
    }

    public static String getHql(String entity,HttpServletRequest request){
        String hqlFoot="";
        String hqlHead="SELECT new "+entity+"Entity(";
        String hqlBody=") FROM "+entity+"Entity ";
        entity=entity.toLowerCase();
        hqlBody+=entity+" ";
        try {
            File file = new File(Field.class.getResource("/interface/"+entity+".xml").getPath());
            SAXReader reader = new SAXReader();
            Document doc = null;
            doc = reader.read(file);
            Element root = doc.getRootElement();
            Element properties=root.element("properties");
            Element property;
            for (Iterator ite = properties.elementIterator(); ite.hasNext(); ) {
                property = (Element) ite.next();
                if (property.attributeValue("head").equals("true")) {
                    String key = property.attributeValue("key");
                    String type = property.attributeValue("type");
                    String range = property.attributeValue("range");
                    String param;
                    hqlHead+=entity+"."+key+",";
                    if (type.equals("text")){
                        param = request.getParameter(key + "Search");
                        if(param!=null) {
                            param = "'%" + param + "%'";
                            hqlFoot += "where " + entity + "." + key + " like " + param + " ";
                        }
                    } else if (type.equals("select")) {
                        param = request.getParameter(key + "Search");
                        if(param!=null)
                            hqlFoot += "where " + entity + "." + key + "= "+param+" ";
                    } else {
                        if (range.equals("false")) {
                            param = request.getParameter(key + "Search");
                            if (type.equals("number")) {
                                /*预留*/
                            } else if (type.equals("datetime")) {
                                param="to_timestamp(''"+param+",'yyyy-mm-dd hh24:mi:ss:ff')";
                            }
                            if(param!=null)
                                hqlFoot += "where " + entity + "." + key + "= "+param+" ";
                        } else {
                            if (type.equals("number")) {
                                param = request.getParameter(key + "UpSearch");
                                if(param!=null)
                                    hqlFoot += "where " + entity + "." + key + "<= "+param+" ";
                                param = request.getParameter(key + "LowSearch");
                                if(param!=null)
                                    hqlFoot += "where " + entity + "." + key + ">= "+param+" ";
                            } else if (type.equals("datetime")) {
                                param = request.getParameter(key + "UpSearch");
                                if(param!=null) {
                                    param = "to_timestamp('" + param + "','yyyy-mm-dd hh24:mi:ss:ff')";
                                    hqlFoot += "where " + entity + "." + key + "<= " + param + " ";
                                }
                                param = request.getParameter(key + "LowSearch");
                                if(param!=null) {
                                    param = "to_timestamp('" + param + "','yyyy-mm-dd hh24:mi:ss:ff')";
                                    hqlFoot += "where " + entity + "." + key + ">= " + param + " ";
                                }
                            }
                        }
                    }
                }
            }
        } catch (DocumentException e) {
            e.printStackTrace();
        }
        return hqlHead.substring(0,hqlHead.length()-1)+hqlBody+hqlFoot.replaceAll("^and","where");
    }

    public static Object getObject(Object obj,HttpServletRequest request){
        Class entity=obj.getClass();
        String name=obj.getClass().getName();
        name=name.substring(23,name.length()-6).toLowerCase();
        File file = new File(Field.class.getResource("/interface/"+name+".xml").getPath());
        SAXReader reader = new SAXReader();
        Document doc = null;
        try {
            doc = reader.read(file);
            Element root = doc.getRootElement();
            Element properties=root.element("properties");
            Element property;
            for (Iterator ite = properties.elementIterator(); ite.hasNext(); ) {
                property = (Element) ite.next();
                if (property.attributeValue("edit").equals("true")) {
                    String key=property.attributeValue("key");
                    String value=request.getParameter(key);
                    String clazz=property.attributeValue("class");
                    if(value!=null){
                        try {
                            Method setAttr =entity.getDeclaredMethod("set"+captureName(key),getType(clazz));
                            try {
                                setAttr.invoke(obj,value);
                            } catch (IllegalAccessException e) {
                                e.printStackTrace();
                            } catch (InvocationTargetException e) {
                                e.printStackTrace();
                            }
                        } catch (NoSuchMethodException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        } catch (DocumentException e) {
            e.printStackTrace();
        }

        System.out.println(entity);
        System.out.println(name);
        return obj;
    }

    //首字母大写
    public static String captureName(String name) {
        char[] cs=name.toCharArray();
        cs[0]-=32;
        return String.valueOf(cs);
    }

    public static Class getType(String name){
        if(name.equals("String"))
            return String.class;
        else if(name.equals("long"))
            return long.class;
        else if(name.equals("Date"))
            return Date.class;
        return null;
    }
}
