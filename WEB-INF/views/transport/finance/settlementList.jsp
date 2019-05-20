<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>

    <title>订单结算查询</title>
    <style>
        .layui-table td, .layui-table th {
            position: relative;
            padding: 9px 10px;
            min-height: 20px;
            line-height: 20px;
            font-size: 14px
        }

        .search_text {
            width: 110px;
            padding-right: 0;
        }

        .layui-input {
            height: 30px;
            line-height: 30px;
        }

        .layui-form-label {
            padding: 5px 15px;
        }

        .info {
            min-height: 30px;

            overflow: visible;
        }

        .button_left {
            float: right;
        }

        #dimValue {
            height: 28px;
            line-height: 28px;
            margin-left: -10px;
            border: 1px solid #e6e6e6;
        }

        .button_left .layui-form-label {
            width: 60px;
        }

        .shuxian {
            display: block;
            width: 1px;
            position: absolute;
            background: #ccc;
            height: 50px;
            margin-top: -10px;
            margin-left: 190px;
        }

        .button_left {
            margin: 0 0 10px 0;
        }

        .button_left a:first-child {
            margin: 0px;
        }
    </style>
</head>

<body>
<section>
    <div class="container">
        <jsp:include page="/WEB-INF/layouts/left_menu.jsp"/>
        <main>
            <div class="position_all">
                <div class="position">您所在的位置：首页 -> 财务管理 -> 订单结算查询</div>
            </div>

            <div class="">
                <form id="searchForm" class="layui-form" action="${ctx}/transport/finance/settlement" method="post">
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

                    <div class="button_left info">
                        <span class="shuxian"></span>
                        <div class="layui-inline">
                            <label style="width: 55px;" class="layui-form-label">订单类型:</label>
                            <div style="width: 90px;" class="layui-input-inline">
                                <select name="paymentStatus" id="" lay-filter="companyType">
                                    <option value="">应付款
                                    </option>
                                    <option value="2" <c:if test="${order.paymentStatus == 2}">selected</c:if>>已付款
                                    </option>
                                    <option value="1" <c:if test="${order.paymentStatus == 1}">selected</c:if>>未付款
                                    </option>
                                </select>
                            </div>
                        </div>

                        <div class="layui-inline">
                            <label class="layui-form-label">上车时间:</label>
                            <div class="layui-input-inline">
                                <input class="layui-input search_text input_date" id="beginTime" name="beginTime"
                                       type="text"
                                       value='<fmt:formatDate value="${order.beginTime}" pattern="yyyy-MM-dd"/>'/>
                            </div>
                            -
                            <div class="layui-input-inline">
                                <input class="layui-input search_text input_date" id="endTime" name="endTime"
                                       type="text"
                                       value='<fmt:formatDate value="${order.endTime}" pattern="yyyy-MM-dd"/>'/>
                            </div>
                        </div>
                        <div style="width:90px;" class="layui-inline">
                            <select name="status" id="status">
                                <option value="">订单状态</option>
                                <option value="1" <c:if test="${order.status == 1}">selected="selected"</c:if>>等待上车
                                </option>
                                <option value="2" <c:if test="${order.status == 2}">selected="selected"</c:if>>在途
                                </option>
                                <option value="3" <c:if test="${order.status == 3}">selected="selected"</c:if>>完成
                                </option>
                            </select>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">查询内容:</label>
                            <div style="width:80px;" class="layui-inline">
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
                        </div>
                        <div class="layui-inline">
                            <input class="search_text" id="dimValue" name="dimValue" type="text" placeholder="输入查询内容"/>
                        </div>
                        <div class="layui-inline" style="margin-right:10px;">
                            <%-- <input type="text" name="orderCodeSe" value="${order.orderCodeSe}" class="layui-input" placeholder="请输订单号"> --%>
                            <a class="layui-btn layui-btn-danger layui-btn-small" href="javascript:selfSubmit();">搜索</a>
                        </div>

                        <%--<div class="cl"></div>--%>
                        <%--<label class="layui-form-label">订单类型:</label>--%>
                        <%--<div class="layui-input-block">--%>
                        <%--<input type="radio" name="paymentStatus" value="3" title="应付款"--%>
                        <%--<c:if test="${order.paymentStatus == 3}">checked</c:if> lay-filter="companyType">--%>
                        <%--<input type="radio" name="paymentStatus" value="2" title="已付款 "--%>
                        <%--<c:if test="${order.paymentStatus == 2}">checked</c:if> lay-filter="companyType">--%>
                        <%--<input type="radio" name="paymentStatus" value="1" title="未付款"--%>
                        <%--<c:if test="${order.paymentStatus == 1}">checked</c:if> lay-filter="companyType">--%>
                        <%--</div>--%>
                    </div>


                    <div class="layui-form">
                        <table class="layui-table">
                            <thead>
                            <tr>
                                <th style="text-align: center;"><a style="font-weight: bold;">序号</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">订单号</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">路线</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">开始时间</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">结束时间</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">司机</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">订单金额</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">是否记账</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">记账支付情况</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">操作</a></th>
                            </tr>
                            </thead>
                            <tr>
                                <c:forEach items="${orders.list}" var="orders" varStatus="vs">
                            <tr>
                                <td style="text-align: right;">${vs.index+1}</td>
                                <td style="text-align: center;">${orders.orderCode}</td>
                                <td style="text-align: center;">${orders.startPoint} - ${orders.endPoint}</td>
                                <td style="text-align: right;">
                                    <fmt:formatDate value="${orders.boardingTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <td style="text-align: right;">
                                    <fmt:formatDate value="${orders.debusTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                </td>
                                <td style="text-align: center;">${orders.driverName}</td>
                                <td style="text-align: right;">${orders.amount}</td>
                                <td style="text-align: center;">
                                    <c:choose>
                                    <c:when test="${orders.paymentType == 1}">否</c:when>
                                    <c:when test="${orders.paymentType == 2}">是</c:when>
                                    </c:choose>
                                <td style="text-align: center;">
                                    <c:choose>
                                    <c:when test="${orders.settlement == 1}">未结算</c:when>
                                    <c:when test="${orders.settlement == 2}">已结算</c:when>
                                    </c:choose>
                                <td style="text-align: center;">
                                    <c:if test="${isTransport != 1}">
                                    <c:if test="${orders.paymentStatus == 1}">
                                    <input type="button" style="float:right;margin-top:10px;" id="payBtn"
                                           onclick="wechatPay('${orders.orderCode}','${orders.amount}');"
                                           class="layui-btn layui-btn-danger layui-btn-mini" value="立即支付"/></td>
                                </c:if>
                                </c:if>
                            </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <tags:page pages="${orders}"/>
                </form>
            </div>
        </main>
    </div>
    </div>
</section>

<script type="text/javascript">
    layui.use('laydate', function () {
        var laydate = layui.laydate;
        lay('.input_date').each(function () {
            laydate.render({
                elem: this
                , trigger: 'click'
            });
        });
    })
    var radiovaLue;
    layui.use(['form', 'element', 'laydate'], function () {

        var form = layui.form;
        form.on('select(companyType)', function (data) {
            var type = '${order.settlement}';
            if (type != data.value) {
                $("[name='pageNum']").val(1);//第一页
            }
            selfSubmit();
        });
        <%--form.on('radio(companyType)', function (data) {--%>
        <%--//console.log(data.elem); //得到radio原始DOM对象--%>
        <%--//console.log(data.value); //被点击的radio的value值--%>
        <%--var type = '${order.settlement}';--%>
        <%--if (type != data.value) {--%>
        <%--$("[name='pageNum']").val(1);//第一页--%>
        <%--}--%>
        <%--selfSubmit();--%>

        <%--});--%>
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
    });

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

    function wechatPay(orderCode, amount) {
        var width = "400px";
        var height = "300px;";
        var title = "订单支付";
        layer.open({
            type: 2,
            title: title,
            shadeClose: true,
            shade: 0.5,
            scrollbar: false,
            yes: function (index, layero) {
                var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象
                iframeWin.laySubmit();//执行iframe页的方法：
            },
            area: [width, height],
            content: '${ctx}/charter/wechat/newscanPay?orderCode=' + orderCode + '&amount=' + amount + '&actiontype=3'
        })
    }
</script>
</body>
</html>
