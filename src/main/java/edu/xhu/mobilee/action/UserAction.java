package edu.xhu.mobilee.action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

@ParentPackage("struts-default")
@Namespace("/user")
public class UserAction extends ActionSupport implements Preparable {
    public void prepare() throws Exception {

    }

    @Action(value = "login", results = { @Result(name = "success", location = "/login.jsp") })
    public String login() {
            return SUCCESS;
    }

}
