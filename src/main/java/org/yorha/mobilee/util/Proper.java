package org.yorha.mobilee.util;

import java.util.ResourceBundle;

public class Proper {

    private Proper() {
    }

    public static final int pageSize(){
        ResourceBundle resource = ResourceBundle.getBundle("config");//test为属性文件名，放在包com.mmq下，如果是放在src下，直接用test即可
        int value = Format.stringToInt(resource.getString("pageSize"));
        return value>0?value:10;
    }
}
