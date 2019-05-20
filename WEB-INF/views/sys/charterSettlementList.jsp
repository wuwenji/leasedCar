<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>包车方订单情况</title>
</head>
<body>

<form id="searchForm" class="layui-form" action="${ctx}/sys/charter/settlement" method="post">
    <input type="hidden" name="pageNum" id="pageNum" value="${order.pageNum}"/>
    <input type="hidden" name="pageSize" id="pageSize" value="${order.pageSize}"/>
    <input type="hidden" id="order" name="order" value="${order.order}"/>
    <input type="hidden" id="sortType" name="sortType" value="${order.sortType}"/>


    <input type="hidden" id="orderCodeSe" name="orderCodeSe" value="${order.orderCodeSe}"/>
    <input type="hidden" id="searchPlace" name="searchPlace" value="${order.searchPlace}"/>
    <input type="hidden" id="carType" name="carType" value="${order.carType}"/>
    <input type="hidden" id="driverName" name="driverName" value="${order.driverName}"/>
    <input type="hidden" id="linkMan" name="linkMan" value="${order.linkMan}"/>
    <input type="hidden" id="searchType" name="searchType" value="0">

    <input type="hidden" id="dowloadExcel" name="dowloadExcel" value="${order.dowloadExcel}"/>

    <%--<div class="button_left">--%>
        <%--<label class="layui-form-label">订单类型:</label>--%>
        <%--<div class="layui-input-block">--%>
            <%--<input type="radio" name="paymentStatus" value="3" title="应收款"--%>
                   <%--<c:if test="${order.paymentStatus == 3}">checked</c:if> lay-filter="companyType">--%>
            <%--<input type="radio" name="paymentStatus" value="2" title="已收款 "--%>
                   <%--<c:if test="${order.paymentStatus == 2}">checked</c:if> lay-filter="companyType">--%>
            <%--<input type="radio" name="paymentStatus" value="1" title="未收款"--%>
                   <%--<c:if test="${order.paymentStatus == 1}">checked</c:if> lay-filter="companyType">--%>
        <%--</div>--%>
    <%--</div>--%>
    <div class="cl"></div>
    <div class="button_right1 john-edge">
        <div class="layui-inline">
            <label class="layui-form-label">上车时间:</label>
            <div class="layui-input-inline" style="top: 5px;">
                <input class="layui-input search_text input_date" id="beginTime" name="beginTime" type="text"
                       value='<fmt:formatDate value="${order.beginTime}" pattern="yyyy-MM-dd"/>'/>_
            </div>
            <div class="layui-input-inline" style="top: 5px;">
                <input class="layui-input search_text input_date" id="endTime" name="endTime" type="text"
                       value='<fmt:formatDate value="${order.endTime}" pattern="yyyy-MM-dd"/>'/>
            </div>
        </div>
        <%--<div class="layui-inline">--%>
            <%--<select name="status" id="status">--%>
                <%--<option value="">订单状态</option>--%>
                <%--<option value="1" <c:if test="${order.status == 1}">selected="selected"</c:if>>等待上车--%>
                <%--</option>--%>
                <%--<option value="2" <c:if test="${order.status == 2}">selected="selected"</c:if>>在途--%>
                <%--</option>--%>
                <%--<option value="3" <c:if test="${order.status == 3}">selected="selected"</c:if>>完成--%>
                <%--</option>--%>
            <%--</select>--%>
        <%--</div>--%>

        <div class="layui-inline">
            <%-- <input type="text" name="orderCodeSe" value="${order.orderCodeSe}" class="layui-input" placeholder="请输订单号"> --%>
            <a class="layui-btn layui-btn-danger layui-btn-small" href="javascript:selfSubmit();">搜索</a>
            <button type="button" class="layui-btn layui-btn-small" onclick="exportExcel();" lay-submit=""
                    lay-filter="demo1">导出Execl
            </button>
        </div>
        <div class="cl">
        </div>
        <label class="layui-form-label">查询内容选项:</label>
        <div class="layui-inline">
            <select name="dim" id="dim" lay-filter="dim">
                <option value="0"
                        <c:if test="${order.orderCodeSe != null and order.orderCodeSe !=''}">selected="selected"</c:if>>订单号
                </option>
                <option value="1"
                        <c:if test="${order.searchPlace != null and order.searchPlace !=''}">selected="selected"</c:if>>地点
                </option>
                <option value="2"
                        <c:if test="${order.carType != null and order.carType !=''}">selected="selected"</c:if>>车辆
                </option>
                <option value="3"
                        <c:if test="${order.driverName != null and order.driverName !=''}">selected="selected"</c:if>>司机
                </option>
                <option value="4"
                        <c:if test="${order.linkMan != null and order.linkMan !=''}">selected="selected"</c:if>>购买人
                </option>
            </select>
        </div>
        <div class="layui-inline">
            <input class="search_text" id="dimValue" name="dimValue" type="text"
                   style="cursor: pointer;" placeholder="输入查询内容"/>
        </div>
    </div>
    <div class="cl"></div>
    <div class="layui-form">
        <table class="layui-table">
            <thead>
            <tr>
                <th>序号</th>
                <th>订单号</th>
                <th>结算单号</th>
                <th>路线</th>
                <th>开始时间</th>
                <th>结束时间</th>
                <th>司机</th>
                <th>订单金额</th>
                <th>是否记账</th>
                <th>记账支付情况</th>
                <%--<th>操作</th>--%>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${orders.list}" var="orders" varStatus="vs">
                <tr>
                    <td>${vs.index+1}</td>
                    <td>${orders.orderCode}</td>
                    <td>${orders.billOrderCode}</td>
                    <td>${orders.startPoint} - ${orders.endPoint}</td>
                    <td>
                        <fmt:formatDate value="${orders.boardingTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td>
                        <fmt:formatDate value="${orders.debusTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                    <td>${orders.driverName}</td>
                    <td>${orders.amount}</td>
                    <td>
                        <c:choose>
                        <c:when test="${orders.paymentType == 1}">否</c:when>
                        <c:when test="${orders.paymentType == 2}">是</c:when>
                        </c:choose>
                    <td>
                        <%--<c:choose>--%>
                        <%--<c:when test="${orders.settlement == 1}">未结算</c:when>--%>
                        <%--<c:when test="${orders.settlement == 2}">已结算</c:when>--%>
                        <%--</c:choose>--%>
                            <c:choose>
                                <c:when test="${orders.billStatus != null}">
                                    <c:choose>
                                        <c:when test="${orders.billStatus == 3}">已结算</c:when>
                                        <c:when test="${orders.billStatus == 2}">结算中</c:when>
                                        <c:otherwise>未结算</c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${orders.settlement == 1}">未结算</c:when>
                                        <c:when test="${orders.settlement == 2}">已结算</c:when>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                    </td>
                    <%--<td>--%>
                        <%--<c:choose>--%>
                        <%--<c:when test="${orders.paymentStatus == 1}">--%>
                            <%--<!-- <input type="button" style="float:right;margin-top:0px;" id="payBtn"--%>
                            <%--onclick="releaseDetailSubmit('${orders.orderCode}','${orders.bigOrderCode}','${orders.linkMan}','${orders.amount}','${orders.prices}','${orders.linkPhone}');"--%>
                            <%--class="layui-btn layui-btn-danger layui-btn-mini" value="立即支付"/></td> -->--%>
                        <%--</c:when>--%>
                        <%--<c:when test="${orders.paymentStatus == 2}">--%>
                        <%--<input type="button" style="float:right;margin-top:0px;" id="payBtn"--%>
                               <%--class="layui-btn layui-btn-danger layui-btn-mini" value="已支付"/>--%>
                        <%--</c:when>--%>
                        <%--</c:choose>--%>
                    <%--</td>--%>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <tags:page pages="${orders}"/>
</form>


<script type="text/javascript">
    layui.use('laydate', function() {
        var laydate = layui.laydate;
        lay('.input_date').each(function(){
            laydate.render({
                elem: this
                ,trigger: 'click'
            });
        });
    })
    function exportExcel() {


        layui.use(['form'], function () {

            var form = layui.form;
            //监听提交


            form.on('submit(demo1)', function (data) {
                $("#dowloadExcel").val("1");

                $("#searchForm").submit();
                return false;
            });
        })
    }


    var radiovaLue;
    layui.use(['form', 'element', 'laydate'], function () {

        var form = layui.form;

        form.on('radio(companyType)', function (data) {
            $("#dowloadExcel").val("2");
            //console.log(data.elem); //得到radio原始DOM对象
            //console.log(data.value); //被点击的radio的value值
            var type = '${order.settlement}';
            if (type != data.value) {
                $("[name='pageNum']").val(1);//第一页
            }
            selfSubmit();

        });
    });


    //搜索框的状态记忆
    var selectValue = $("#dim").val();
    if (selectValue == null && selectValue == '') {
        selectValue = '0';
    }
    layui.use('form', function () {

        var form = layui.form;


        //各种基于事件的操作，下面会有进一步介绍
        form.on('select(dim)', function (data) {
            selectValue = data.value; //得到被选中的值
        });
    })


    //提交搜索表单
    function selfSubmit() {

        if ($("#dimValue").val() == null || $("#dimValue").val() == '') {
            $("#searchType").val('0');

            $("#orderCodeSe").val('');
            $("#searchPlace").val('');
            $("#carType").val('');
            $("#driverName").val('');
            $("#linkMan").val('');
        } else {
            $("#searchType").val("1");
            var setValue = $("#dimValue").val();
            if (selectValue == '0') {
                set('orderCodeSe', setValue);
            } else if (selectValue == '1') {
                set('searchPlace', setValue);
            } else if (selectValue == '2') {
                set('carType', setValue);
            } else if (selectValue == '3') {
                set('driverName', setValue);
            } else if (selectValue == '4') {
                set('linkMan', setValue);
            }
        }
        $("#pageNum").val("1");
        $("#pageSize").val("10");
        $("#searchForm").submit();
    }

    function set(id, value) {

        $("#orderCodeSe").val('');
        $("#searchPlace").val('');
        $("#carType").val('');
        $("#driverName").val('');
        $("#linkMan").val('');

        $("#" + id).val(value);


    }

    //跳到第一页
    function selfSearch() {
        $("[name='pageNum']").val(1);//第一页
        selfSubmit();
    }


    function releaseDetailSubmit(orderCode, bigOrderCode, linkMan, amount, prices, linkPhone) {


        var orderCode = orderCode;
        var bigOrderCode = bigOrderCode;
        var linkMan = linkMan;
        var amount = amount;
        var prices = prices;

        var linkPhone = linkPhone;
        var payType = 1

        var reg = /^1[0-9]{10}$/;


        var dataJson = {
            "bigOrderCode": bigOrderCode, "linkMan": linkMan, "linkPhone": linkPhone, "payType": payType,
            "amount": prices
        };
        var content = '确定提交吗？';
        layer.confirm(content, {icon: 3, title: '提示'}, function (index) {
            $('.layui-layer-btn0').css('pointer-events', 'none');
            $.ajax({
                type: "post",
                url: "${ctx}/charter/order/saveReleaseDetail",
                dataType: "json",
                data: dataJson,
                success: function (data) {
                    if (data.state == 1) {
                        layer.open({
                            icon: 1,
                            title: '信息',
                            skin: 'layer-ext-myskin',
                            shade: 0, //不显示遮罩
                            content: "操作成功！",
                            yes: function () {
                                location.replace('${ctx}/charter/order/list/0');
                            },
                        })
                    } else if (data.state == 2) {
                        parent.layer.closeAll();
                        wechatPay(bigOrderCode, prices);
                    } else if (data.state == 3) {
                        layer.msg("信用额度不够!", {icon: 2, time: 1000});
                    } else if (data.state == 99) {
                        layer.open({
                            icon: 2,
                            title: '信息',
                            skin: 'layer-ext-myskin',
                            shade: 0, //不显示遮罩
                            content: "操作失败！",
                        });
                    }
                }
            });
        });
    }

    function wechatPay(bigOrderCode, prices) {

        var width = "400px";
        var height = "300px;"
        var title = "订单支付";
        layer.open({
            type: 2,
            title: title,
            shadeClose: true,
            shade: 0.5,
            yes: function (index, layero) {
                var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象
                iframeWin.laySubmit();//执行iframe页的方法：
            },
            area: [width, height],
            // content: '${ctx}/charter/wechat/scanPay?bigOrderCode='+bigOrderCode
            content: '${ctx}/charter/wechat/newscanPay?bigOrderCode=' + bigOrderCode + '&amount=' + prices + '&actiontype=1'
        })
    }

</script>

</body>
</html>