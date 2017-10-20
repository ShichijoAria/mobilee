<%@ page contentType="text/html;charset=UTF-8" import="java.util.*" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <meta charset="UTF-8">
    <title>学生信息系统</title>
    <script src="<%=path%>/dist/jquery.js"></script>
    <script src="<%=path%>/dist/semantic.min.js"></script>
    <script src="<%=path%>/dist/jquery.datetimepicker.full.js"></script>
    <script src="<%=path%>/js/util.js"></script>
    <link rel="stylesheet" href="<%=path%>/dist/jquery.datetimepicker.css">
    <link rel="stylesheet" href="../dist/semantic.css">
    <link rel="stylesheet" href="<%=path%>/css/index.css">
    <link rel="stylesheet" href="<%=path%>/css/view.css">
    <link rel="stylesheet" href="<%=path%>/css/general.css">
</head>
<body style="background-color: #fff;">
<form class="ui form pusher" method="post" action="view.action" id="main">
    <%--侧边栏--%>
    <div class="ui top left vertical menu sidebar">
        <a class="ui right grey large corner label">
            <i class="close icon"></i>
        </a>
        <div class="content">
            <div class="ui grid stackable segment three column vertical container">
                <c:forEach items="${requestScope.fields.head}" var="myMap" >
                    <div class="column">
                        <div class="ui black basic label">
                                ${myMap.value.value}
                        </div>
                        <div class="ui input">
                            <c:if test="${myMap.value.type=='select'}">
                                <select class="ui dropdown">
                                    <option value="">&nbsp;</option>
                                    <c:forEach items="${myMap.value.opt}" var="opt" >
                                        <option value="${opt.key}">${opt.value}</option>
                                    </c:forEach>
                                </select>
                            </c:if>
                            <c:if test="${myMap.value.type=='datetime'}">
                                <input class="input" name="${myMap.key}SearchUp" datetime="true">
                        </div>
                    </div>
                    <div class="column">
                        <div class="ui black basic label">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </div>
                        <div class="ui input">
                        <input class="input" name="${myMap.key}Low" datetime="true">
                        </div>
                    </div>
                            </c:if>
                            <c:if test="${myMap.value.type=='text'||myMap.value.type=='number'}">
                                <input class="input" type="${myMap.value.type}" name="${myMap.key}" value="${param.searchId}">
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
                <div style="text-align: center;width:100%;padding-top: 5%">
                    <button class="ui button blue">查询</button>
                    <a class="ui button" id="reset">重置</a>
                </div>
            </div>
        </div>
    </div>

    <div class="pusher">
        <h2 class="ui header">
            <i class="${requestScope.icon} alternate icon"></i>
            <div class="content">${requestScope.title}</div>
            <div class="sub header">${requestScope.extra}</div>
        </h2>
        <div  id="menu">
            <div class="ui small menu">
                <div class="right menu">
                    <div class="item">
                        <div id="search" class="ui teal icon button">
                            <i class="search icon"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="ui loading segment"  id="segment">
            <table class="very selectable small celled large unstackable compact ui single line table">
                <thead>
                <tr class="center aligned">
                    <th class="one wide">
                        <div class="ui checkbox">
                            <input type="checkbox" name="switch" id="checkAll"><label></label>
                        </div>
                    </th>
                    <c:forEach items="${requestScope.fields.head}" var="myMap" >
                        <th class="" id="<c:out value="${myMap.key}" />"><c:out value="${myMap.value.value}" /></th>
                    </c:forEach>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <div  id="foot" style="text-align: center">
            <div class="ui compact pagination menu" id="pagination">
                <div class='disabled item'>
                    ...
                </div>
            </div>
        </div>
    </div>
</form>
<script>
    "use strict"

    var viewName='${requestScope.fields.namespace}';
    var arr=[];

    for(var i=1;i<$('th').length;i++){
        arr.push($('th')[i].id)
    }
    getInfoList(viewName,arr,"");


    $('#reset').click(function () {
        $('.input').val("");
    });


    //时间日期选择框初始化
    $.datetimepicker.setLocale('zh');
    $("input[datetime='true']").datetimepicker({format: 'Y-m-d H:i'});

    //页面初始化
    changeSize();
    bindCheck();
    $('.ui.dropdown').dropdown()/*下拉菜单初始化*/
    $(window).resize(function() {//缩放事件
        changeSize();
    });
    $('.ui.sidebar').sidebar({
        context: $('form'),
        useLegacy:true,
    })
    $('#search,.ui.right.grey.large.corner.label').click(function () {
        $('.ui.sidebar')
            .sidebar('toggle')
    })

</script>
</body>
</html>