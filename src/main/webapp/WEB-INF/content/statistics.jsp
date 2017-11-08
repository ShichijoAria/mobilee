<%--
  Created by IntelliJ IDEA.
  User: shichijoaria
  Date: 17-11-8
  Time: 下午5:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html style="height: 100%">
<head>
    <title>Title</title>
    <script src="<%=path%>/dist/jquery.min.js"></script>
    <script src="<%=path%>/dist/semantic.min.js"></script>
    <script src="<%=path%>/dist/echarts.js"></script>
    <link rel="stylesheet" href="<%=path%>/dist/semantic.css">
</head>
<body style="height: 100%">
<div class="ui two column grid stackable"></div>
<div class="column" id="countTableRows" style="width: 100%;height: 100%;background-color: #0d71bb"></div>
<script>
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
</script>
</body>
</html>
