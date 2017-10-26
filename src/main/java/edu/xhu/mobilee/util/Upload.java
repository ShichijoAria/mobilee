package edu.xhu.mobilee.util;

import java.io.*;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.struts2.ServletActionContext;

public class Upload {

    public static String upload(HttpServletRequest request,String realPath)
            throws ServletException, IOException {
        String msg = "";

        // 实例化一个硬盘文件工厂，用来配置文件上传组件ServletFileUpload

        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory); // 利用硬盘文件工厂配置文件上传组件
        List<FileItem> items = null; // 存放FileItem对象
        try { // 获取文件的FileItem对象，即表单域,分为普通表单域和文件域
            items = upload.parseRequest(request);
        } catch (FileUploadException e) {
            e.printStackTrace();
        }
        String path = null; // 存放上传文件的完整名称，包括路径。
        String filename = " "; // 存放文件名
        InputStream is = null;
        // 循环处理上传文件
        for (FileItem item : items) {
            if (item.isFormField()) {
                if (item.getFieldName().equals("filename")) {
                    if (!item.getString().equals(""))
                        filename = item.getString("UTF-8");
                }
            } else if (item.getName().trim() != null
                    && !item.getName().trim().equals(" ")) {
                path = item.getName();// 得到文件完整路径
                filename = path.substring(path.lastIndexOf("\\") + 1);
                is = item.getInputStream(); // 获得上传文件的InputStream对象
            }
        }
        String pathName = request.getSession().getServletContext().getRealPath("/") + filename;
        if (new File(pathName).exists()) {
            msg = "该文件已经存在，请为文件指定一个新的文件名";
        } else if (!pathName.equals("")) {
            FileOutputStream fos = new FileOutputStream(pathName);
            byte[] buffer = new byte[8192];
            int count = 0;

            // 开始读取上传文件的字节，并将其输出到服务器端的上传文件输 出流中
            while ((count = is.read(buffer)) > 0) {
                fos.write(buffer, 0, count); // 向服务器端文件写入字节流
            }
            fos.close();
            is.close();
            msg = "success";
        }
        return msg;
    }

}