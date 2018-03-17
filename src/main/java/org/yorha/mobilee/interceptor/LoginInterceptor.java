package org.yorha.mobilee.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//已废弃，由shiro代替
public class LoginInterceptor implements HandlerInterceptor {

    /**
     * Handler执行完成之后调用这个方法
     */
    public void afterCompletion(HttpServletRequest request,
                                HttpServletResponse response, Object handler, Exception exc)
            throws Exception {

    }

    /**
     * Handler执行之后，ModelAndView返回之前调用这个方法
     */
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
                           Object handler, ModelAndView modelAndView) throws Exception {
    }

    /**
     * Handler执行之前调用这个方法
     */
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                             Object handler) throws Exception {
        //获取请求的URL
        String url = request.getRequestURI();
        //URL:login.jsp是公开的;这个demo是除了login.jsp是可以公开访问的，其它的URL都进行拦截控制
        if(url.indexOf("login")>=0||url.indexOf("welcome")>=0||url.indexOf("tourist")>=0){
            return true;
        }
        //获取Session
        long id =-1;
        HttpSession session = request.getSession();
        if(session.getAttribute("USER_ID")!=null){
            id=(long)session.getAttribute("USER_ID");
        }
        if(id>0)
            return true;
        //不符合条件的，跳转到登录界面
        request.getRequestDispatcher("/WEB-INF/content/login.jsp").forward(request, response);

        return false;
    }




}
