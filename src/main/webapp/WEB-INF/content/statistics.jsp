<%--
  Created by IntelliJ IDEA.
  User: shichijoaria
  Date: 17-11-8
  Time: 下午5:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html style="height: 100%">
<head>
    <title>Title</title>
    <script src="<%=path%>/dist/jquery.min.js"></script>
    <script src="<%=path%>/dist/semantic.min.js"></script>
    <script src="<%=path%>/dist/echarts-all-3.js"></script>
    <link rel="stylesheet" href="<%=path%>/dist/semantic.css">
</head>
<body style="height: 100%">
<div class="ui one column grid stackable" style="height: 150%;">
        <div class="column" style="height: 50%;width:100%;">
            <div id="countTableRows" style="height: 100%;width:100%;"></div>
        </div>
        <div class="column" style="height: 50%;width:100%;">
            <div id="loginLog" style="height: 100%;width:100%;"></div>
        </div>
    <div class="column" style="height: 50%;width:100%;">
        <div id="commentAndCollection" style="height: 100%;width:100%;"></div>
    </div>


</div>
<script>
    $(document).ready(function(){
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('countTableRows'));
        // 指定图表的配置项和数据
        var option = {
            itemStyle: {
                normal: {
                    color: new echarts.graphic.LinearGradient(
                        0, 0, 0, 1,
                        [
                            {offset: 0, color: '#83bff6'},
                            {offset: 0.5, color: '#188df0'},
                            {offset: 1, color: '#188df0'}
                        ]
                    )
                },
                emphasis: {
                    color: new echarts.graphic.LinearGradient(
                        0, 0, 0, 1,
                        [
                            {offset: 0, color: '#2378f7'},
                            {offset: 0.7, color: '#2378f7'},
                            {offset: 1, color: '#83bff6'}
                        ]
                    )
                }
            },
            title: {
                text: '数据项一览'
            },
            tooltip : {
                trigger: 'item',
                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                    type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                },
                feature: {
                    saveAsImage: {
                        pixelRatio: 2
                    }
                }
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            label: {
                normal: {
                    show: true,
                    position: 'top',
                    formatter: '{c}'
                }
            },
            legend: {
                data:['数量']
            },
            xAxis: {
                data: ["管理员","出品厂商","销售商家","手机信息","用户"]
            },
            yAxis: {},
            series: [{
                name: '数量',
                type: 'bar',
                barMaxWidth:'100px',
                data: [${requestScope.statistics.countTableRows.count_admin},
                    ${requestScope.statistics.countTableRows.count_manufacturer},
                    ${requestScope.statistics.countTableRows.count_sale},
                    ${requestScope.statistics.countTableRows.count_mobile_phone},
                    ${requestScope.statistics.countTableRows.count_user}
                ],
                animationDelay: function (idx) {
                    return idx * 125;
                }
            }],
            animationEasing: 'elasticOut',
            animationDelayUpdate: function (idx) {
                return idx * 2;
            }
        };
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);

        var loginLog = echarts.init(document.getElementById('loginLog'));

        var loginLogOption = {
            title: {
                text: '最近登录数'
            },
            tooltip : {
                trigger: 'axis',
                axisPointer: {
                    type: 'cross',
                    label: {
                        backgroundColor: '#6a7985'
                    }
                },
                feature: {
                    saveAsImage: {
                        pixelRatio: 2
                    }
                }
            },
            legend: {
                data:['登录次数']
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis : [
                {
                    type : 'category',
                    boundaryGap : false,
                    data : [
                        <c:forEach items="${requestScope.statistics.loginLog}" var="bean" varStatus="stat">
                        '${bean.day}'<c:if test="${!stat.last}">,</c:if>
                        </c:forEach>
                    ]
                }
            ],
            yAxis : [
                {
                    type : 'value'
                }
            ],
            dataZoom: [{

            }, {
                type: 'inside'
            }],

            series : [
                {
                    name:'登录次数',
                    type:'line',
                    label: {
                        normal: {
                            show: true,
                            position: 'top'
                        }
                    },
                    areaStyle: {
                        normal: {
                            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                                offset: 0,
                                color: 'rgb(255, 158, 68)'
                            }, {
                                offset: 1,
                                color: 'rgb(255, 70, 131)'
                            }])
                        }
                    },
                    data:[
                        <c:forEach items="${requestScope.statistics.loginLog}" var="bean" varStatus="stat">
                        ${bean.count}<c:if test="${!stat.last}">,</c:if>
                        </c:forEach>
                    ],
                    markPoint: {
                        data: [
                            {type: 'max', name: '最大值'},
                            {type: 'min', name: '最小值'}
                        ]
                    },
                    markLine: {
                        data: [
                            {type: 'average', name: '平均值'}
                        ]
                    }
                }
            ]
        };

        loginLog.setOption(loginLogOption);

        var commentAndCollection = echarts.init(document.getElementById('commentAndCollection'));

        var commentAndCollectionOption={
            title : {
                text: '手机评论收藏一览',
                subtext: ''
            },
            tooltip : {
                trigger: 'axis'
            },
            legend: {
                data:['收藏数','评论数']
            },
            toolbox: {
                show : true,
                feature : {
                    dataView : {show: true, readOnly: false},
                    magicType : {show: true, type: ['line', 'bar']},
                    restore : {show: true},
                    saveAsImage : {show: true}
                }
            },
            calculable : true,
            xAxis : [
                {
                    type : 'category',
                    data : [
                        <c:forEach items="${requestScope.statistics.commentAndCollection}" var="bean" varStatus="stat">
                        '${bean.name}'<c:if test="${!stat.last}">,</c:if>
                        </c:forEach>
                    ]
                }
            ],
            yAxis : [
                {
                    type : 'value'
                }
            ],
            series : [
                {
                    name:'收藏',
                    type:'bar',
                    data:[
                        <c:forEach items="${requestScope.statistics.commentAndCollection}" var="bean" varStatus="stat">
                        '${bean.collection}'<c:if test="${!stat.last}">,</c:if>
                        </c:forEach>
                    ],
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大值'},
                            {type : 'min', name: '最小值'}
                        ]
                    },
                    markLine : {
                        data : [
                            {type : 'average', name: '平均值'}
                        ]
                    }
                },
                {
                    name:'评论',
                    type:'bar',
                    data:[ <c:forEach items="${requestScope.statistics.commentAndCollection}" var="bean" varStatus="stat">
                        '${bean.comment}'<c:if test="${!stat.last}">,</c:if>
                        </c:forEach>],
                    markLine : {
                        data : [
                            {type : 'average', name : '平均值'}
                        ]
                    }
                }
            ]
        };


        commentAndCollection.setOption(commentAndCollectionOption);

    });

</script>
</body>
</html>
