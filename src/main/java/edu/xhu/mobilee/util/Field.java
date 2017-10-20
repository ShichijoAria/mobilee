package edu.xhu.mobilee.util;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
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
                    String range=property.attributeValue("type");
                    map.put("value",value);
                    map.put("type",type);
                    map.put("range",range);
                    if(type.equals("select")){
                        Map<String,String> opt=new HashMap<String,String>();
                        if(property.element("foreign")==null) {
                            Element enums;
                            for (Iterator it = property.elementIterator("enum"); it.hasNext(); ) {
                                enums=(Element) it.next();
                                opt.put(enums.attributeValue("key"),enums.attributeValue("value"));
                            }
                            System.out.println(opt);
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
        String hql="";
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
                    if (type.equals("text")){
                        param = request.getParameter(key + "Search");
                        if(param!=null) {
                            param = "'%" + param + "%'";
                            hql += "where " + entity + "." + key + " like " + param + " ";
                        }
                    } else if (type.equals("select")) {
                        param = request.getParameter(key + "Search");
                        if(param!=null)
                            hql += "where " + entity + "." + key + "= "+param+" ";
                    } else {
                        if (range.equals("false")) {
                            param = request.getParameter(key + "Search");
                            if (type.equals("number")) {
                                /*预留*/
                            } else if (type.equals("datetime")) {
                                param="'"+param+"'";
                            }
                            if(param!=null)
                                hql += "where " + entity + "." + key + "= "+param+" ";
                        } else {
                            if (type.equals("number")) {
                                param = request.getParameter(key + "UpSearch");
                                if(param!=null)
                                    hql += "where " + entity + "." + key + "<= "+param+" ";
                                param = request.getParameter(key + "LowSearch");
                                if(param!=null)
                                    hql += "where " + entity + "." + key + ">= "+param+" ";
                            } else if (type.equals("datetime")) {
                                param = request.getParameter(key + "UpSearch");
                                if(param!=null) {
                                    param = "'" + param + "'";
                                    hql += "where " + entity + "." + key + "<= " + param + " ";
                                }
                                param = request.getParameter(key + "LowSearch");
                                if(param!=null) {
                                    param = "'" + param + "'";
                                    hql += "where " + entity + "." + key + ">= " + param + " ";
                                }
                            }
                        }
                    }
                }
            }
        } catch (DocumentException e) {
            e.printStackTrace();
        }
        return hql;
    }
}
