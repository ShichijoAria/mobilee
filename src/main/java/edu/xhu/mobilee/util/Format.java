package edu.xhu.mobilee.util;

import java.util.List;

/**
 * Created by Ace on 2017/6/4.
 */
public class Format {

    private Format(){
    };

    public static long stringToLong(String str){
        try {
            if (str!=null&&str.trim().length()>0){
                return Long.valueOf(str);
            }else
                return -1;
        }catch (NumberFormatException e) {
            //e.printStackTrace();
        }
        return -1;
    }

    public static int stringToInt(String str){
        try {
            if (str!=null&&str.trim().length()>0){
                return Integer.valueOf(str);
            }else
                return -1;
        }catch (NumberFormatException e) {
            //e.printStackTrace();
        }
        return -1;
    }

    /*
    * @param page 当前页 传入当前页必须大于等于1
    * */
    public static List sublist(int page,List list){
        page=page>0?page:1;
        int pageSize=Proper.pageSize();
        int start=(page-1)*pageSize;
        int end=page*pageSize;
        int size=list.size();
        if(start<size){
            return end<size?list.subList(start,end):list.subList(start,size);
        }
        return null;
    }
}
