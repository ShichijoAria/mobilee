"use strict"

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
function getInfoList(module,arr,param,url) {
    $.post("/mobilee/"+module+"/list?page="+param+url,
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

function getList(page) {
    currentUrl='';
    var inputs=$('.ui.grid.stackable.segment.three.column.vertical.container input');
    var selects=$('.ui.grid.stackable.segment.three.column.vertical.container select');
    for(var i in inputs){
        if(inputs[i].value!=undefined&&inputs[i].value!='') {
            currentUrl += "&"+inputs[i].name +'='+ inputs[i].value;
        }
    }
    for(var i in selects){
        if(selects[i].value!=undefined&&selects[i].value!='') {
            currentUrl += "&"+selects[i].name +'='+ selects[i].value;
        }
    }
    getInfoList(viewName,arr,page,currentUrl);
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
            getList($(this).attr('page'));
        }
    });
}

//全选或取消全选
function bindCheck() {
    $('#checkAll').click(function () {
        $("input[name='item']").prop('checked',$(this)[0].checked);
    });
}
