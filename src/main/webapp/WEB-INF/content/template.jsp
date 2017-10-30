<%@ page contentType="text/html;charset=UTF-8" import="java.util.*" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
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
    <script src="<%=path%>/dist/jquery.min.js"></script>
    <script src="<%=path%>/dist/jquery.form.js"></script>
    <script src="<%=path%>/dist/semantic.min.js"></script>
    <script src="<%=path%>/dist/jquery.datetimepicker.full.js"></script>
    <script src="<%=path%>/js/util.js"></script>
    <link rel="stylesheet" href="<%=path%>/dist/jquery.datetimepicker.css">
    <link rel="stylesheet" href="<%=path%>/dist/semantic.css">
    <link rel="stylesheet" href="<%=path%>/css/index.css">
    <link rel="stylesheet" href="<%=path%>/css/view.css">
    <link rel="stylesheet" href="<%=path%>/css/general.css">
</head>
<body style="background-color: #fff;">
<div class="ui form pushable" method="post" action="view" id="main">
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
                    <div class="ui input"><c:if test="${myMap.value.type=='select'}">
                        <select class="ui dropdown" name="${myMap.key}Search">
                            <option value="">&nbsp;</option>
                            <c:forEach items="${myMap.value.opt}" var="opt" >
                                <option value="${opt.key}">${opt.value}</option>
                            </c:forEach>
                        </select></c:if><c:if test="${myMap.value.type=='datetime'||myMap.value.type=='date'}"><c:if test="${myMap.value.range=='true'}">
                        <input class="input" name="${myMap.key}LowSearch" ${myMap.value.type}="true">
                    </div>
                </div>
                <div class="column">
                    <div class="ui black basic label">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </div>
                    <div class="ui input">
                        <input class="input" name="${myMap.key}UpSearch" ${myMap.value.type}="true">
                    </c:if><c:if test="${myMap.value.range=='false'}">
                        <input class="input" name="${myMap.key}Search" ${myMap.value.type}="true"></c:if></c:if><c:if test="${myMap.value.type=='number'&&myMap.value.range=='true'}">
                        <input class="input" name="${myMap.key}LowSearch" ${myMap.value.type}="true">
                    </div>
                </div>
                <div class="column">
                    <div class="ui black basic label">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </div>
                    <div class="ui input">
                        <input class="input" type="${myMap.value.type}" name="${myMap.key}UpSearch"></c:if><c:if test="${myMap.value.type=='text'||myMap.value.type=='number'&&myMap.value.range=='false'}">
                        <input class="input" type="${myMap.value.type}" name="${myMap.key}Search">
                    </c:if>
                    </div>
                </div>
                </c:forEach>
            </div>
        </div>

        <div style="text-align: center;width:100%;padding-top: 5%">
            <div class="ui button blue" id="lookFor">查询</div>
            <a class="ui button" id="reset">重置</a>
        </div>
    </div>


    <div class="pusher" style="height: 100%">
        <h2 class="ui header">
            <i class="${requestScope.fields.icon} alternate icon"></i>
            <div class="content">${requestScope.fields.title}</div>
            <div class="sub header">${requestScope.fields.extra}</div>
        </h2>
        <div  id="menu">
            <div class="ui small menu">
                <div class="left menu">
                    <div class="item"><c:if test="${requestScope.fields.insert=='true'}">
                        <div class="ui primary button" id="new" style="margin-right: 5px">新建</div></c:if><c:if test="${requestScope.fields.delete=='true'}">
                        <div class="ui red button" id="delete">删除</div></c:if>
                    </div>
                </div>
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
                        <th class="<c:out value="type${myMap.value.type}"/>" id="<c:out value="${myMap.key}"/>"><i class="icon sort"></i><c:out value="${myMap.value.value}" /></th>
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
</div>

<%--模态框 主信息--%>
<div class="ui first modal">
    <div class="header">
        详细信息
    </div>
    <div class="image content">
        <div class="ui stackable  form three column grid" id="modal" style="width: 100%">
            <c:forEach items="${requestScope.fields.show}" var="showMap" >
                <c:if test="${showMap.value.type=='img'}">
                    <div class="row">
                        <div class="field column">
                            <label>${showMap.value.value}</label>
                            <img class="ui medium bordered  circular image" data-position="right center" data-title='点击更改图片', onerror="javascript:this.src='../upload/${requestScope.fields.namespace}/timg.jpg'" src="" id="myPicture" onclick="document.getElementById('file').click();"/>
                        </div>
                    </div>
                </c:if>
                <c:if test="${showMap.value.type!='img'}">
                    <div class="field column">
                        <label>${showMap.value.value}</label>
                        <c:if test="${showMap.value.type=='select'}">
                            <select  class="ui dropdown <c:if test="${showMap.value.edit=='false'}">disabled</c:if>" name="${showMap.key}">
                                <option value="">&nbsp;</option>
                                <c:forEach items="${showMap.value.opt}" var="opt" >
                                    <option value="${opt.key}">${opt.value}</option>
                                </c:forEach>
                            </select>
                        </c:if>
                        <c:if test="${showMap.value.type=='text'||showMap.value.type=='number'}">
                            <input <c:if test="${showMap.value.edit=='false'}">readonly=""</c:if> type="${showMap.value.type}" name="${showMap.key}">
                        </c:if>
                        <c:if test="${showMap.value.type=='datetime'||showMap.value.type=='date'}">
                            <input <c:if test="${showMap.value.edit=='false'}">readonly="" ${showMap.value.type}="false"</c:if> <c:if test="${showMap.value.edit!='false'}">${showMap.value.type}="true"</c:if>  name="${showMap.key}">
                        </c:if>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>
    <div class="actions">
        <div class="ui black deny button">
            关闭
        </div><c:if test="${requestScope.fields.update=='true'}">
        <div class="ui positive right labeled icon button" id="saveEntity">
            保存
            <i class="checkmark icon"></i>
        </div></c:if>
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

<form id="upFile"  enctype="multipart/form-data">
    <input type="file" name="file" id="file" style="display: none" onchange="myUpload()">
    <input type="number" name="fileId" id="fileId" style="display: none">
</form>
</body>
<script>
    "use strict"

    //声明全局变量
    //初始页
    var currentPage=1;
    //trim().length()>0为降序
    var sequence="";
    //排序字段
    var orderBy="";

    var viewName='${requestScope.fields.namespace}';
    //table head初始化
    var arr=[];
    for(var i=1;i<$('th').length;i++){
        arr.push($('th')[i].id)
    }
    getInfoList(viewName,arr,1,false,null,null);

    $('#delete').click(function () {
        var myCheck=$(".pusher input[name='item'][type='checkbox']");
        var deleteArr=[];
        for(i in myCheck){
            if(myCheck[i].checked){
                deleteArr.push(myCheck[i].value);
            }
        }
        if(arr.length>0) {
            $.post("/mobilee/" + viewName + "/delete", "deleteArr=" + deleteArr.join(','),
                function (data, status) {
                    if (status != "success") {

                    } else {
                        if (data.msg == "success") {
                            showToast("<i class='remove circle icon'></i>删除成功")
                            getInfoList(viewName,arr,currentPage,true,orderBy,sequence);
                            getInfoList(viewName, arr, currentPage, currentUrl,sequence);
                        } else {

                        }
                    }
                });
        }
    });

    $('#lookFor').click(function () {
        orderBy="";
        sequence="";
        getInfoList(viewName,arr,1,true,orderBy,sequence);
        $('th').children('i').attr("class","icon sort")
    });

    $('#reset').click(function () {
        $('.input').val("");
    });

    $('#saveEntity').click(function () {
        $('#modal').addClass('loading');
        $.post("/mobilee/"+viewName+"/save",
            {
                id:$(".field.column [name='id']").val()
                <c:forEach items="${requestScope.fields.show}" var="editMap" varStatus="stat" >
                    <c:if test="${editMap.value.edit=='true'}">
                        ,${editMap.key}:$(".field.column [name='${editMap.key}']").val()
                    </c:if>
                </c:forEach>
            },
            function(data, status) {
                if (status != "success") {
                    showToast("<i class='warning icon'></i>连接服务器失败！");
                }else {
                    if(data.msg=="success"){
                        showToast("<i class='archive icon'></i>保存成功");
                        getInfoList(viewName, arr, currentPage,true,orderBy,sequence);
                    }else {
                        showToast("<i class='remove circle outline icon'></i>"+data.msg);
                    }
                }
            });
    })

    //排序图标变化
    $('th').click(function () {
        if($(this).children('i').attr("class")=="icon sort ascending"||$(this).children().attr("class")=="icon sort") {
            orderBy=$(this).attr('id');
            sequence="desc";
            getInfoList(viewName,arr,currentPage,true,orderBy,sequence);
            $(this).children('i').attr("class", "icon sort descending");
            $(this).siblings().children('i').attr("class", "icon sort");
        }
        else if($(this).children('i').attr("class")=="icon sort descending") {
            orderBy=$(this).attr('id');
            sequence="";
            getInfoList(viewName,arr,currentPage,true,$(this).attr('id'),null);
            $(this).children('i').attr("class", "icon sort ascending");
            $(this).siblings().children('i').attr("class", "icon sort");
        }
    })

    //时间日期选择框初始化
    $.datetimepicker.setLocale('zh');
    $("input[datetime='true']").datetimepicker({format: 'Y-m-d H:i'});
    $("input[date='true']").datetimepicker({format: 'Y-m-d'});

    //页面初始化
    changeSize();
    bindCheck();
    $('.ui.dropdown').dropdown()/*下拉菜单初始化*/
    $(window).resize(function() {//缩放事件
        changeSize();
    });
    $('.ui.sidebar').sidebar({
        context: $('#main'),
        useLegacy:true,
        transition:'push'
    })
    $('#search,.ui.right.grey.large.corner.label').click(function () {
        $('.ui.sidebar')
            .sidebar('toggle')
    })

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
    $('.small.modal')
        .modal({
            allowMultiple: true,
            onApprove : function() {
                $('#modal').removeClass('loading');
            }
        })
        .modal('setting', 'closable', false)

    //添加列表信息到页面
    function addInfoList(arr,data,module) {
        var list=data.list;
        var html='';
        for(var i in list) {
            var head = "<tr id='" +list[i].id+"' class='center aligned'>\n" +
                "    <td>\n" +
                "    <div class='ui checkbox'>\n" +
                "    <input type='checkbox' name='item' value='"+list[i].id+"'><label></label>\n" +
                "    </div>\n" +
                "    </td>";
            var body="";
            for (var n in arr){
                for(var j in list[i]){
                    if(j==arr[n]) {
                        var text=list[i][j];
                        var selectKey=[];
                        <c:forEach items="${requestScope.fields.head}" var="myOpt" >
                        <c:if test="${myOpt.value.type=='select'}">
                        selectKey.push('${myOpt.key}');
                        <c:forEach items="${myOpt.value.opt}" var="Opt" >
                        if(text==${Opt.key}&&selectKey.indexOf(arr[n])!=-1)
                            text='${Opt.value}'
                        </c:forEach>
                        </c:if>
                        </c:forEach>
                        body += "<td class='td'>" + text + "</td>";
                    }
                }
            }
            html+=head+body+"</tr>";
        }
        $('tbody').html(html);
        $('td.td').click(function () {
            getInfo(module,$(this).parent().attr('id'));
        })
    }


    function myUpload() {
        $('#fileId').val($("input[name='id']").val());
        $('#modal').addClass('loading');
        var formData = new FormData($( "#upFile" )[0]);
        $.ajax({
            url: 'upload',
            type: 'POST',
            data: formData,
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
                if(data.msg=="success"){
                    $('#modal').removeClass('loading');
                    showToast("<i class='upload icon'></i>上传成功");
                    $('#myPicture').attr('src',"../upload/"+viewName+"/"+$("input[name='id']").val()+".jpg?"+Math.random())
                }else {
                    $('#modal').removeClass('loading');
                    showToast("<i class='remove circle outline icon'></i>"+data.msg);
                }

            },
            error: function (data) {
                $('#modal').removeClass('loading');
                showToast("<i class='warning icon'></i>连接服务器失败！");
            }
        });
    }
</script>
</html>