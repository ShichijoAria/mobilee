"use strict"

//通用功能初始化
function init() {
    $('#saveEntity').click(function () {
        $('#modal').addClass('loading');
        $.post("/mobilee/"+viewName+"/save?"+serializeNotNull($('#modal').serialize()),
            function (data, status) {
                if (status != "success") {
                    showToast("<i class='warning icon'></i>连接服务器失败！");
                }else {
                    if(data.msg=="success"){
                        showToast("<i class='archive icon'></i>保存成功");
                        getInfoList(viewName, arr, currentPage,true,orderBy,sequence);
                        $("input[name='edition']").val(Number($("input[name='edition']").val())+1);
                    }else {
                        showToast("<i class='remove circle outline icon'></i>"+data.msg);
                    }
                }
            });
    });
}

//表单序列化排空
function serializeNotNull(serStr){
    return serStr.split("&").filter(function(str){return !str.endsWith("=")}).join("&");
}


//semantic-ui 表单验证ajax实现
function showError(arr) {
    $('.ui.error.message').css("display","none");
    $('ul.list').empty();
    for(var i in arr){
        var html="<li>"+arr[i]+"</li>";
        $('ul.list').append(html);
    }
    $('.ui.error.message').css("display","block");
}

function getInfo(module,id) {
    $('form').addClass('loading');
    $.post("/mobilee/"+module+"/info?id="+id,
        {

        },
        function (data, status) {
            $('form').removeClass('loading');
            if (status != "success") {
                //showError(["无法连接服务器"]);
            }else {
                if(data.msg=="success"){
                    var entity=data.entity;
                    if(entity!=null) {
                        for (var i in entity) {
                            jsonToForm(i, entity[i])
                            if (entity[i] != null && typeof(entity[i]) == "object") {
                                for (var j in entity[i]) {
                                    jsonToForm(i + '.' + j, entity[i][j])
                                }
                            }
                        }
                        $('#myPicture').attr('src', "../upload/" + module + "/" + entity.id + ".jpg?" + Math.random())
                        $('.ui.first.modal')
                            .modal('show')
                        ;
                        $('.ui.medium.bordered.circular.image')
                            .popup()
                        ;
                        changeSize();
                    }
                }else {

                }
            }
        });
}

//显示反馈信息
function showToast(html) {
    $('.ui.small.modal .ui.icon.header').html(html);
    $('.ui.small.modal').modal('show');
}

//获取列表信息
/*
* module viewName
* arr tableHead
* page 请求的页码
* where 查询条件是否开启
* order 排序字段
* sequence 正序倒序
* */
function getInfoList(module,arr,page,where,order,sequence) {
    var url="/mobilee/"+module+"/list?page="+page+"&";
    if (where){
        url+=serializeNotNull($('#searchForm').serialize());
    }
    if(order!=null||order!=undefined){
        url+="&orderBy="+order;
    }
    if(sequence!=null||sequence!=undefined) {
        url += "&sequence=" + sequence;
    }
    $.post(url, {},
        function (data, status) {
            $('form').removeClass('loading');
            if (status != "success") {
                showError(["无法连接服务器"]);
            }else {
                if(data.msg=="success"){
                    $('tbody')
                        .transition({
                            animation  : 'fade',
                            onComplete:function () {
                                addInfoList(arr,data,module);
                                generatePagination(data.total,data.page,module)
                                var select="a[page='"+data.page+"']";
                                currentPage=data.page;
                                $(select).addClass('active');
                            }
                        })
                    ;
                    $('tbody')
                        .transition({
                            animation: 'fade',
                            onComplete: function () {

                            }
                        });
                }else {

                }
            }
            $('#segment').removeClass('loading');
        });
}

function changeSize() {
    $('#myPicture').outerHeight($('#myPicture').outerWidth());
    $('form').outerWidth($('body').width())
    $('#foot').width($('body').width())
    $('.ui.input').outerWidth($('input').outerWidth())
    $('.ui.grid.stackable.centered.segment.three.column.vertical.container').outerWidth($('form').outerWidth())
}

//生成分页菜单
function generatePagination(total,curPage,viewName) {
    var array=[1];
    if(total<=0){
        array.pop();
    }else if(curPage<total&&curPage>1){
        if(curPage==2)
            array.push(2);
        if(curPage>2) {
            if(curPage>3) {
                array.push(0);
            }
            array.push(curPage - 1)
        }
        if(curPage!=total-1) {
            if(curPage!=2)
                array.push(curPage);
            array.push(curPage + 1);
            if(curPage<total-2) {
                array.push(0);
            }
        }else {
            array.push(curPage);
        }
        array.push(total);
    }else if(total==3){
        array.push(2);
        array.push(total);
    }else if (total>3){
        array.push(2);
        array.push(0)
        array.push(total-1)
        array.push(total);
    }else if(total==2){
        array.push(2);
    }
    var html=array.map(pageItem).join('');
    $('#pagination').html(html);
    bind(viewName);
}

function pageItem(i) {
    if(i>0)
        return "<a class='item' page='"+i+"'>"+i+"</a>";
    return "<div class='disabled item'>...</div>";
}

function bind(viewname) {
    $('a.item').click(function () {
        if($(this).attr('page')!=undefined) {
            getInfoList(viewName,arr,$(this).attr('page'),true,orderBy,sequence);
        }
    });
}

//全选或取消全选
function bindCheck() {
    $('#checkAll').click(function () {
        $("input[name='item']").prop('checked',$(this)[0].checked);
    });
}

Date.prototype.format = function(format) {
    var date = {
        "M+": this.getMonth() + 1,
        "d+": this.getDate(),
        "h+": this.getHours(),
        "m+": this.getMinutes(),
        "s+": this.getSeconds(),
        "q+": Math.floor((this.getMonth() + 3) / 3),
        "S+": this.getMilliseconds()
    };
    if (/(y+)/i.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
    }
    for (var k in date) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1
                ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
        }
    }
    return format;
}


function jsonToForm(key,value) {
    var choose="#modal input[name='"+key+"']";
    $(choose).val(value);
    if($(choose).attr('date')=="false"||$(choose).attr('date')=="true")
        $(choose).val(new Date(value).format('yyyy/MM/dd'));
    if($(choose).attr('datetime')=="false"||$(choose).attr('datetime')=="true")
        $(choose).val(new Date(value).format('yyyy/MM/dd hh:mm'));
    choose="#modal textarea[name='"+key+"']";
    $(choose).val(value);
    choose="select[name='"+i+"']";
    var opt="[data-value='"+value+"']";
    $(choose).parent().dropdown('set selected', value)

    if(value!=null&&typeof(value)=='object'){
        for(var jsonI in value){
            choose="select[name='"+key+"."+jsonI+"']";
            var opt="[data-value='"+value+"']";
            $(choose).parent().dropdown('set selected', value[jsonI]);
        }
    }
}

