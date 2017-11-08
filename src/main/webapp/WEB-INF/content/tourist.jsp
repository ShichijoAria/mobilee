<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <!-- Standard Meta -->
    <meta HTTP-EQUIV="pragma" CONTENT="no-cache">
    <meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
    <meta HTTP-EQUIV="expires" CONTENT="0">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

    <!-- Site Properties -->
    <title>手百网</title>

    <script src="<%=path%>/dist/jquery.min.js"></script>
    <script src="<%=path%>/dist/semantic.min.js"></script>
    <script src="<%=path%>/js/util.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=path%>/dist/semantic.css">
    <link rel="stylesheet" href="<%=path%>/css/general.css">
    <link rel="stylesheet" href="<%=path%>/css/tourist.css">

</head>
<body>

<div class="ui fixed inverted  menu">
    <div class="ui container">
        <a href="#" class="header item">
            <i class="myLogo mobile icon"></i>
            手百网
        </a>
        <a href="<%=path%>/tourist/index" class="item">主页</a>
        <div class="ui item right">
            <div class="ui icon input">
                <input type="text" placeholder="搜索...">
                <i class="inverted circular search link icon"></i>
            </div>
        </div>
    </div><c:if test="${sessionScope.TOURIST_ID==null}">
    <div class="ui item right floated"><a class="item" href="<%=path%>/tourist/welcome">登录</a><div id="signUp" class="item">注册</div></div></c:if><c:if test="${sessionScope.TOURIST_ID!=null}">
    <div class="menu right" id="personal">
        <div class="ui dropdown item">
            <img id="headPhoto" class="ui avatar image" src="<%=path%>/upload/user/${sessionScope.TOURIST_ID}.jpg?a" onerror="javascript:this.src='<%=path%>/upload/timg.jpg'">
            <span id="userName">${sessionScope.TOURIST_NAME}</span>
            <div class="menu">
                <a class="item" modal="personalInformation"><i class="icon setting"></i> 个人信息</a>
                <a class="item" href="<%=path%>/tourist/cancel"><i class="icon sign out"></i> 注销</a>
            </div>
        </div>
    </div></c:if>
</div>

<div class="ui main container">
    <div class="ui menu inverted attached">
        <a class="teal item" id="phone">手机大全</a>
        <a class="teal item" id="firm">厂商大全</a>
    </div>
    <div class="ui stacked segment attached">
        <div class="ui horizontal divided list" id="myList">
            <div class="item">
                <div class="content">
                    <p>最新：</p>
                </div>
            </div><c:forEach var="bean" items="${requestScope.data.newMobilePhone}">
            <div class="item">
                <div class="content">
                    <a href="<%=path%>/tourist/detail?id=${bean.id}">${bean.name}</a>
                </div>
            </div></c:forEach>
        </div>
    </div>
    <div class="ui grid">
        <div class="ui four stackable cards"><c:forEach var="bean" items="${requestScope.data.mobilePhone}">
            <div class="ui card" mobile_phone_id="${bean.id}">
                <div class="image">
                    <img class="ui fluid image" src='<%=path%>/upload/mobilePhone/${bean.id}.jpg' onerror="javascript:this.src='<%=path%>/upload/mobilePhone/timg.jpg'">
                </div>
                <div class="ui floating red tag label">￥${bean.price}</div>
                <div class="content">
                    <div class="header" style="text-align: center">${bean.name}</div>
                    <span class="right floated">
                      <i class="yellow star icon"></i>
                      ${bean.collection} 收藏
                    </span>
                    <i class="comment icon"></i>
                        ${bean.comment} 评论
                </div>
            </div></c:forEach>
        </div>
    </div>
</div>

<div class="ui inverted vertical footer segment">
    <div class="ui center aligned container">
        <div class="ui stackable inverted divided grid">
            <div class="three wide column">
                <h4 class="ui inverted header">合作厂商</h4>
                <div class="ui inverted link list">
                    <a href="javascript:void(0);" class="item">暂无</a>
                </div>
            </div>
            <div class="three wide column">
                <h4 class="ui inverted header">友情链接</h4>
                <div class="ui inverted link list">
                    <a href="javascript:void(0);" class="item"><i class="icon qq"></i>QQ</a>
                    <a href="javascript:void(0);" class="item"><i class="icon weibo"></i>weibo</a>
                    <a href="javascript:void(0);" class="item"><i class="icon wechat"></i>wechat</a>
                    <a href="javascript:void(0);" class="item"><i class="icon twitter"></i>twitter</a>
                </div>
            </div>
            <div class="three wide column">
                <h4 class="ui inverted header">联系方式</h4>
                <div class="ui inverted link list">
                    <a href="#" class="item"><i class="icon qq"></i>1056358034</a>
                    <a href="https://github.com/ShichijoAria" class="item"><i class="icon github"></i>shichijoaria</a>
                </div>
            </div>
            <div class="seven wide column">
                <h4 class="ui inverted header">声明</h4>
                <p>本网站做学习用途</p>
            </div>
        </div>
        <div class="ui inverted section divider"></div>
        <div class="ui horizontal inverted small divided link list">
            <a class="item" href="#">Site Map</a>
            <a class="item" href="#">Contact Us</a>
            <a class="item" href="#">Terms and Conditions</a>
            <a class="item" href="#">Privacy Policy</a>
        </div>
    </div>
</div>


<%--模态框 个人信息--%>
<div class="ui first modal">
    <div class="header">
        详细信息
    </div>
    <div class="image content">
        <form class="ui stackable  form two column grid" id="modal" style="width:100%">
            <div class="field column">
                <img id="myPicture" class="ui medium bordered  circular image" data-position="right center" data-title='点击更改图片', onerror="javascript:this.src='<%=path%>/upload/timg.jpg'" src="<%=path%>/upload/user/${sessionScope.TOURIST_ID}.jpg?a" id="myPicture" onclick="document.getElementById('file').click();"/>
            </div>
            <div class="field column">
                <div class="ui items">
                    <div class="item">
                        <div class="ui labeled input">
                            <div class="ui teal label">
                                编号：
                            </div>
                            <input name="id" value="${sessionScope.TOURIST_ID}" readonly/>
                        </div>
                    </div>
                    <div class="item">
                        <div class="ui labeled input">
                            <div class="ui teal label">
                                昵称：
                            </div>
                            <input name="name" value="${sessionScope.TOURIST_NAME}"/>
                        </div>
                    </div>
                    <div class="item">
                        <div class="ui labeled input">
                            <div class="ui teal label">
                                密码：
                            </div>
                            <input name="password" type="password" value="${sessionScope.TOURIST_PASSWORD}"/>
                        </div>
                    </div>
                    <input type="file" name="file" id="file" style="display: none" onchange="myUpload()">
                </div>
            </div>
        </form>
    </div>
    <div class="actions">
        <div class="ui black deny button">
            关闭
        </div>
        <div class="ui positive right labeled icon button" id="saveUser">
            保存
            <i class="checkmark icon"></i>
        </div>
    </div>
</div>

<%--注册模态框 --%>
<div class="ui register modal">
    <div class="header">
        详细信息
    </div>
    <div class="image content">
        <form class="ui stackable  form two column grid" id="register" style="width:100%">
            <div class="field column">
                <div class="ui items">
                    <div class="item">
                        <div class="ui labeled input">
                            <div class="ui teal label">
                                注册昵称：
                            </div>
                            <input name="name" value=""/>
                        </div>
                    </div>
                    <div class="item">
                        <div class="ui labeled input">
                            <div class="ui teal label">
                                输入密码：
                            </div>
                            <input name="password" type="password" value=""/>
                        </div>
                    </div>
                    <div class="item">
                        <div class="ui labeled input">
                            <div class="ui teal label">
                                确认密码：
                            </div>
                            <input name="confirm" type="password" value=""/>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="actions">
        <div class="ui black deny button">
            关闭
        </div>
        <div class="ui positive right labeled icon button" id="submit">
            提交
            <i class="checkmark icon"></i>
        </div>
    </div>
</div>

<%--模态框 反馈信息--%>
<div class="ui small modal">
    <div class="header">

    </div>
    <div class="ui icon header">

    </div>

    <div class="actions">
        <div class="ui green ok inverted button">
            <i class="checkmark icon"></i>
            是
        </div>
    </div>
</div>

</body>
<script>

    alterSize();

    $('.ui.dropdown')
        .dropdown()
    ;/*下拉菜单初始化*/


    //模态框
    $('.ui.first.modal').modal({
        onDeny    : function(){
            if($('#modal').hasClass('loading'))
                return false;
        },
        onApprove : function() {
            return false;
        }
    }) .modal('setting', 'closable', false)
    //模态框
    $('.ui.register.modal').modal({
        onDeny    : function(){
            if($('#modal').hasClass('loading'))
                return false;
        },
        onApprove : function() {
            return false;
        }
    }) .modal('setting', 'closable', false)
    $('.small.modal')
        .modal({
            allowMultiple: true,
            onApprove : function() {
                $('#modal').removeClass('loading');
            }
        })
        .modal('setting', 'closable', false)

    $('.ui.card').click(function () {
        window.open("<%=path%>/tourist/detail?id="+$(this).attr("mobile_phone_id"));
    })

    $("[modal='personalInformation']").click(function () {
        $('.ui.first.modal')
            .modal('show');
    })

    $('#submit').click(function () {
        if($("#register input[name='password']").val()==$("#register input[name='confirm']").val()) {
            $.post("/mobilee/tourist/register",
                {
                    password: $("#register input[name='password']").val(),
                    name: $("#register input[name='name']").val(),
                },function(data, status) {
                    if (status != "success") {
                        showToast("<i class='warning icon'></i>连接服务器失败！");
                    }else {
                        if(data.msg=="success"){
                            showToast("<i class='archive icon'></i>注册成功,请牢记您的账号id:"+data.id);
                        }else {
                            showToast("<i class='remove circle outline icon'></i>"+data.msg);
                        }
                    }
                });
        }
    })

    $('#signUp').click(function () {
        $('.ui.register.modal').modal('show')
    })

    function changeList(list) {
        var htmlList=list.map(getEle)
        var innerHtml="<div class=\"item\">\n" +
            "                <div class=\"content\">\n" +
            "                    <p>最新：</p>\n" +
            "                </div>\n" +
            "            </div>";
        for(i in htmlList){
            innerHtml+=htmlList[i]
        }
        $('#myList').html(innerHtml);
    }

    function getEle(text) {
        return "<div class=\"item\">\n" +
            "                <div class=\"content\">\n" +
            "                    <a>"+text+"</a>\n" +
            "                </div>\n" +
            "            </div>"
    }

    $('#saveTourist').click(function () {
        $('#modal').addClass('loading');
        $.post("/mobilee/tourist/save",
            {
                id:$(".field.column [name='id']").val(),
                name:$(".field.column [name='name']").val(),
                password:$(".field.column [name='password']").val()},
            function(data, status) {
                if (status != "success") {
                    showToast("<i class='warning icon'></i>连接服务器失败！");
                }else {
                    if(data.msg=="success"){
                        showToast("<i class='archive icon'></i>保存成功");
                        $('#adminName').text($(".field.column [name='name']").val());
                        $('#myPicture').attr('src',"../upload/user/${sessionScope.TOURIST_ID}.jpg?"+Math.random());
                        $('#headPhoto').attr('src',"../upload/user/${sessionScope.TOURIST_ID}.jpg?"+Math.random());
                    }else {
                        showToast("<i class='remove circle outline icon'></i>"+data.msg);
                    }
                }
            });
    })

    window.onload=alterSize();

    function alterSize(){
        $('.ui.fluid.image').outerHeight(4/3*$('.ui.fluid.image').outerWidth());
        $('#myPicture').outerHeight($('#myPicture').outerWidth());
    }
</script>
</html>
