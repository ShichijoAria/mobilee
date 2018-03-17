package org.yorha.mobilee.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.*;

import javax.servlet.http.HttpServletRequest;


public class Upload {

    public static String uploadJpg(MultipartFile file, HttpServletRequest request, long id, String module){
        String path = request.getSession().getServletContext().getRealPath("upload/"+module);
        String fileName=file.getOriginalFilename();
        String extensionName=fileName.substring(fileName.lastIndexOf('.')+1);
        String msg = "";
        if(extensionName.equals("jpg")) {
            String name = id + fileName.substring(fileName.lastIndexOf('.'));
            File targetFile = new File(path, name);
            if (!targetFile.exists()) {
                targetFile.mkdirs();
            }
            // 保存
            try {
                file.transferTo(targetFile);
                msg = "success";
            } catch (Exception e) {
                msg = "上传失败";
                e.printStackTrace();
            }
        }else {
            msg="只支持jpg格式的图片！";
        }
        return msg;
    }

}