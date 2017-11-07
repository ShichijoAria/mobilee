<%--
  Created by IntelliJ IDEA.
  User: shichijoaria
  Date: 17-11-5
  Time: 上午8:01
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
    <script src="<%=path%>/js/active.js"></script>
    <script src="<%=path%>/js/util.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=path%>/dist/semantic.css">
    <link rel="stylesheet" href="<%=path%>/css/general.css">
    <link rel="stylesheet" href="<%=path%>/css/tourist.css">
    <link rel="stylesheet" href="<%=path%>/css/detail.css">

</head>
<body>

<div class="ui fixed inverted menu">
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
    <a class="ui item right floated" href="<%=path%>/tourist/welcome">登录</a></c:if><c:if test="${sessionScope.TOURIST_ID!=null}">
    <div class="menu right">
        <div class="ui dropdown fluid item">
            <img class="ui avatar image" src="<%=path%>/upload/admin/${sessionScope.TOURIST_ID}.jpg?a" onerror="javascript:this.src='<%=path%>/upload/timg.jpg'">
            <span id="userName">${sessionScope.TOURIST_NAME}</span>
            <div class="menu">
                <a class="item" modal="personalInformation"><i class="icon setting"></i> 个人信息</a>
                <a class="item" href="<%=path%>/tourist/loginOut"><i class="icon sign out"></i> 注销</a>
            </div>
        </div>
    </div></c:if>
</div>

<div class="ui main container">
    <div class="ui stacked segment attached">
        <div class="ui horizontal divided list" id="myList">
            <div class="item">
                <div class="content">
                    <h1 class="ui header">详细信息</h1>
                </div>
            </div>
        </div>
    </div>
    <div class="ui grid">
        <div class="sixteen wide column">
            <div class="ui grid">
                <div class="eleven wide column">
                    <div class="ui raised segment">
                            <div class="ui grid">
                                <div class="seven wide column">
                                    <img class="ui centered medium image" src='<%=path%>/upload/mobilePhone/${requestScope.detail.mobilePhone.id}.jpg' onerror="javascript:this.src='<%=path%>/upload/mobilePhone/timg.jpg'">
                                </div>
                                <div class="nine wide column">
                                    <div class="row">
                                        <h2 class="ui header">
                                            <div class="content">
                                                ${requestScope.detail.mobilePhone.name}
                                                <div class="sub header">参考价格:<span style="color: red">￥${requestScope.detail.mobilePhone.price}</span></div>
                                            </div>
                                            <span class="right floated"><i class="heart <c:if test="${requestScope.detail.isCollected>0}">red</c:if> like icon"></i>喜欢</span>
                                        </h2>
                                    </div>
                                    <div class="row">
                                        <table class="ui teal celled table">
                                            <tr>
                                                <td class="five wide">
                                                    <p><i class="icon browser"></i></p>
                                                    <p>基本信息</p>
                                                </td>
                                                <td>
                                                    <p>上市时间：${fn:substring(requestScope.detail.mobilePhone.listTime, 0, 10)}</p>
                                                    <p>手机尺寸：${requestScope.detail.mobilePhone.length}mm*${requestScope.detail.mobilePhone.width}mm*${requestScope.detail.mobilePhone.height}mm</p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="five wide">
                                                    <p><i class="icon desktop"></i></p>
                                                    <p>屏幕信息</p>
                                                </td>
                                                <td>
                                                    <p>屏幕尺寸：${requestScope.detail.mobilePhone.size}寸</p>
                                                    <p>屏幕分辨率：${requestScope.detail.mobilePhone.pixel}p</p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="five wide">
                                                    <p><i class="icon camera retro"></i></p>
                                                    <p>拍照信息</p>
                                                </td>
                                                <td>
                                                    <p>相机像素：${requestScope.detail.mobilePhone.cameraPixel}像素</p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="five wide">
                                                    <p><i class="icon certificate"></i></p>
                                                    <p>硬件信息</p>
                                                </td>
                                                <td>
                                                    <p>cpu型号:${requestScope.detail.mobilePhone.cpu}</p>
                                                    <p>运行内存:${requestScope.detail.mobilePhone.memory}</p>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                    </div>
                    <div class="ui raised segment">
                        <div class="row">
                            <h3 class="ui header">评论</h3>
                        </div>
                        <div class="ui comments" style="width: 100%;"><c:forEach items="${requestScope.detail.comment}" var="bean">
                            <div class="comment ui grid">
                                <div class="user-face two wide column">
                                    <a href="javascript:void(0);">
                                        <img class="ui bordered avatar image" src='<%=path%>/upload/user/${bean.id}.jpg' onerror="javascript:this.src='<%=path%>/upload/user/timg.jpg'">
                                    </a>
                                </div>
                                <div class="con fourteen wide column">
                                    <div class="user">
                                        <a href="javascript:void(0);" class="userName">${bean.name}</a>
                                        <a href="javascript:void(0);">
                                            <i class="level l4"></i>
                                        </a>
                                    </div>
                                    <p class="text">${bean.content}</p>
                                    <div class="commentInfo ui grid">
                                        <span class="floor two wide column">#${bean.storey}</span>
                                        <span class="time six wide column">2017-09-11 22:14</span>
                                        <span class="like one wide column">
                                            <i class="icon thumbs outline up"></i>
                                            <span></span>
                                        </span>
                                        <span class="hate one wide column">
                                           <i class="icon thumbs outline down"></i>
                                        </span>
                                    </div>
                                    <div class="reply-box">

                                    </div>
                                    <div class="paging-box">

                                    </div>

                                    <div class="ui divider"></div>
                                </div>
                            </div>
                            </c:forEach>
                            <form id="comment" class="ui reply form">
                                <div class="field">
                                    <textarea name="content" <c:if test="${sessionScope.TOURIST_ID==null}"> readonly placeholder="请先登录才能进行评论。" </c:if>></textarea>
                                    <input name='mobilePhone.id' value="${requestScope.detail.mobilePhone.id}" style="display:none" />
                                </div>
                                <div class="ui primary<c:if test="${sessionScope.TOURIST_ID==null}"> disabled</c:if> labeled icon button" id="submit">
                                    <i class="icon edit"></i>评论
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="five wide column">
                    <div class="ui raised segment">
                        <div class="row">
                            <h2 class="ui header">
                                <div class="content">
                                    有售商家
                                    <div class="sub header">参考列表</div>
                                </div>
                            </h2>
                        </div>
                        <div class="row">
                            <div class="ui items"><c:forEach items="${requestScope.detail.sale}" var="bean">
                                <div class="item">
                                    <div class="ui mini image">
                                        <img class="ui large avatar bordered image"  src="<%=path%>/upload/sale/${bean.id}.jpg" onerror="javascript:this.src='<%=path%>/upload/timg.jpg'">
                                    </div>
                                    <div class="content" style="width: 100%">
                                        <a class="header">${bean.name}</a>
                                        <div class="meta">
                                            <span style="color: red">￥${bean.price}</span></div>
                                    </div>
                                    <div class="description">
                                        <p></p>
                                    </div>
                                    <div class="extra">
                                            ${bean.address}
                                    </div>
                                </div>
                                <div class="ui divider"></div></c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<div class="ui inverted vertical footer segment">
    <div class="ui center aligned container">
        <div class="ui stackable inverted divided grid">
            <div class="three wide column">
                <h4 class="ui inverted header">合作厂商</h4>
                <div class="ui inverted link list">
                    <a href="#" class="item">Link One</a>
                    <a href="#" class="item">Link Two</a>
                    <a href="#" class="item">Link Three</a>
                    <a href="#" class="item">Link Four</a>
                </div>
            </div>
            <div class="three wide column">
                <h4 class="ui inverted header">友情链接</h4>
                <div class="ui inverted link list">
                    <a href="#" class="item">Link One</a>
                    <a href="#" class="item">Link Two</a>
                    <a href="#" class="item">Link Three</a>
                    <a href="#" class="item">Link Four</a>
                </div>
            </div>
            <div class="three wide column">
                <h4 class="ui inverted header">联系方式</h4>
                <div class="ui inverted link list">
                    <a href="#" class="item">Link One</a>
                    <a href="#" class="item">Link Two</a>
                    <a href="#" class="item">Link Three</a>
                    <a href="#" class="item">Link Four</a>
                </div>
            </div>
            <div class="seven wide column">
                <h4 class="ui inverted header">Footer Header</h4>
                <p>Extra space for a call to action inside the footer that could help re-engage users.</p>
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
</body>
<script>

    $('.ui.dropdown').dropdown()

    $('#submit').click(function(){
        $.post("<%=path%>/tourist/add?"+serializeNotNull($('#comment').serialize()),
            function (data, status) {
                if (status != "success") {
                    showError(["无法连接服务器"]);
                }else {
                    if(data.msg=="success"){
                        location.reload();
                    }else {
                        showError([data.msg]);
                    }
                }
            });
    });

    $('.heart.like.icon').click(function () {
        $.post("<%=path%>/tourist/collect?id=${requestScope.detail.mobilePhone.id}",
            function (data, status) {
                if (status != "success") {
                    showError(["无法连接服务器"]);
                }else {
                    if(data.msg=="success"){
                        location.reload();
                    }else {
                        showError([data.msg]);
                    }
                }
            });
    })

    alterSize();

    window.onresize=alterSize();

    function alterSize(){
        $('.ui.fluid.image').outerHeight(5/4*$('.ui.fluid.image').outerWidth());
        $('.comment .ui.avatar.image').outerHeight($('.comment .ui.avatar.image').outerWidth());
        $('.ui.mini.image .ui.avatar.image').outerHeight($('.ui.mini.image .ui.avatar.image').outerWidth());
    }
</script>
</html>