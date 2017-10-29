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
            Element renderEle = root.element("render");
            Element properties=root.element("properties");
            Element grant=root.element("grant");
            Element property;
            Map<String,Object> show=new LinkedHashMap<String, Object>();
            Map<String,Object> head=new LinkedHashMap<String, Object>();

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
            render.put("title",renderEle.attributeValue("title"));
            render.put("extra",renderEle.attributeValue("extra"));
            render.put("icon",renderEle.attributeValue("icon"));
            render.put("namespace",renderEle.attributeValue("namespace"));
            render.put("head",head);
            render.put("show",show);
            render.put("update",grant.element("update").getStringValue());
            render.put("insert",grant.element("insert").getStringValue());
            render.put("delete",grant.element("delete").getStringValue());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return render;
    }

    public static Map<String,Object> getParamMap(String entity,HttpServletRequest request){
        Map<String, Object> paramMap=new HashMap<String,Object>();
        String fields="";
        String where="";
        String orderBy="id";
        String orderByParam= request.getParameter("orderBy");
        String sequence=request.getParameter("sequence");
        int pageIndex= Format.stringToInt(request.getParameter("page"));
        pageIndex=pageIndex>0?pageIndex:1;

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
                    if(orderByParam!=null&&orderByParam.equals(key))
                        orderBy=orderByParam;
                    if (type.equals("text")){
                        fields+=entity+"."+key+",";
                        param = request.getParameter(key + "Search");
                        if(param!=null) {
                            param = "'%" + param + "%'";
                            where += "and " + entity + "." + key + " like " + param + " ";
                        }
                    } else if (type.equals("select")) {
                        fields+=entity+"."+key+",";
                        param = request.getParameter(key + "Search");
                        if(param!=null)
                            where += "and " + entity + "." + key + "= "+param+" ";
                    } else {
                        if (range.equals("false")) {
                            fields+=entity+"."+key+",";
                            param = request.getParameter(key + "Search");
                            if (type.equals("number")) {
                                /*预留*/
                            } else if (type.equals("datetime")) {
                                fields+="date_format("+entity+"."+key+",'%Y-%m-%d %H:%i')"+key+",";
                                param="UNIX_TIMESTAMP('"+param+"')";
                            }
                            if(param!=null)
                                where += "and " + entity + "." + key + "= "+param+" ";
                        } else {
                            if (type.equals("number")) {
                                fields+=entity+"."+key+",";
                                param = request.getParameter(key + "UpSearch");
                                if(param!=null)
                                    where += "and " + entity + "." + key + "<= "+param+" ";
                                param = request.getParameter(key + "LowSearch");
                                if(param!=null)
                                    where += "and " + entity + "." + key + ">= "+param+" ";
                            } else if (type.equals("datetime")) {
                                fields+="date_format("+entity+"."+key+",'%Y-%m-%d %H:%i')"+key+",";
                                param = request.getParameter(key + "UpSearch");
                                if(param!=null) {
                                    param = "UNIX_TIMESTAMP('" + param + "')";
                                    where += "and " + entity + "." + key + "<= " + param + " ";
                                }
                                param = request.getParameter(key + "LowSearch");
                                if(param!=null) {
                                    param = "UNIX_TIMESTAMP('" + param + "')";
                                    where += "and " + entity + "." + key + ">= " + param + " ";
                                }
                            }
                        }
                    }
                }
            }
        } catch (DocumentException e) {
            e.printStackTrace();
        }

        if(sequence!=null&&sequence.trim().length()>0)
            orderBy+=" DESC";

        if (where.length()>3)
            where=where.substring(3);
        paramMap.put("tables","t_"+entity+" "+entity);
        paramMap.put("pageIndex",pageIndex);
        paramMap.put("fields",fields.substring(0,fields.length()-1));
        paramMap.put("where",where);
        paramMap.put("orderBy","id");
        paramMap.put("pageSize", Proper.pageSize());

        return paramMap;
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
