<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="UTF-8">
    <title>江汽报表</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/layui.css">
    <script src="${ctx}/static/js/jquery.min.js"></script>
    <script src="${ctx}/static/layui/layui.js"></script>
    <script src="${ctx}/static/dep/echarts.js"></script>
    <style>
        .johnyearmot {
            float: right;
            margin: 20px;
        }
    </style>
</head>
<body>

<div class="layui-inline johnyearmot">
    <label class="layui-form-label">日期</label>
    <div class="layui-input-inline">
        <input class="layui-input" id="yearMont" placeholder="请选择" type="text">
    </div>
</div>
<div id="lineChart" style="width:100%;height:400px;"></div>

<script>


    var nowDate = new Date();
    var Month = '${Month}';
    var year = '${year}';


    function Dayline() {


        var day = function () {
            var days = ['1日', '2日', '3日', '4日', '5日', '6日', '7日', '8日', '9日', '10日', '11日', '12日', '13日', '14日', '15日', '16日', '17日', '18日', '19日', '20日', '21日', '22日', '23日', '24日', '25日', '26日', '27', '28日', '29日', '30日', '31日']
            if (Month == 1 || Month == 3 || Month == 5 || Month == 7 || Month == 8 || Month == 10 || Month == 12) {
                return days.slice(0, 31)
            } else if (Month == 2) {
                if (year % 4 == 0) {
                    return days.slice(0, 29)
                } else {
                    return days.slice(0, 28)
                }

            } else {
                return days.slice(0, 30)
            }

        }

        var data_ = [];

        var dataJson = {"year": year, "Month": Month};

        $.ajax({
            type: "post",
            url: "${ctx}/sys/getJson",
            dataType: "json",
            data: dataJson,
            async: false,
            success: function (data) {
                data_ = data
            },
            error: function (data) {
                console.log('获取失败')
            }
        })


        var months = []

//        for(var key in data_){
//            months.push(key)
//        }


        var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']

        var avacar = data_[months[Month - 1]].availableCar; //可用车
        var ordcar = data_[months[Month - 1]].order; //订单
        var selcar = data_[months[Month - 1]].selfCar; //自营车
        var maicar = data_[months[Month - 1]].maintenanceCar; //匹配
        var completeOrder = data_[months[Month - 1]].completeOrder; //完成
        var stayOrder = data_[months[Month - 1]].stayOrder; //待出发


//图表
        var lineChart = echarts.init(document.getElementById('lineChart'));

        optionline = {
            tooltip: {
                trigger: 'axis'
            },
            legend: { //总车数                    待匹配
                data: ['总车数', '订单', '自营车', '待匹配', '完成订单', '待出发']
                //    data: ['可用车', '订单', '自营车']
            },
            toolbox: {
                show: true,
                feature: {
                    mark: {show: true},
                    magicType: {show: true, type: ['line', 'bar', 'stack', 'tiled']},

                }
            },
            calculable: true,
            xAxis: [
                {
                    type: 'category',
                    boundaryGap: false,
                    data: day()
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [
                {
                    name: '总车数',
                    type: 'line',
                    stack: '总车数',
                    data: avacar
                },
                {
                    name: '订单',
                    type: 'line',
                    stack: '总订单量',
                    data: ordcar
                },
                {
                    name: '自营车',
                    type: 'line',
                    stack: '总自营车量',
                    data: selcar
                }
                ,
                {
                    name: '待匹配',
                    type: 'line',
                    stack: '待匹配',
                    data: maicar
                },
                {
                    name: '完成订单',
                    type: 'line',
                    stack: '完成订单',
                    data: completeOrder

                }
                ,
                {
                    name: '待出发',
                    type: 'line',
                    stack: '待出发',
                    data: stayOrder

                }

            ]
        };

        lineChart.setOption(optionline, true);

    }

    // console.log(Month +'' + year)

    Dayline()


    layui.use('laydate', function () {
        var laydate = layui.laydate;
        laydate.render({
            elem: '#yearMont'
            , type: 'month'
            , change: function (value, date, endDate) {
                Month = date.month;
                year = date.year;


//                var dataJson = {"year": year, "Month": Month};

                <%--$.ajax({--%>
                <%--type: "post",--%>
                <%--url: "${ctx}/sys/getJson",--%>
                <%--dataType: "json",--%>
                <%--data: dataJson,--%>
                <%--async: false,--%>
                <%--success: function (data) {--%>


                <%--data_ = data--%>

                <%--},--%>
                <%--error: function (data) {--%>
                <%--console.log('获取失败')--%>
                <%--}--%>
                <%--})--%>

                Dayline()
            }
        });

    });

</script>


</body>

</html>
