package org.yorha.mobilee.util;

import java.util.EnumMap;

//性别枚举[0:男 1:女]
public enum GenderEnum {
    MAN(0),WOMEN(1);

    private int key; //编码标识

    private GenderEnum(int key){
        this.key = key;
    }

    public int getKey() {
        return key;
    }

    public static EnumMap<GenderEnum,String> getMap(){
        EnumMap<GenderEnum, String> enumMap = new EnumMap<GenderEnum,String>(GenderEnum.class);
        enumMap.put(GenderEnum.MAN, "男");
        enumMap.put(GenderEnum.WOMEN, "女");
        return enumMap;
    }
    
}