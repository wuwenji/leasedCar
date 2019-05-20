<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/layui/css/layui.css">
    <script src="${ctx}/static/js/jquery-3.2.1.min.js"></script>
    <script src="${ctx}/static/layui/layui.js"></script>
    <link rel="stylesheet" href="${ctx}/static/css/index.css">
    <link rel="stylesheet" href="${ctx}/static/css/platform.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
    <link rel="stylesheet" href="${ctx}/static/css/transport.css">

    <title></title>
    <style type="text/css">
        html,body{margin:0;padding:0;}
        .iw_poi_title {color:#CC5522;font-size:14px;font-weight:bold;overflow:hidden;padding-right:13px;white-space:nowrap}
        .iw_poi_content {font:12px arial,sans-serif;overflow:visible;padding-top:4px;white-space:-moz-pre-wrap;word-wrap:break-word}
        .BMap_stdMpCtrl,.anchorBL{
            display:none;
        }
        .linetd1{
            width:60%;
        }
        .linetd2{
            width:40%;
        }
        .line{
            width:100%;
            height:557px;
        }
        .tb3 td:nth-child(odd){
            text-align:right;
            width:150px;
        }
        input[name="pc"]{
            margin-right:3px;
            margin-left:5px;
            position:relative;
            top:2px;
        }
        .layui-table td, .layui-table th {

            line-height: 14px ;
        }
        .layui-table{
            margin:2px 0;
            position:relative;
        }
        textarea{
            width:100%;
        }

    </style>
    <script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=3TcwXUllHQAlCFuPynnhKpRv3A5Dg9fB"></script>
    <script type="text/javascript" src="https://api.map.baidu.com/getscript?v=2.0&ak=3TcwXUllHQAlCFuPynnhKpRv3A5Dg9fB&services=&t=20140411133140"></script>
    <script type="text/javascript" src="${ctx}/static/gis/js/MarkerTool_min.js"></script>
</head>
<body>
<form action="" class="layui-form">
    <input id="orderCode" name="orderCode" type="hidden" value="${route.orderCode}">
    <table class="line" border="1px" borderColor="#aaa">
        <tr>
            <td class="linetd1" valign="top">
                <table class="layui-table">
                    <thead>
                    <tr>
                        <th colspan="6"><b>订单详情</b></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>起始点</td>
                        <td>${route.startPoint}</td>
                        <td>目的地</td>
                        <td>${route.endPoint}</td>
                        <td>途经点</td>
                        <td>${route.viaPointStr}</td>
                    </tr>
                    <tr>
                        <td>上车时间</td>
                        <td><fmt:formatDate value="${route.boardingTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        <td>下车时间</td>
                        <td><fmt:formatDate value="${route.debusTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        <td>预估路程</td>
                        <td><fmt:formatNumber type="number" value="${route.distance/1000.0}" pattern="0.00" maxFractionDigits="2"/>(公里)</td>
                    </tr>
                    <tr>
                        <td>预估时长</td>
                        <td><fmt:formatNumber type="number" value="${route.duration/60.0}" pattern="0.00" maxFractionDigits="2"/>(分钟)</td>
                        <%--<td>订单路程</td>--%>
                        <%--<td>20公里</td>--%>
                        <%--<td>订单时长</td>--%>
                        <%--<td>25分钟</td>--%>
                    </tr>
                    <%--<tr>--%>
                        <%--<td>上车时间</td>--%>
                        <%--<td colspan="2">2018-01-03 12:00:00</td>--%>
                        <%--<td>返程时间</td>--%>
                        <%--<td colspan="2">2018-01-03 12:00:00</td>--%>
                    <%--</tr>--%>
                    </tbody>
                </table>
                <table class="layui-table">
                    <thead>
                    <tr>
                        <th colspan="4"><b>附加信息</b></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>车牌号</td>
                        <td>${route.carNum}</td>
                        <td>司机</td>
                        <td>${route.driverName}</td>
                    </tr>
                    </tbody>
                </table>
                <table class="layui-table">
                    <thead>
                    <tr>
                        <th><b>其它</b></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>是否存在偏差： <input name="deviation" <c:if test='${route.deviation != "1"}'>checked</c:if> lay-ignore type="radio" value="0">否 <input name="deviation" <c:if test='${route.deviation == "1"}'>checked</c:if> lay-ignore type="radio" value="1">是</td>
                    </tr>
                    </tbody>
                </table>
                <table class="layui-table tb3">
                    <thead>
                    <tr>
                        <th colspan="2"><b>审核详情</b></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>历史处理意见:</td>
                        <td><textarea placeholder="此处展示以往处理意见" name="" id="1" rows="2" disabled>${handlingRemark}</textarea> </td>
                    </tr>
                    <tr>
                        <td>修改意见:</td>
                        <td><textarea id="handlingRemark" name="handlingRemark" placeholder="此处为本次修改意见" rows="2"></textarea> </td>
                    </tr>
                    <tr>
                        <td>处理日期:</td>
                        <%--<td><fmt:formatDate value="${route.rCreateDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>--%>
                        <td><input id="creationDate" name="creationDate" type="text"
                                   value="<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss" />"
                                   disabled="true" style="border:none;background-color:transparent;">
                        </td>
                    </tr>
                    <tr>
                        <td>责任人:</td>
                        <%--<td>${route.responsible}</td>--%>
                        <td><input name="responsible" id="responsible" value="${username}"
                                   disabled="true" style="border:none;background-color:transparent;">
                        </td>
                    </tr>
                    <tr id="butt">
                        <td align="center" colspan="2" style="text-align:center;">
                            <a class="layui-btn layui-btn-normal submit" onclick="save();">保存</a>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </td>
            <td class="linetd2">
                <div style="width:100%;height:550px;" id="dituContent"></div>
            </td>
        </tr>
    </table>
</form>

<script src="${ctx}/static/js/layui.john.js"></script>
<script src="${ctx}/static/js/john.js"></script>
<script type="text/javascript">


    initMap();//创建和初始化地图

    $('input[name="pc"]').click(function(){
        if($(this).index() == 0){
            $(this).parents('.layui-table').next('.tb3').show()
        }
        if($(this).index() == 1){
            $(this).parents('.layui-table').next('.tb3').hide()
        }
    })
    //创建和初始化地图函数：
    function initMap(){

        createMap();//创建地图
        setMapEvent();//设置地图事件
        addMapControl();//向地图添加控件

        //根据条数判断是否隐藏保存按钮
        var row = document.getElementById("butt");
        if ('${list}' > 2) {
            row.style.display = "none";
        } else {
            row.style.display = "";
        }
    }
    //创建地图函数：
    function createMap(){

        var map = new BMap.Map("dituContent");//在百度地图容器中创建一个地图
        var point = new BMap.Point(113.0917,22.58274);//定义一个中心点坐标
        map.centerAndZoom(point,18);//设定地图的中心点和坐标并将地图显示在地图容器中
        window.map = map;//将map变量存储在全局

        var sy = new BMap.Symbol(BMap_Symbol_SHAPE_BACKWARD_OPEN_ARROW, {
            scale: 0.6,//图标缩放大小
            strokeColor: '#fff',//设置矢量图标的线填充颜色
            strokeWeight: '2',//设置线宽
        });
        var icons = new BMap.IconSequence(sy, '10', '30');
        // 创建polyline对象

        var longLatPlan = '${map.longLatPlan}';
        console.log(longLatPlan);
        var longLatPlantArray = new Array();
        var regex = /;/;

        var pois = [];

        longLatPlantArray = longLatPlan.split(regex);
        for (i = 0; i < longLatPlantArray.length; i++) {
            if (longLatPlantArray[i].length > 5) {
                var lLtArray = new Array();
                var regex = /,/;
                lLtArray = longLatPlantArray[i].split(regex);
                for (j = 0; j < lLtArray.length; j++) {
                    pois.push(new BMap.Point(lLtArray[0], lLtArray[1]));
                }

            }

        }


        var longLat = '${map.longLat}';
        console.log(longLat);
        var longLatArray = new Array();
        var regex = /;/;

        var pois1 = [];

        longLatArray = longLat.split(regex);
        for (i = 0; i < longLatArray.length; i++) {
            if (longLatArray[i].length > 5) {
                var lLtArray = new Array();
                var regex = /,/;
                lLtArray = longLatArray[i].split(regex);
                for (j = 0; j < lLtArray.length; j++) {
                    pois1.push(new BMap.Point(lLtArray[0], lLtArray[1]));
                }

            }

        }


        var polyline = new BMap.Polyline(pois, {
            enableEditing: false,//是否启用线编辑，默认为false
            enableClicking: true,//是否响应点击事件，默认为true
            icons: [icons],
            strokeWeight: '8',//折线的宽度，以像素为单位
            strokeOpacity: 0.8,//折线的透明度，取值范围0 - 1
            strokeColor: "#18a45b" //折线颜色
        });


        var polyline1 = new BMap.Polyline(pois1, {
            enableEditing: false,//是否启用线编辑，默认为false
            enableClicking: true,//是否响应点击事件，默认为true
            icons: [icons],
            strokeWeight: '8',//折线的宽度，以像素为单位
            strokeOpacity: 0.8,//折线的透明度，取值范围0 - 1
            strokeColor: "#FF00FF" //折线颜色
        });

        console.log(pois);
        console.log(pois1);
        map.addOverlay(polyline);          //增加折线
        map.addOverlay(polyline1);          //增加折线
    }
    //地图事件设置函数：
    function setMapEvent(){
        map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
        map.enableScrollWheelZoom();//启用地图滚轮放大缩小
        map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
        map.enableKeyboard();//启用键盘上下左右键移动地图
    }

    //地图控件添加函数：
    function addMapControl(){
        //向地图中添加缩放控件
        var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
        map.addControl(ctrl_nav);
        //向地图中添加缩略图控件
        // var ctrl_ove = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:1});
        // map.addControl(ctrl_ove);
        //向地图中添加比例尺控件
        var ctrl_sca = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
        map.addControl(ctrl_sca);
    }

    //保存值
    function save() {

        var creationDate = $("#creationDate").val();
        var handlingRemark = $("#handlingRemark").val();

        if (handlingRemark == '' || handlingRemark == null) {
            layui.use('layer', function () {
                var layer = layui.layer;
                layer.msg("修改意见不能为空！")
            });
            return false;
        }

        var deviation;
        var orderCode = $("#orderCode").val();

        var radio = document.getElementsByName("deviation");
        for (i = 0; i < radio.length; i++) {
            if (radio[i].checked) {
                deviation = radio[i].value;
            }
        }
        $.ajax({
            type: "post",
            url: "${ctx}/transport/route/saveRouteDetail",
            dataType: "json",
            data: {
                "creationDate": creationDate,
                "handlingRemark": handlingRemark,
                "deviation": deviation,
                "orderCode": orderCode
            },
            success: function (data) {
                if (data.state) {
                    layui.use('layer', function () {
                        var layer = layui.layer;
                        layer.alert('保存成功！', {icon: 1}, function () {
                            window.location.replace('${ctx}/sys/routeExamine?orderCode=' + orderCode);
                        });
                    });


                }
            }
        })
    }


    setInterval("setTime()", 1000);


    function setTime() {

        $("#creationDate").val(getNowFormatDate());

    }

    // 获取当前系统时间格式化为 yyyy-MM-dd HH:mm:ss
    function getNowFormatDate() {
        var date = new Date();
        var seperator1 = "-";
        var seperator2 = ":";
        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        var currentdate = year + seperator1 + month + seperator1 + strDate
            + " " + date.getHours() + seperator2 + date.getMinutes()
            + seperator2 + date.getSeconds();
        return currentdate;
    }

</script>
</body>
</html>
