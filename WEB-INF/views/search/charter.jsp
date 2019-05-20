<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>租赁包车</title>
    <style>
        main {
            width: 1200px !important;
            float: none !important;
            margin-left: auto;
            margin-right: auto;
        }

        .products_list li, .title_list2 {
            width: auto !important;
        }

        .rad1, .rad2 {
            position: relative;
            top: 3px;
        }

        .div_input {
            padding: 10px 0;
        }

        .div_input_rad {
            padding-bottom: 0 !important;
        }

        .john_1 .layui-unselect {
            height: 26px;
            width: 180px;
            line-height: 20px;
        }

        .john_1 .layui-input {
            overflow: hidden;
        }

        .john_1 .layui-form-select dl {
            margin-top: -5px;
        }

        .john_1 .search_text {
            width: 50px;
        }

        .searh1 {
            overflow: visible;
        }

        .products_list_right abbr {
            width: 150px;
            text-align: right;
        }

        .products_list_right span {
            clear: both;
            top: -20px;
            right: -15px;
        }

        /*.search_text,.layui-unselect {*/
        /*border:none;*/
        /*height:35px !important;*/
        /*line-height:35px !important;*/
        /*}*/
        .searh label {
            line-height: 35px;
        }

        .container .left {
            margin-top: 20px;
        }

        #products dl dd:hover {
            background: none;
        }

        #products #tbody tr:hover {
            background-color: #ebf6ff;
        }

        .search_time2 {
            width: 155px !important;
        }
        #checkAll{
            position:relative;
            top:3px;
            margin-right:3px;
        }
        #checkbox{
            position:relative;
            top:3px;
            margin-right:3px;
        }
    </style>
    <script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=3TcwXUllHQAlCFuPynnhKpRv3A5Dg9fB"></script>
    <script type="text/javascript"
            src="https://api.map.baidu.com/getscript?v=2.0&ak=3TcwXUllHQAlCFuPynnhKpRv3A5Dg9fB&services=&t=20140411133140"></script>

</head>
<body>
<section>
    <div class="container">
        <form id="push_form" action="${ctx}/search/charter" class="layui-form" method="post">
            <input type="hidden" id="orderCode" name="orderCode" value="${order.orderCode}"/>
            <input type="hidden" id="bigOrderCode" name="bigOrderCode" value="${order.bigOrderCode}"/>
            <input type="hidden" id="viaPoint" name="viaPoint" value="${order.viaPoint}"/>
            <input type="hidden" id="viaPointApp" name="viaPointApp" value="${order.viaPointApp}">
            <input type="hidden" id="oppositeDistance" name="oppositeDistance" value="${order.oppositeDistance}">
            <input type="hidden" id="distance" name="distance" value="${order.distance}">
            <input type="hidden" id="DistanceDifference" name="DistanceDifference">
            <input type="hidden" id="DistanceDifference1" name="DistanceDifference1">
            <input type="hidden" id="duration" name="duration" value="${order.duration}">
            <input type="hidden" id="flag" name="flag" value="${order.flag}">
            <input type="hidden" id="carCode" name="carCode" value="${order.carCode}">
            <input type="hidden" id="amount" name="amount" value="">
            <input type="hidden" id="backOrderCode" name="backOrderCode" value="${order.backOrderCode}">
            <input type="hidden" id="carTypes" name="carTypes" value="${order.carTypes}">
            <input type="hidden" id="carAmounts" name="carAmounts" value="${order.carAmounts}">
            <input type="hidden" id="prices" name="prices" value="${order.prices}">
            <input type="hidden" id="AddAmount" name="AddAmount">
            <input type="hidden" id="licenseType" name="licenseType">
            <input type="hidden" id="boardingTime" name="boardingTime" value="${order.boardingTime}">
            <input type="hidden" id="trackBoardTime" name="trackBoardTime" value="${order.trackBoardTime}">


            <div id="map" style="display: none;"></div>
            <div class="searh searh-top" style="display: none;">
            </div>
            <div id="search_car_top">
                <div class="btn_df">
                    <span class="btn_df_active">单程</span>
                    <span>往返</span>
                    <input lay-ignore name="tripType" class="rad1" type="radio"
                           <c:if test="${empty order.tripType || order.tripType == 1}">checked="checked"</c:if>
                           value="1" title="单程" lay-filter="hiden"/>
                    <input lay-ignore name="tripType" class="rad2" type="radio"
                           <c:if test="${order.tripType == 2}">checked="checked"</c:if> value="2" title="返程"
                           lay-filter="show"/>
                </div>
                <div class="search_car_inline">
                    <label>上车点</label><br/>
                    <input id="startPoint" name="startPoint" value="${order.startPoint}" onclick="showMap(this);"
                           type="text" placeholder="点击在地图选点" lay-verify="required" readonly style="cursor: pointer;"
                           <c:if test="${not empty order.charterDays}">disabled</c:if>/>
                    <input type="hidden" id="startLng" name="startLng" value="${order.startLng}"/>
                    <input type="hidden" id="startLat" name="startLat" value="${order.startLat}"/>
                    <input type="hidden" id="startArea" name="startArea" value="${order.startArea}">
                    <input type="hidden" id="startCity" name="startCity" value="${order.startCity}">
                </div>
                <div class="search_car_inline">
                    <label>下车点</label><br/>
                    <input id="endPoint" name="endPoint" value="${order.endPoint}" onclick="showMap(this);" type="text"
                           placeholder="点击在地图选点" lay-verify="endPointF" readonly style="cursor: pointer;"/>
                    <input type="hidden" id="endLng" name="endLng" value="${order.endLng}"/>
                    <input type="hidden" id="endLat" name="endLat" value="${order.endLat}"/>
                    <input type="hidden" id="endArea" name="endArea" value="${order.endArea}">
                    <input type="hidden" id="endCity" name="endCity" value="${order.endCity}">
                </div>
                <div class="search_car_inline">
                    <label>上车日期</label><br/>
                    <input class=" input_date search_time search_time2" id="YMD"
                           type="text" lay-verify="boardingTimeF"
                           value="<fmt:formatDate type='date' pattern='yyyy-MM-dd' value='${order.boardingTime}'/>">
                    <label style="position:absolute;margin-top:-18px;">上车时间</label>
                    <input class="input_date search_time search_fenm" type="text" id="HHMM"/>
                </div>
                <div class="search_car_inline search_time_2">
                    <label>返程日期</label><br/>
                    <%--<input class="input_date search_time" id="trackBoardTime"  type="text" name="trackBoardTime" lay-verify=""--%>
                    <%--onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d %H:{%m-5}:%s',maxDate:'#F{$dp.$D(\'trackDebusTime\')}'})"--%>
                    <%--value="<fmt:formatDate type='date' pattern='yyyy-MM-dd HH:mm:ss' value='${order.trackBoardTime}'/>">--%>
                    <input class="input_date search_time search_time2" id="trackYMD" type="text"
                           lay-verify="trackBoardTime"
                           value="<fmt:formatDate type='date' pattern='yyyy-MM-dd' value='${order.debusTime}'/>">
                    <label style="position:absolute;margin-top:-18px;">返程时间</label>
                    <input class="input_date search_time search_fenm" type="text" id="trackHHMM"/>
                </div>

                <div class="cl"></div>
            </div>
            <div class="search_via">
                <label class="search_via_left"> 途经点：<span class="starting"></span></label>
                <div class="search_via_right">
                    <%--<div class="via_">--%>
                    <%--<input class="via_input" id="viaPoints" name="viaPoints" onclick="showMap(this);" type="text" readonly style="cursor: pointer;" placeholder="点击在地图选点"/>--%>
                    <%--<input type="hidden" id="viaLngs" name="viaLngs" value=""/>--%>
                    <%--<input type="hidden" id="viaLats" name="viaLats" value=""/>--%>
                    <%--<input type="hidden" id="viaAreas" name="viaAreas" value=""/>--%>
                    <%--<span class="icon-remove-sign"></span>--%>
                    <%--</div>--%>
                    <div class="via_ via_add">
                        <span class="icon-plus-sign via_add2"></span>
                    </div>
                    <span class="ending"></span>
                </div>
                <div class="cl"></div>
            </div>
            <%--<div class="search_via">--%>
            <%--<label class="search_via_left"> 包车天数：</label>--%>
            <%--<div class="search_via_right">--%>
            <%--<input class="via_input" style="margin-top:10px;" type="text" id="charterDays" name="charterDays"--%>
            <%--onkeyup="checkDays(this);" value="${order.charterDays}" lay-verify="charterDaysF"--%>
            <%--<c:if test="${not empty order.endPoint}">disabled</c:if>/>--%>
            <%--天--%>
            <%--</div>--%>
            <%--<div class="cl"></div>--%>
            <%--</div>--%>
            <div class="search_via car_chexing chexing1">
                <label class="search_via_left"> 车辆类型：</label>
                <div class="search_via_right">
                    <div class="layui-inline ">
                        <select name="carType" id="carType" lay-verify="required">
                            <c:forEach items="${carsTypeList}" var="carType" varStatus="vs">
                                <option value="${carType.carType}"
                                        <c:if test="${vs.index == 0}">selected="selected"</c:if>>${carType.carType}</option>
                            </c:forEach>
                        </select>
                    </div>&nbsp;<span class="icon-remove"></span>&nbsp;<div class="layui-inline john_1">
                    <input type="text" name="carAmount" value="1" class="layui-input search_text"
                           lay-verify="required|number|moreThanZero">&nbsp;辆
                </div>
                    <i class="icon-plus-sign carType-add"></i></div>
                <div class="cl"></div>
            </div>
            <div style="height:70px;" class="search_via fjxian">
                <%--<label class="search_via_left"> 附加选项：</label>--%>
                <div class="search_via_right seBtnAll">
                    <%--<div class="div_input additional_div div_dashed">--%>
                    <%--<input type="hidden" name="additional" id="additional"/>--%>
                    <%--<input type="hidden" name="additionalNumFacade" id="additionalNumFacade"/>--%>
                    <%--<input lay-ignore type="checkbox" name="additionals" value="0" id="additionals0"--%>
                    <%--lay-skin="primary" lay-filter="allChoose" onclick="addAllChoose(this);" title="不限"/> 不限&nbsp;--%>
                    <%--<input lay-ignore type="checkbox" name="additionals" value="1" id="additionals1"--%>
                    <%--lay-skin="primary" onclick="addAllChoose(this);" title="餐费"/> 餐费&nbsp;--%>
                    <%--<input lay-ignore type="checkbox" name="additionals" value="2" id="additionals2"--%>
                    <%--lay-skin="primary" onclick="addAllChoose(this);" title="住宿费"/> 住宿费&nbsp;--%>
                    <%--<input lay-ignore type="checkbox" name="additionals" value="3" id="additionals3"--%>
                    <%--lay-skin="primary" onclick="addAllChoose(this);" title="高速路费"/> 高速路费&nbsp;--%>
                    <%--<input lay-ignore type="checkbox" name="additionals" value="4" id="additionals4"--%>
                    <%--lay-skin="primary" onclick="addAllChoose(this);" title="保险"/> 保险&nbsp;--%>
                    <%--<input lay-ignore type="checkbox" name="additionals" value="5" id="additionals5"--%>
                    <%--lay-skin="primary" onclick="addAllChoose(this);" title="水"/> 水--%>
                    <%--</div>--%>
                    <%--<div class="input_add">--%>
                    <%--<div id="additionalsinput1" style="display:inline;display: none;width: 160px;"> 餐费：<input--%>
                    <%--id="input1" name="meals" class="input_add_input" onchange="initAdditionalsNum(this);"/>/份&nbsp;--%>
                    <%--</div>--%>
                    <%--<div id="additionalsinput2" style="display:inline;display: none;width: 160px;">住宿费：<input--%>
                    <%--id="input2" name="accommodation" class="input_add_input"--%>
                    <%--onchange="initAdditionalsNum(this);"/>/人&nbsp;--%>
                    <%--</div>--%>
                    <%--<div id="additionalsinput3" style="display:inline;display: none;width: 160px;">高速路费：<input--%>
                    <%--id="input3" name="highway" class="input_add_input"--%>
                    <%--onchange="initAdditionalsNum(this);"/>/人&nbsp;--%>
                    <%--</div>--%>
                    <%--<div id="additionalsinput4" style="display:inline;display: none;width: 160px;"> 保险：<input--%>
                    <%--id="input4" name="insurance" class="input_add_input"--%>
                    <%--onchange="initAdditionalsNum(this);"/>/人&nbsp;--%>
                    <%--</div>--%>
                    <%--<div id="additionalsinput5" style="display:inline;display: none;width: 160px;"> 水：<input--%>
                    <%--id="input5" name="water" class="input_add_input" onchange="initAdditionalsNum(this);"/>/瓶&nbsp;--%>
                    <%--</div>--%>
                    <%--</div>--%>
                    <a id="seBtn" href="javascript:recommendBtn(3);" class="layui-btn layui-btn-danger"
                       style="float:right;margin-left:10px;">搜索</a>
                    <button class="layui-btn layui-btn-danger" style="float:right;display: none;" lay-submit
                            lay-filter="submitBtn" id="submitBtn">发布
                    </button>

                    <!-- <button class="layui-btn layui-btn-danger" style="float:right;" type="button" onclick="submitOrder();">发布</button> -->
                </div>

                <div class="cl"></div>
            </div>
        </form>
    </div>
    <main>
        <div class="container">
            <div class="left">
                <ul class="products_list">
                    <div id="products"></div>
                    <div id="lines">
                    </div>
                    <div class="toboooknow2"></div>
                    <div id="toBookNow" class="classre pushbottom" style="display: none;">
                        <li><span id="totalPrices">总价格：￥0</span>
                            <button type="button" class="layui-btn layui-btn-danger" onclick="toBookNow();">立即预定
                            </button>
                        </li>
                    </div>
                </ul>
            </div>
            <div class="right" style="margin-top: 20px;">
                <div class="right-top">
                    <div class="right-top-font">
                        <p>
                        <h1>放心的价格</h1>多服务商比价 一口价全透明
                        </p>
                        <p>
                        <h1>放心的报务</h1>7*24小时客户服务 赔付标准有保障
                        </p>
                    </div>
                </div>
                <div class="right-two">
                    <div class="right-two-title">用车流程</div>
                    <p>网上订车</p>
                    <p>接收短信或乘车凭证</p>
                    <p>凭短信乘车凭证上车</p>
                    <p>安全送达目的地</p>
                </div>
            </div>
        </div>
    </main>
</section>
<div id="via" style="display:none;">
    <div class="via_">
        <input class="via_input" id="viaPoints" name="viaPoints" onclick="showMap(this);" type="text" readonly
               style="cursor: pointer;" placeholder="点击在地图选点"/>
        <input type="hidden" id="viaLngs" name="viaLngs" value=""/>
        <input type="hidden" id="viaLats" name="viaLats" value=""/>
        <input type="hidden" id="viaAreas" name="viaAreas" value=""/>
        <span class="icon-remove-sign via_remove"></span>
    </div>
</div>
</div>
<div id="carTypeDiv" style="display:none;">
    <div class="search_via car_chexing">
        <label class="search_via_left"> 车辆类型：</label>
        <div class="search_via_right">
            <div class="layui-inline ">
                <select name="carType" id="carType" lay-verify="required">
                    <option value="小车4座">小车4座</option>
                    <option value="小车6座">小车6座</option>
                    <option value="中巴14座" selected>中巴14座</option>
                    <option value="中巴19座">中巴19座</option>
                    <option value="大巴49座">大巴49座</option>
                    <option value="大巴50座">大巴50座</option>
                    <option value="大巴51座">大巴51座</option>
                </select>
            </div>&nbsp;<span class="icon-remove"></span>&nbsp;<div class="layui-inline john_1">
            <input type="text" name="carAmount" value="1" class="layui-input search_text"
                   lay-verify="required|number|moreThanZero">&nbsp;辆
        </div>
            <i class="icon-minus-sign icon-move"></i></div>
        <div class="cl"></div>
    </div>
</div>
<script>
    var day;
    $(function () {
        $.post('${ctx}/charter/order/checkDay', function (res) {
            day = res.day;
            console.log(day);

            layui.use('laydate', function () {
                var laydate = layui.laydate;
                var myDate = new Date().toLocaleDateString();
                lay('.search_time2,.search_yearm').each(function () {
                    laydate.render({
                        elem: this
                        , trigger: 'click'
                        , min: -0
                        , max: parseInt(res.day)
                    });
                });
            })
        })
    })

</script>
<script type="text/javascript">
    //文档加载时，把途经点加载出来
    $('document').ready(function () {
        $(document).scroll(function() {
            if ($(document).scrollTop()>=$(document).height() - $(window).height()) {
                $('.classre').removeClass('pushbottom')
                $('.toboooknow2').css('display', 'none')
            } else {
                $('.classre').addClass('pushbottom')
                $('.toboooknow2').css('display', 'block')
            }
        })
        $('.search_via .via_add').before($('#via').html());
    })
    //文档加载完毕执行
    $(function () {
        searchLines();//搜索常用线路
        /**增减途经点**/
        $("body").undelegate(); // 解除之前的绑定
        $("body").delegate(".car_chexing i.icon-move", "click", function () {  // 重新绑定
            $(this).parents('.car_chexing').remove();
        })
        $("body").delegate("span.via_remove", "click", function () {  // 重新绑定
            $(this).parents('.via_').remove();
            var startPoint = new BMap.Point($('#startLng').val(), $('#startLat').val());
            var endPoint = new BMap.Point($('#endLng').val(), $('#endLat').val());
            var viaPoint = '';
            var viaPointApp = '';
            var waypoints = [];
            $("[name='viaPoints']").each(function (index, element) {
                if ($(this).val() != null && $(this).val() != '') {
                    viaPoint = viaPoint + $(this).val() + '@' + $(this).next().val() + ',' + $(this).next().next().val() + ';';
                    viaPointApp = viaPointApp + $(this).val() + ',' + $(this).next().next().next().next().val() + '@' + $(this).next().val() + ',' + $(this).next().next().val() + ';';

                    waypoints[index] = new BMap.Point($(this).next().val(), $(this).next().next().val());
                }
            });
            $('#viaPoint').val(viaPoint);
            $('#viaPointApp').val(viaPointApp)

            if ($('#viaPoint').val() == null || $('#viaPoint').val() == '') {
                $('#DistanceDifference').val(null)
                $('#DistanceDifference1').val(null)
            } else {
                searchDistance(startPoint, endPoint);
            }
            searchLine(startPoint, endPoint, waypoints);

        });
        $('.via_ span.via_add2').click(function () {
            $('.search_via .via_add').before($('#via').html());
        })
        $('.chexing1 i.carType-add').click(function () {
            $('.fjxian').before($('#carTypeDiv').html());
            layui.use('form', function () {
                var form = layui.form;
                form.render('select');
            })
        })
        $('.searh1 i.endPoint-move').click(function () {
            $('#endPoint').val(null);
            $('#endLng').val(null);
            $('#endLat').val(null);
            $('#endArea').val(null);
            $('#endCity').val(null);
            $('#charterDays').removeAttr('disabled');
        })

        /**初始化途经点**/
        var viaPoint = $('#viaPoint').val();
        var id = $('#id').val();
        if (viaPoint != null && viaPoint != '') {
            var viaPoints = viaPoint.split(';');
            if (id != null && id != '') {
                for (var i = viaPoints.length - 1; i > -1; i--) {
                    if (viaPoints[i] != null && viaPoints[i] != '') {
                        $('.searh1 i.icon-add').parent().after($('#via').html());
                        $('#viaPoints').val(viaPoints[i].split('@')[0]);
                        $('#viaLngs').val(viaPoints[i].split('@')[1].split(',')[0]);
                        $('#viaLats').val(viaPoints[i].split('@')[1].split(',')[1]);
                    }
                }
            } else {
                for (var i = 0; i < viaPoints.length; i++) {
                    if (viaPoints[i] != null && viaPoints[i] != '') {
                        $('.searh1 i.icon-add').parent().after($('#via').html());
                        $('#viaPoints').val(viaPoints[i].split('@')[0]);
                        $('#viaLngs').val(viaPoints[i].split('@')[1].split(',')[0]);
                        $('#viaLats').val(viaPoints[i].split('@')[1].split(',')[1]);
                    }
                }
            }
        }
        //首页选取起止点的初始化
        initLenAndHour();
        //initArea();
    });


    //登陆之后触发
    function loginAfter() {
        if ($('#flag').val() == 6) {
            location.href = location.href;
        } else {
            //$('#flag').val(10);//点击搜索触发
            layer.closeAll();
            //$('#submitBtn').click()
            recommendBtn(2);

            setTimeout(function () {
                checkChange();
            }, 1000)


            //  toBookNow();
        }
    }

    //点击搜索触发
    function recommendBtn(action) {


        if ($('#YMD').val() != null && $('#YMD').val() != '') {
            //TO..
            if(action != 1){
                layer.load(1, {
                    shade: [0.1,'#fff'] //0.1透明度的白色背景
                });
            }
            var YMD = $('#YMD').val();
            var HHMM = $('#HHMM').val();
            $("#boardingTime").val(YMD + " " + HHMM + ":00")
        }


        if ($('#trackYMD').val() != null && $('#trackYMD').val() != '') {

            var trackYMD = $('#trackYMD').val();
            var trackHHMM = $('#trackHHMM').val();
            $("#trackBoardTime").val(trackYMD + " " + trackHHMM + ":00")
        }


        //解决删除途经点的问题
        viaPoint = '';
        $("[name='viaPoints']").each(function (index, element) {
            if ($(this).val() != null && $(this).val() != '') {
                viaPoint = viaPoint + $(this).val() + '@' + $(this).next().val() + ',' + $(this).next().next().val() + ';';
            }
        });
        $('#viaPoint').val(viaPoint)


        initCars();
        $('#flag').val(9);
        //点击历史路线的时候，不提交表单


        if ($("#viaPoint").val() != null && $("#viaPoint").val() != '') {
            $("#DistanceDifference").val($("#distance").val() - parseInt($("#DistanceDifference1").val()))
        }
        if (action != '1') {
            setTimeout(function () {
                $('#submitBtn').click()
            }, 200);
        }
    }

    function productsDownUp() {
        /**初始化搜索结果的折叠点击效果**/
        $('.products_list_right span i').click(function () {
            if ($(this).parents('li').next('dl')) {
                $(this).parents('li').next('dl').slideToggle()
            }
            if ($(this).attr('class') == 'icon-sort-down') {
                $(this).attr('class', 'icon-sort-up')
            } else {
                $(this).attr('class', 'icon-sort-down')
            }
        })
    }

    //选择车辆或者线路触发事件
    function checkChange() {

        var arr = $('input[name="matchs"]');
        var totalPrices = 0;
        var carCode = '';
        var backOrderCode = '';
        var prices = '';

        for (var i = 0; i < arr.length; i++) {
            if (arr[i].checked) {

                var arrs = arr[i].value.split(',');
                totalPrices += parseFloat(arrs[1]);
                carCode += arrs[0] + ',';
                prices += arrs[1] + ',';
                backOrderCode += arrs[2] + ',';
            }

            $('#totalPrices').html('总价格：￥' + (parseInt(totalPrices) + parseInt($('#AddAmount').val())));
            $('#carCode').val(carCode);
            $('#backOrderCode').val(backOrderCode);
            $('#prices').val(prices);
            $('#amount').val((parseInt(totalPrices) + parseInt($('#AddAmount').val())));
        }
    }

    //搜索车辆和回程线路
    function recommend(flg, dataJson) {
        $("#lines").html(null);
        $.ajax({
            type: "post",
            url: "${ctx}/search/searCarTypes",
            dataType: "json",
            data: dataJson,
            success: function (data) {
                $('#AddAmount').val(data.Amount);
                $('#totalPrices').html('总价格：￥' + data.Amount);
                var str = '';
                var additional = $('#additional').val();
                var charterType = $("[name='charterType']:checked").attr('title');
                var tripType = $("[name='tripType']:checked").val();
                var matchs = data.matchs;
                var isNull = true;
                if (null != matchs && matchs.length > 0) {

                    //end....
                    layer.closeAll()
                    for (i = 0; i < matchs.length; i++) {
                        var cars = matchs[i].cars;
                        <%--str += "<li><img src='${ctx}/static/images/products.png' alt=''>";--%>
                        if (returnNuber(matchs[i].carType) <= 7) {
                            str += "<li><img src='${ctx}/static/images/carPicture/1-7.jpg' alt=''>";
                        }else if(returnNuber(matchs[i].carType) <= 14 && returnNuber(matchs[i].carType) > 7) {
                            str += "<li><img src='${ctx}/static/images/carPicture/8-14.jpg' alt=''>";
                        }else if(returnNuber(matchs[i].carType) <= 28 && returnNuber(matchs[i].carType) > 14) {
                            str += "<li><img src='${ctx}/static/images/carPicture/20-28.jpg' alt=''>";
                        }else if(returnNuber(matchs[i].carType) <= 39 && returnNuber(matchs[i].carType) > 28) {
                            str += "<li><img src='${ctx}/static/images/carPicture/29-39.jpg' alt=''>";
                        }else if(returnNuber(matchs[i].carType) <= 44 && returnNuber(matchs[i].carType) > 39) {
                            str += "<li><img src='${ctx}/static/images/carPicture/40-44.jpg' alt=''>";
                        }else if(returnNuber(matchs[i].carType) <= 52 && returnNuber(matchs[i].carType) > 44) {
                            str += "<li><img src='${ctx}/static/images/carPicture/45-52.jpg' alt=''>";
                        }else if(returnNuber(matchs[i].carType) > 52) {
                            str += "<li><img src='${ctx}/static/images/carPicture/53.jpg' alt=''>";
                        }
                        str = str + "<div class='pro_title'><h1>" + matchs[i].carType + "<span style='color:#999'>（共 4 辆，可用 2 辆）</span></h1>" +
                            "<p><span class='alertspan'>最多可乘坐" + matchs[i].seatNumber +"人，<br/>含儿童！</span><span><span>" +
                            "<img onmouseover='spanShow(this)' onmouseout='spanHiden(this)' class='hoveralert' style='margin-right:5px;position:relative;top:3px;' src='${ctx}/static/images/icouser.png'>" + matchs[i].seatNumber + "</span></p></div><div class='products_list_right'>";
                        if (cars == null || cars.length < 1) {
                            str = str + "<abbr>￥0</abbr><span>(共<strong>0";
                        } else {
                            isNull = false;
                            str = str + "<abbr>￥" + cars[0].prices + "<i style='color:#000;font-size:12px;font-style:normal;'> 起</i></abbr><span>(共<strong>" + cars.length;
                        }
                        str = str + "</strong>个报价)<i class='icon-sort-down'></i></span></div></li><dl><dd><table width='100%'>";
                        str = str + '<colgroup><col width="190"><col width="150"><col width="150"><col width="150"><col width="150">';
                        str += "<thead><tr><th>服务商</th><th>特色服务</th><th>服务评价</th><th>价格</th><th><input type='checkbox' lay-ignore name='checkAll' id='checkAll'  lay-filter='checkAll' onclick='cheAll(this)' />全选</th></tr></thead><tbody id='tbody'>";
                        if (null != cars && cars.length > 0) {
                            for (j = 0; j < cars.length; j++) {
                                var value = cars[j].carCode + ',' + cars[j].prices;
                                var imgUrl = "${ctx}/search/carImg?carCode=" + cars[j].carCode;
                                if (cars[j].type == 1) {
                                    value += ',0';
                                    str = str + "<tr><td><img src='${ctx}/static/images/car1.png' title='查看车辆图片' onclick='carImg(\"" + imgUrl + "\");'><br>" + cars[j].companyName + "<br>" + cars[j].carNum + "(" + ((cars[j].carYear) / 12).toFixed(1) + "年车龄)</td><td></td>";
                                }
                                if (cars[j].type == 2) {
                                    value += ',' + cars[j].orderCode;
                                    str = str + "<tr><td><img src='${ctx}/static/images/car1.png' title='查看车辆图片' onclick='carImg(\"" + imgUrl + "\");'><br>" + cars[j].companyName + "<br>" + cars[j].carNum + "(" + ((cars[j].carYear) / 12).toFixed(1) + "年车龄)</td><td></td>";
                                }  //str + "<td>" + additional + "</td><td><a class='fen_a' href='javascript:";
                                str = str + "<td><a class='fen_a' href='javascript:";
                                if (cars[j].scoreSum != 0) {
                                    str = str + "fen(\"" + cars[j].carCode + "\")";
                                }
                                if ($('#carCode').val().indexOf(cars[j].carCode) > -1) {
                                    str = str + ";'><span class='blue fontBig'>" + cars[j].scores + "</span>/5.0分 <span class='blue'>" + cars[j].scoreSum + "条评论</span></a></td>"
                                        + "<td><span class='orange'>￥" + cars[j].prices + "</span></td><td><input type='checkbox' name='matchs' id='checkbox' value='" + value + "' onchange='checkChange()' checked=''/></td></tr>";

                                } else {
                                    str = str + ";'><span class='blue fontBig'>" + cars[j].scores + "</span>/5.0分 <span class='blue'>" + cars[j].scoreSum + "条评论</span></a></td>"
                                        + "<td><span class='orange'>￥" + cars[j].prices + "</span><br/><p style='font-size:10px;'>预订车辆可能受服务商因素进行变更，敬请留意！</p></td><td><input type='checkbox' name='matchs' id='checkbox' value='" + value + "' onchange='checkChange()' />预定</td></tr>";

                                }
                            }
                        }
                        str = str + "</tbody></table></dd></dl>";
                    }
                    //str = str + '<li><span id="totalPrices">总价格：￥0</span><button type="button" class="layui-btn layui-btn-danger" onclick="toBookNow();">立即预定</button></li>';
                }
                if (flg == 9 && isNull) {
                    //layer.msg('抱歉！ 没有找到合适的车辆或者线路', {icon: 0});
                    layer.confirm('抱歉！暂没有合适的车辆，请稍后搜索', {icon: 3, title: '提示', btn: ['确定']}, {
                        btn: function (index, layero) {
                            //按钮【按钮三】的回调
                            submitOrder();
                        }
                    });
                    if (tripType == 1 && $('#endPoint').val() != null && $('#endPoint').val() != '') {
                        seLines(dataJson);
                    }
                }
                $("#products").html(str);
                $("#toBookNow").css('display', 'block');
                productsDownUp();
                /*  layui.use('form',function(){
                     var form = layui.form;
                     form.render(); //更新全部
                 }) */
            }
        });
        //});
    }

    //没有精准车辆或者线路推荐的情况下搜索上车时间当天的空城单
    function seLines(dataJson) {
        $.ajax({
            type: "post",
            url: "${ctx}/search/searLines",
            dataType: "json",
            data: dataJson,
            success: function (data) {
                var str = '';
                var cars = data.carsList;
                if (null != cars && cars.length > 0) {
                    str = str + "<li class='recommend'><img src='${ctx}/static/images/xian1.png'><div class='pro_title'><h1>推荐路线</h1><p><span></span></p></div>";
                    str = str + "<div class='products_list_right'><abbr>￥" + cars[0].prices + "</abbr><span>(共<strong>" + cars.length + "</strong>个报价) <i class='icon-sort-down'></i></span></div></li>";
                    str = str + '<dl class="recommend_dl"><dd><table width="100%"><thead><tr><th title="查看车辆图片">车牌</th><th>车型</th><th>线路</th><th>评分</th><th>价格</th><th>预订</th></tr></thead><tbody>';
                    for (j = 0; j < cars.length; j++) {
                        var value = cars[j].carCode + ',' + cars[j].prices + ',' + cars[j].orderCode;
                        var imgUrl = "${ctx}/search/carImg?carCode=" + cars[j].carCode;
                        str = str + "<tr><td onclick='carImg(\"" + imgUrl + "\");'>" + cars[j].carNum + "</td><td>" + cars[j].carType + "</td><td>" + cars[j].startPoint + "<img src='${ctx}/static/images/zhi.png' alt=''>" + cars[j].endPoint + "</td>";
                        str = str + "<td><a class='fen_a' href='javascript:";
                        if (cars[j].scoreSum != 0) {
                            str = str + "fen(\"" + cars[j].carCode + "\")";
                        }
                        str = str + ";'><span class='blue fontBig'>" + cars[j].scores + "</span>/5分 <span class='blue'>" + cars[j].scoreSum + "条评论</span></a></td>"
                            + "<td><span class='orange'>￥" + cars[j].prices + "</span></td><td><input type='checkbox' name='matchs' id='checkbox' value='" + value + "' onchange='checkChange()'/></td></tr>";
                    }
                }
                $("#lines").html(str);
                $("#toBookNow").css('display', 'block');
                productsDownUp();
            }
        });
    }

    //查看评分评论
    function fen(carCode) {
        layer.open({
            type: 2,
            title: '用户评价',
            shadeClose: true,
            shade: 0.5,
            area: ['650px', '500px'],
            content: "${ctx}/search/evaluate?carCode=" + carCode
        })
    }

    layui.use('form', function () {
        var form = layui.form;
        form.on('radio(hiden)', function (date) {
            $('.shuang').hide('solw');
        });
        form.on('radio(show)', function (date) {
            $('.shuang').show('solw');
        });
    })

    function submitOrder() {
        $('#flag').val(0);
        $('#submitBtn').click();
    }

    function toBookNow() {

        var amount = $('#amount').val();

        if (amount == null || amount == '' || amount == 0 || amount == '0') {
            layer.msg('请选择车辆！', {icon: 0});
            return false;
        }
        var result = check({}, '${ctx}/search/checkLogin');
        if (!result) {
            layer.confirm('您还没登陆，是否现在登陆？', {icon: 3, title: '提示'}, function (index) {
                fun_loging('${ctx}/login');
            });
            return;
        }
        $('#flag').val(1);
        $('#submitBtn').click();
    }

    //加载表单
    layui.use(['form', 'element', 'laydate'], function () {
        var form = layui.form;
        /* //监听提交
      if($('#flag').val() == 10){
          $('#flag').val(9);//点击搜索触发
          setTimeout(function(){
              $('#submitBtn').click()
          }, 100);
      }else{
          $('#flag').val(6);//仅仅进行搜索
          recommend(6,"");//赶紧来页面进行第一次查询
      } */
        form.on('submit(submitBtn)', function (data) {
            //layer.msg(JSON.stringify(data.field));
            // $('#viaPoint').val(viaPoint);
            if ($('#flag').val() == 10) {
                return true;
            }
            if ($('#flag').val() == 9) {
                recommend(9, data.field);
                return false;
            }
            if ($('#flag').val() == 6) {
                recommend(6, data.field);
                return false;
            }
            var msg = '';
            if ($('#flag').val() == 0) {
                msg = '确定发布订单么？';
            }
            if ($('#flag').val() == 1) {
                //选择车辆时，选择车辆数与填写车辆数不符合时
                var str = ($('#carAmounts').val()).trim();
                var strs = new Array(); //定义一数组
                strs = str.split(","); //字符分割
                var num = 0;
                for (i = 0; i < strs.length; i++) {
                    if (strs[i] != '') {
                        num = parseInt(num) + parseInt(strs[i])
                    }
                }
                var carCode = new Array();
                carCode = ($('#carCode').val()).split(",");
                if (((carCode.length) - 1) < num) {
                    msg = '您尚有' + (parseInt(num) - parseInt((carCode.length) - 1)) + '辆车没有匹配到,我们将通知运输方进行车辆的补给，确定预定已选的车辆吗？';
                } else {
                    msg = '确定预定所选车辆么？';
                }
            }


            layer.confirm(msg, {icon: 3, title: '提示'}, function (index) {
                $.post('${ctx}/charter/order/saveOrder', data.field, function (res) {
                    if (res.state) {
                        /* layer.open({
                            icon: 1,
                            title: '信息',
                            skin: 'layer-ext-myskin',
                            shade: 0, //不显示遮罩
                            content: "操作成功！",
                            yes: function(){ */
                        if ($('#flag').val() == 0) {
                            location.reload();
                        } else if ($('#flag').val() == 1) {
                            location.href = "${ctx}/charter/order/detailRelease?bigOrderCode=" + res.bigOrderCode;
                        } else if ($('#flag').val() == 2) {
                            location.href = "${ctx}/charter/order/detailRelease?bigOrderCode=" + res.bigOrderCode;
                        }

                    } else {
                        layer.open({
                            icon: 2,
                            title: '信息',
                            skin: 'layer-ext-myskin',
                            shade: 0, //不显示遮罩
                            content: "操作失败！",
                        });
                    }
                });
            });
            return false
        });
        //自定义验证规则
        form.verify({
            //只能输入数字并且要大于零
            moreThanZero: function (value, item) {
                if (!/^[0-9]*$/.exec(value)) {
                    return "只能输入数字";
                }
                if (value < 1) {
                    return "不能小于1";
                }
            }
            ,
            //校验终点
            endPointF: function (value, item) {
                var charterDays = $('#charterDays').val();
                if (value == '' && charterDays == '') {
                    return "【终点】和【包车天数】必填其一！";
                }
            }
            ,
            //校验包车天数
            charterDaysF: function (value, item) {
                var endPoint = $('#endPoint').val();
                if (value == '' && endPoint == '') {
                    return "【终点】和【包车天数】必填其一！";
                }
                if (value != '') {
                    if (!/^[0-9]*$/.exec(value)) {
                        return "只能输入数字";
                    }
                    if (value < 1) {
                        return "不能小于1";
                    }
                }
            }
            ,
            //校验时间
            boardingTimeF: function (value, item) {

                var date1 = new Date($('#boardingTime').val());

                //  var date1 = new Date(value);

                //trackBoardTime
                if (parseInt(Math.ceil(((date1.getTime() - ('${date}')) / 60000))) < 0) {

                    return "上车时间不能低于现在的时间！";
                }


                var date1 = new Date(value);
                if (value == '') {
                    return "上车时间不能为空";
                }
                if (parseInt(Math.ceil(((date1.getTime() - (new Date)) / 60000))) > 43200) {
                    return "上车时间不能大于现在时间一个月";
                }

                var bordtime = value;
                bordtime = bordtime.replace(/[&\|\\\*:\-]/g, "");
                bordtime = bordtime.substring(bordtime.indexOf(" ") + 1, bordtime.length)

                var Starttime = '${map.ordernotsetStarttime}';
                Starttime = Starttime.replace(/[&\|\\\*:\-]/g, "");

                var Endtime = '${map.ordernotsetEndtime}';
                Endtime = Endtime.replace(/[&\|\\\*:\-]/g, "");

                if (!(parseInt(bordtime) < parseInt(Starttime)) && !(parseInt(bordtime) > parseInt(Endtime))) {

                    $('#licenseType').val("1");
                    //  return "请重新选择时间,在【${map.ordernotsetStarttime}】和【${map.ordernotsetEndtime}】 暂不发车！";
                } else {

                    $('#licenseType').val("0");
                }

            }, trackBoardTime: function (value, item) {

                if ($("input[name='tripType']:checked").val() == 2) {
                    var date1 = new Date($("#trackBoardTime").val());
                    var date2 = new Date($("#boardingTime").val());
                    var data4 = ($("#duration").val()) / 60;
                    var date3 = Math.ceil((date1.getTime() - date2.getTime()) / 60000 - data4);   //相差秒数
                    if (parseInt(date3) < 0) {
                        return "返程时间不能小于上车时间加上" + Math.ceil(data4) + "分钟预估行驶时间！";
                    } else if (parseInt(Math.ceil(((date1.getTime() - (new Date)) / 60000))) > 43200) {
                        return "返程时间不能大于现在时间一个月";
                    }
                }
            }
        });
    });

    //点击常用线路触发
    function clickLines(startPoint, startLng, startLat, startArea, startCity, endPoint, endLng, endLat, endArea, endCity) {
        $('#startPoint').val(startPoint);
        $('#startLng').val(startLng);
        $('#startLat').val(startLat);
        $('#startArea').val(startArea);
        $('#startCity').val(startCity);
        $('#endPoint').val(endPoint);
        $('#endLng').val(endLng);
        $('#endLat').val(endLat);
        $('#endArea').val(endArea);
        $('#endCity').val(endCity);
        initLenAndHour();
        setTimeout(function () {
            recommendBtn(1);
        }, 500);
        $('#charterDays').val('');
        $('#charterDays').attr('disabled', 'disabled');
    }

    //搜索常用线路
    function searchLines() {
        var shiroUser = '<shiro:principal/>';
        if (shiroUser != null && '' != shiroUser) {
            $.ajax({
                type: "post",
                url: "${ctx}/search/lines",
                dataType: "json",
                data: {},
                success: function (data) {
                    var hisLines = '';
                    var colLines = '';
                    if (null != data.hisLines && data.hisLines.length > 0) {
                        hisLines = hisLines + "<p id='hisLines'><img src='${ctx}/static/images/hos.png' alt=''> ：";
                        for (i = 0; i < data.hisLines.length; i++) {
                            hisLines = hisLines + "<a href='javascript:clickLines(\"" + data.hisLines[i].startPoint + "\",\"" + data.hisLines[i].startLng + "\",\"" + data.hisLines[i].startLat + "\",\"" + data.hisLines[i].startArea + "\",\""
                                + data.hisLines[i].startCity + "\",\"" + data.hisLines[i].endPoint + "\",\"" + data.hisLines[i].endLng + "\",\"" + data.hisLines[i].endLat + "\",\"" + data.hisLines[i].endArea + "\",\"" + data.hisLines[i].endCity + "\");'> ";
                            hisLines = hisLines + data.hisLines[i].startPoint + " <i class='icon-exchange'></i> " + data.hisLines[i].endPoint + " </a>";
                        }
                        hisLines = hisLines + "</p><br/>";
                    }
                    if (null != data.colLines && data.colLines.length > 0) {
                        colLines = colLines + "<p id='colLines'><img src='${ctx}/static/images/sc.png' alt=''> ：";
                        for (i = 0; i < data.colLines.length; i++) {
                            colLines = colLines + "<a href='javascript:clickLines(\"" + data.colLines[i].startPoint + "\",\"" + data.colLines[i].startLng + "\",\"" + data.colLines[i].startLat + "\",\"" + data.colLines[i].startArea + "\",\""
                                + data.colLines[i].startCity + "\",\"" + data.colLines[i].endPoint + "\",\"" + data.colLines[i].endLng + "\",\"" + data.colLines[i].endLat + "\",\"" + data.colLines[i].endArea + "\",\"" + data.colLines[i].endCity + "\");'> ";
                            colLines = colLines + data.colLines[i].startPoint + " <i class='icon-exchange'></i> " + data.colLines[i].endPoint + " </a>";
                        }
                        colLines = colLines + "</p><br/>";
                    }
                    var str = '';
                    if (hisLines != '' || colLines != '') {
                        $('.searh-top').css('display', 'block');
                        if (hisLines != '' && colLines != '') {
                            str += hisLines + '<br/>' + colLines;
                        } else {
                            str += hisLines + colLines;
                        }
                    }
                    $('.searh-top').html(str);
                }
            });
        }
    }

    //附加选项全选
    function addAllChoose(obj) {
        if ($(obj).val() == 0) {

            var num = 1
            $('.additional_div input[type="checkbox"]').each(function () {
                $(this).prop('checked', $(obj).prop('checked'));

                //根据id显示对应的附加项的数量输入框
                if (num < 6) {
                    document.getElementById("additionalsinput" + num).setAttribute("style", "display:inline;width: 160px;")
                    document.getElementById("input" + num).setAttribute("lay-verify", "required")
                }
                num++;
            });

        } else {

            if (!$(obj).prop('checked')) {
                $('#additionals0').prop('checked', false);
                //    $('#mealsL').attr("style","display:none;")
            }
        }
        // alert($('#additionals0').checked == true)
        initAdditionals();
        initAdditionalsNum();
    }

    //附加选项点击事件
    function initAdditionals() {

        var additional = '';

        $("[name='additionals']").each(function (index, element) {
            if (index > 0 && document.getElementById("additionals" + $(this).val()).checked == true) {
                additional = additional + document.getElementById("additionals" + $(this).val()).title + " ";
                //  AdditionalNumFacade = AdditionalNumFacade + document.getElementById("input" + $(this).val()).value+",";
                //显示对应的附加项的数量输入框，并设置为必填项
                document.getElementById("additionalsinput" + $(this).val()).setAttribute("style", "display:inline;width: 160px;")
                document.getElementById("input" + $(this).val()).setAttribute("lay-verify", "required")
            } else {
                if (index > 0) {
                    //隐藏对应的附加项的数量输入框
                    document.getElementById("additionalsinput" + $(this).val()).setAttribute("style", "display:inline;display: none;width: 160px;")
                    document.getElementById("input" + $(this).val()).setAttribute("lay-verify", "")
                    document.getElementById("input" + $(this).val()).value = '';
                }
            }
        });
        $('#additional').val(additional);
    }

    function initAdditionalsNum() {
        var additionalNumFacade = '';
        $("[name='additionals']").each(function (index, element) {
            if (index > 0 && document.getElementById("input" + $(this).val()).value != '') {
                additionalNumFacade = additionalNumFacade + document.getElementById("input" + $(this).val()).value + ",";

            }
        })


        $('#additionalNumFacade').val(additionalNumFacade);
    }

    //初始化车型和数量
    function initCars() {
        var carTypes = '';
        var len = $("[name='carType']").length;
        $("[name='carType']").each(function (index, element) {
            if (index + 1 != len)
                carTypes += $(this).val() + ','
        });
        $('#carTypes').val(carTypes);
        var carAmounts = '';
        var lens = $("[name='carAmount']").length;
        $("[name='carAmount']").each(function (index, element) {
            if (index + 1 != lens)
                carAmounts += $(this).val() + ','
        });
        $('#carAmounts').val(carAmounts);
    }

    //计算起始点的路程和时间
    function initLenAndHour() {
        if (($('#startPoint').val() != null && $('#startPoint').val() != '') && ($('#endPoint').val() != null && $('#endPoint').val() != '')) {
            var startPoint = new BMap.Point($('#startLng').val(), $('#startLat').val());
            var endPoint = new BMap.Point($('#endLng').val(), $('#endLat').val());
            var viaPoint = '';
            var viaPointApp = '';
            var waypoints = [];
            $("[name='viaPoints']").each(function (index, element) {
                if ($(this).val() != null && $(this).val() != '') {
                    viaPoint = viaPoint + $(this).val() + '@' + $(this).next().val() + ',' + $(this).next().next().val() + ';';
                    viaPointApp = viaPointApp + $(this).val() + ',' + $(this).next().next().next().next().val() + '@' + $(this).next().val() + ',' + $(this).next().next().val() + ';';

                    waypoints[index] = new BMap.Point($(this).next().val(), $(this).next().next().val());
                }
            });
            $('#viaPoint').val(viaPoint);
            $('#viaPointApp').val(viaPointApp);
            searchLine(startPoint, endPoint, waypoints);

            if (viaPoint != null && viaPoint != '') {
                searchDistance(startPoint, endPoint)
            } else {
                $('#DistanceDifference').val(null);
                $('#DistanceDifference1').val(null);
            }
        }
    }

    //检测包车天数
    function checkDays(obj) {
        if ($(obj).val() != '') {
            $('#endPoint').attr('disabled', 'disabled');
        } else {
            $('#endPoint').removeAttr('disabled');
        }
    }

    function cheAll(obj) {
        if (!$(obj).prop('checked')) {
            $(obj).parents('thead').next('tbody').find('input[type="checkbox"]').each(function () {

                $(this).prop('checked', false);

                var arr = document.getElementsByName("matchs");
                var totalPrices = 0;
                var carCode = '';
                var backOrderCode = '';
                var prices = '';
                for (i = 0; i < arr.length; i++) {
                    if (arr[i].checked) {
                        var arrs = arr[i].value.split(',');
                        totalPrices += parseFloat(arrs[1]);
                        carCode += arrs[0] + ',';
                        prices += arrs[1] + ',';
                        backOrderCode += arrs[2] + ',';
                    }
                    $('#totalPrices').html('总价格：￥' + (parseInt(totalPrices) + parseInt($('#AddAmount').val())));
                    $('#carCode').val(carCode);
                    $('#backOrderCode').val(backOrderCode);
                    $('#prices').val(prices);
                    $('#amount').val((parseInt(totalPrices) + parseInt($('#AddAmount').val())));
                }


            })
        } else {
            $(obj).parents('thead').next('tbody').find('input[type="checkbox"]').each(function () {
                $(this).prop('checked', $(obj).prop('checked'));
            })

            var arr = document.getElementsByName("matchs");
            var totalPrices = 0;
            var carCode = '';
            var backOrderCode = '';
            var prices = '';
            for (i = 0; i < arr.length; i++) {
                if (arr[i].checked) {
                    var arrs = arr[i].value.split(',');
                    totalPrices += parseFloat(arrs[1]);
                    carCode += arrs[0] + ',';
                    prices += arrs[1] + ',';
                    backOrderCode += arrs[2] + ',';
                }
                $('#totalPrices').html('总价格：￥' + (parseInt(totalPrices) + parseInt($('#AddAmount').val())));
                $('#carCode').val(carCode);
                $('#backOrderCode').val(backOrderCode);
                $('#prices').val(prices);
                $('#amount').val((parseInt(totalPrices) + parseInt($('#AddAmount').val())));
            }

        }
    }


    //弹出地图窗口
    function showMap(obj) {

        var url = encodeURI('${ctx}/search/map?'
            + 'site=' + $(obj).val()
            + '&lng=' + $(obj).next().val()
            + '&lat=' + $(obj).next().next().val()
            + '&area=' + $(obj).next().next().next().val()
            + '&city=' + $(obj).next().next().next().next().val());

        obj.blur();
        layer.open({
            type: 2,
            title: "请搜索地点",
            shadeClose: false,
            shade: 0.5,
            /*  shift:-1, */
            area: ['570px', '490px'],
            content: url,
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                setTimeout(function () {
                    var body = layer.getChildFrame('body', index);
                    if (body.find('#site').val() != '') {
                        var province = body.find('#province').val()
                        if (province != "广东省" && province != "海南省" && province != "江西省" && province != "湖南省" && province != "福建省" && province != "广西壮族自治区") {
                            layer.msg("该省份暂时无法选择，请重新选取地点！")
                            return false;
                        } else {
                            $(obj).val(body.find('#site').val());
                            $(obj).next().val(body.find('#lng').val());
                            $(obj).next().next().val(body.find('#lat').val());
                            $(obj).next().next().next().val(body.find('#area').val());
                            $(obj).next().next().next().next().val(body.find('#city').val());

                            if (obj.id == 'endPoint') {
                                $('#charterDays').attr('disabled', 'disabled');
                            }
                            initLenAndHour();
                        }

                    }
                    layer.close(index); //再执行关闭
                }, 500);
            },
            btn2: function (index, layero) {
            },
            cancel: function (index, layero) {
            }
        })
    }


    //首页选取起止点的初始化
    function initArea() {
        var gc = new BMap.Geocoder();
        if ('${area.startArea}' != null && '${area.startArea}' != '') {
            function mySFun() {
                var pp = localS.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
                gc.getLocation(pp, function (rs) {
                    var addComp = rs.addressComponents;
                    var address = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
                    $('#startArea').val(addComp.district);
                    $('#startCity').val(addComp.city);
                });
                $('#startPoint').val('${area.startArea}');
                $('#startLng').val(pp.lng);
                $('#startLat').val(pp.lat);
            }

            var localS = new BMap.LocalSearch(map, { //智能搜索
                onSearchComplete: mySFun
            });
            localS.search('${area.startArea}');
        }
        if ('${area.endArea}' != null && '${area.endArea}' != '') {
            function myEFun() {
                var pp = localE.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
                gc.getLocation(pp, function (rs) {
                    var addComp = rs.addressComponents;
                    var address = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
                    $('#endArea').val(addComp.district);
                    $('#endCity').val(addComp.city);
                });
                $('#endPoint').val('${area.endArea}');
                $('#endLng').val(pp.lng);
                $('#endLat').val(pp.lat);
            }

            var localE = new BMap.LocalSearch(map, { //智能搜索
                onSearchComplete: myEFun
            });
            localE.search('${area.endArea}');
        }
    }

    //地图加载》》》》》》start
    var xPoint = 0;
    var yPoint = 0;

    //创建地图实例
    var map = new BMap.Map("map");

    //创建点坐标
    var point = new BMap.Point(xPoint, yPoint);

    var markers = [];//标注数组

    //初始化地图，设置中心点坐标和地图级别
    map.centerAndZoom(point, 13);
    //添加默认比例尺控件
    map.addControl(new BMap.ScaleControl());
    //滚轮缩放事件
    map.enableScrollWheelZoom();
    //开启连续缩放效果
    map.enableContinuousZoom();
    //地图加载》》》》》》end

    //获取线路规划
    function searchLine(startPoint, endPoint, waypoints) {
        var route = 0;
        var driving = new BMap.DrivingRoute(map, {
            renderOptions: {map: map, enableDragging: false},
            onSearchComplete: searchComplete,
            policy: route
        });
        map.clearOverlays();
        driving.search(startPoint, endPoint, {waypoints: waypoints});//waypoints表示途经点
    }

    var searchComplete = function (results) {
        var plan = results.getPlan(0);
        var lineLength = plan.getDistance(true);
        var lineNeedHours = plan.getDuration(true);
        $("#distance").val(plan.getDistance(false));
        $("#duration").val(Math.ceil(plan.getDuration(false) * 1.15));
        $("#oppositeDistance").val(plan.getDistance(false));
    };

    function searchDistance(startPoint, endPoint) {

        var route = 0;
        var driving = new BMap.DrivingRoute(map, {
            renderOptions: {map: map, enableDragging: false},
            onSearchComplete: searchComplete1,
            policy: route
        });
        driving.search(startPoint, endPoint);//waypoints表示途经点
    }

    var searchComplete1 = function (results) {
        var plan = results.getPlan(0);

        var lineLength = plan.getDistance(false);
        var lineNeedHours = plan.getDuration(true);

        //console.log(plan.getDistance(false))
        if ($("#viaPoint").val() != null && $("#viaPoint").val() != '') {
            $("#DistanceDifference1").val(parseInt(plan.getDistance(false)));
        }
    };
    function spanShow(ele) {
        var dom = $(ele).parent().parent().prev('.alertspan')
        dom.show()
    }
    function spanHiden(ele) {
        var dom = $(ele).parent().parent().prev('.alertspan')
        dom.hide()
    }
    function returnNuber(str) {
        return str.replace(/[^\d.]/g,'')
    }
</script>
</body>
</html>