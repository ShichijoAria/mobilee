"use strict"

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
                    for(var i in entity){
                        var choose="input[name='"+i+"']";
                        $(choose).val(entity[i]);
                        if($(choose).attr('date')=="false"||$(choose).attr('date')=="true")
                            $(choose).val(new Date(entity[i]).format('yyyy-MM-dd'));
                        if($(choose).attr('datetime')=="false"||$(choose).attr('datetime')=="true")
                            $(choose).val(new Date(entity[i]).format('yyyy-MM-dd hh:mm'));
                        var choose="select[name='"+i+"']";
                        var opt="[data-value='"+entity[i]+"']";
                        $(choose).parent().dropdown('set selected', entity[i])
                    }
                    $('#myPicture').attr('src',"../upload/"+module+"/"+entity.id+".jpg?"+Math.random())
                    $('.ui.first.modal')
                        .modal('show')
                    ;
                    changeSize();
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
    var url="/mobilee/"+module+"/list?page="+page;
    if (where){
        var inputs=$('.ui.grid.stackable.segment.three.column.vertical.container input');
        var selects=$('.ui.grid.stackable.segment.three.column.vertical.container select');
        for(var i in inputs){
            if(inputs[i].value!=undefined&&inputs[i].value!='') {
                url += "&"+inputs[i].name +'='+ inputs[i].value;
            }
        }
        for(var i in selects){
            if(selects[i].value!=undefined&&selects[i].value!='') {
                url += "&"+selects[i].name +'='+ selects[i].value;
            }
        }
    }
    if(order!=null||order!=undefined){
        url+="&orderBy="+order;
    }
    if(sequence!=null||sequence!=undefined) {
        url += "&sequence=" + sequence;
    }
    $.post(url,
        {

        },
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
        if(curPage=2)
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
            array.push(curPage + 1)
            if(curPage<total-2)
                array.push(0);
        }
        array.push(total);
    }else if(total>2){
        array.push(2);
        array.push(total);
    }else if (total>3){
        array.push(2);
        array.push(0)
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
