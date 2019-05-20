<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>个人中心</title>
    <style type="text/css">
        .button_left label {
            float: left;
        }

        .button_left span {
            float: left;
        }

        a.orange {
            color: #FF5722 !important;
        }

        .th-center th {
            /*padding-left: 20px;*/
            font-weight: bold;
            text-align: center;
        }

        .td-center td {
            text-align: center;
        }

        .th-center th img {
            margin-left: 2px;
            margin-top: -4px;
            cursor: pointer;
            width: 14px;
            height: 14px;
        }

        .info {
            min-height: 0px;
        }

        .search_text {
            width: 110px;
            padding-right: 0;
        }

        #dimValue {
            height: 28px;
            line-height: 28px;
            margin-left: -10px;
            border: 1px solid #e6e6e6;
        }

        #dim {
            width: 30px;
            margin-top: 5px;
            height: 30px;
        }

        .layui-table td:nth-child(1), .layui-table th:nth-child(1) {
            width: 50px;
        }

        .layui-table td:nth-child(2), .layui-table th:nth-child(2) {
            width: 200px;
        }

        .layui-table td:nth-child(3), .layui-table th:nth-child(3) {
            width: 100px;
        }

        .layui-table td:nth-child(4), .layui-table th:nth-child(4) {
            width: 100px;
        }

        .layui-table td:nth-child(5), .layui-table th:nth-child(5) {
            width: 100px;
        }

        .layui-table td:nth-child(6), .layui-table th:nth-child(6) {
            width: 100px;
        }

        .layui-table td:nth-child(7), .layui-table th:nth-child(7) {
            width: 100px;
        }

        .layui-table td:nth-child(8), .layui-table th:nth-child(8) {
            width: 100px;
        }

        .layui-table td:nth-child(9), .layui-table th:nth-child(9) {
            width: 100px;
        }
        .john-select{
            float:left;
            padding-left:10px;
            width:150px;
        }
        .john-select .layui-unselect{
            width:90px;
        }
        .shuxian{
            width: 1px;
            position: absolute;
            background: #ccc;
            height: 50px;
            margin-top: -10px;
            margin-left: 150px;
        }
        .button_right input {
            float: left;
            width: 146px;
        }
        .layui-form-label {
            float: left;
            display: block;
            padding: 5px 15px;
            width: 60px;
        }
        /*.layui-table td:nth-child(6),.layui-table th:nth-child(6){*/
        /*width: 150px;*/
        /*}*/
    </style>
</head>
<body>
<section>
    <div class="container">
        <jsp:include page="/WEB-INF/layouts/left_menu.jsp"/>
        <main>
            <div class="position_all">
                <div class="position">您所在的位置：首页 -> 订单管理 ->
                    <c:if test="${ids==5}">无效订单</c:if>
                    <c:if test="${ids==4}">完成订单</c:if>
                    <c:if test="${ids==3}">历史订单</c:if>
                    <c:if test="${ids==-2}">待匹配订单</c:if>
                    <c:if test="${ids==-1}">待付订单</c:if>
                    <c:if test="${ids==0}">待确定订单</c:if>
                    <c:if test="${ids==2}">待出发订单</c:if>
                    <c:if test="${ids==-3}">被拒绝订单</c:if>
                </div>
            </div>
            <form id="searchForm" class="layui-form" action="${ctx}/charter/order/list/${ids}" method="post">
                <input type="hidden" name="pageNum" value="${order.pageNum}"/>
                <input type="hidden" name="pageSize" value="${order.pageSize}"/>
                <input type="hidden" id="order" name="order" value="${order.order}"/>
                <input type="hidden" id="sortType" name="sortType" value="${order.sortType}"/>
                <div class="info">
                    <div class="button_left">
                    </div>
                    <div class="button_right john-edge">
                        <div class="layui-inline">
                            <c:if test="${ids==5}">
                                <div class="shuxian"></div>
                                <div class="john-select">
                                    <label>状态:</label>
                                    <div style="width:85px;" class="layui-inline">
                                        <select id="status">
                                            <option value="1">退款订单</option>
                                            <option value="4">超时订单</option>
                                            <option value="-4">取消订单</option>
                                        </select>
                                    </div>
                                </div>
                            </c:if>
                            <label class="layui-form-label">出发日期：</label>
                            <div class="layui-input-inline">
                                <input class="layui-input search_text input_date yearm" id="beginTime" name="beginTime"
                                       type="text"
                                       value='<fmt:formatDate value="${order.beginTime}" pattern="yyyy-MM-dd"/>'/>_
                            </div>
                            <div class="layui-input-inline" >
                                <input class="layui-input search_text input_date yearm" id="endTime" name="endTime"
                                       type="text"
                                       value='<fmt:formatDate value="${order.endTime}" pattern="yyyy-MM-dd"/>'/>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">查询内容:</label>
                            <div style="width:80px;" class="layui-inline">
                                <select id="dim" lay-filter="dim">
                                    <option value="0"
                                            <c:if test="${order.orderCodeSe != null and order.orderCodeSe !=''}">selected="selected"</c:if>>订单号
                                    </option>
                                    <option value="1"
                                            <c:if test="${order.searchPlace != null and order.searchPlace !=''}">selected="selected"</c:if>>地点
                                    </option>
                                    <option value="2"
                                            <c:if test="${order.orderAccount != null and order.orderAccount !=''}">selected="selected"</c:if>>发单人
                                    </option>
                                    <option value="3"
                                            <c:if test="${order.search_Order_CompanyName != null and order.search_Order_CompanyName !=''}">selected="selected"</c:if>>服务商
                                    </option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <input class="search_text" id="dimValue" name="dimValue" type="text"
                                   value="<c:if test="${order.orderCodeSe != null and order.orderCodeSe !=''}">${order.orderCodeSe}</c:if><c:if test="${order.searchPlace != null and order.searchPlace !=''}">${order.searchPlace}</c:if><c:if test="${not empty order.search_Order_CompanyName}">${order.search_Order_CompanyName}</c:if>"
                                   placeholder="输入查询内容"/>
                        </div>
                        <div class="layui-inline" style="display: none;">
                            <input type="text" name="orderCodeSe" value="${order.orderCodeSe}" class="layui-input"
                                   placeholder="请输订单号">
                            <input type="text" name="searchPlace" value="${order.searchPlace}" class="layui-input"
                                   placeholder="请输入地点">
                            <input type="text" name="orderAccount" value="${order.orderAccount}" class="layui-input"
                                   placeholder="请输发单人">
                            <input type="text" name="search_Order_CompanyName" value="${order.search_Order_CompanyName}"
                                   class="layui-input"
                                   placeholder="请输服务商">
                        </div>
                        <div class="layui-inline">
                            <a class="layui-btn layui-btn-danger layui-btn-small" href="#"
                               onclick="submitCharterForm();">搜索</a>
                        </div>
                    </div>
                    <div class="cl"></div>
                </div>

                <div class="info info-padding0">
                    <table class="layui-table" lay-even="" lay-skin="nob">
                        <%--<colgroup>--%>
                        <%--<col width="125">--%>
                        <%--<col width="250">--%>
                        <%--<col width="100">--%>
                        <%--<col width="100">--%>
                        <%--<col width="100">--%>
                        <%--<c:if test="${ids==2 || ids == 3}">--%>
                        <%--<col width="100">--%>
                        <%--<col width="100">--%>
                        <%--<col width="100">--%>
                        <%--</c:if>--%>
                        <%--<col width="200"/>--%>
                        <%--</colgroup>--%>
                        <thead>
                        <tr class="th-center">
                            <th>服务商</th>
                            <th>路线<img id="start_point" onclick="sort(this);" src="${ctx}/static/images/doup.png"
                                       alt=""></th>
                            <th>上车时间<img id="boarding_time" onclick="sort(this);" src="${ctx}/static/images/doup.png"
                                         alt=""></th>
                            <th>金额<img id="amount" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt="">
                            </th>
                            <c:if test="${ids==2 || ids == 3}">
                                <th>车牌</th>
                                <th>司机</th>
                                <th>发单人</th>
                            </c:if>
                            <th>状态<img id="t.status" onclick="sort(this);" src="${ctx}/static/images/doup.png" alt="">
                            </th>
                            <th>操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </form>
            <div class="layui-form">
                <c:forEach items="${orders.list}" var="ord">
                    <table class="layui-table" lay-even="" lay-skin="nob" style="border: 1px solid #CCC;">
                            <%--<colgroup>--%>
                            <%--<col width="150">--%>
                            <%--<col width="250">--%>
                            <%--<col width="250">--%>
                            <%--<col width="100">--%>
                            <%--<col width="100">--%>
                            <%--<c:if test="${ids==2 || ids == 3}">--%>
                            <%--<col width="100">--%>
                            <%--<col width="100">--%>
                            <%--<col width="100">--%>
                            <%--</c:if>--%>
                            <%--<col width="200"/>--%>
                            <%--</colgroup>--%>
                        <thead>
                        <tr>
                            <c:choose>
                            <c:when test="${ids==2 || ids == 3}">
                            <th colspan="9" style="text-align: left;">
                                </c:when>
                                <c:otherwise>
                            <th colspan="9" style="text-align: left;">
                                </c:otherwise>
                                </c:choose>
                                订单号：<span><a href="javascript:query('${ord.orderCode}',1);"
                                             style="color: orange;">${ord.orderCode}</a></span>
                                <c:if test="${ord.startPoint != null && ord.endPoint != null}">
                                    <a class="icon-star" href="javascript:collectOrder('${ord.orderCode}');"></a>
                                    <a style="color: red;" href="javascript:collectOrder('${ord.orderCode}');">
                                        加入收藏</a>
                                </c:if>
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr class="td-center">
                            <td style="text-align: center;">${ord.companyName}</td>
                            <td>${ord.startPoint} — ${ord.endPoint}</td>
                            <td><fmt:formatDate value="${ord.boardingTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td><span class="orange"><b>
							      <c:choose>
                                      <c:when test="${ord.amount != null}">￥${ord.amount}</c:when>
                                      <c:when test="${ord.amount == null}">￥0</c:when>
                                  </c:choose>
							      </b></span>
                            </td>
                            <c:if test="${ids==2 || ids == 3}">
                                <td>${ord.carNum}</td>
                                <td>${ord.driverName}</td>
                                <td>${ord.orderAccount}</td>
                            </c:if>
                            <td>
                                <c:choose>
                                    <c:when test="${ord.status == -4}">
                                        <c:choose>
                                            <c:when test="${ord.refundStatus ==1 || ord.refundStatus ==3}">
                                                已退款
                                            </c:when>
                                            <c:when test="${ord.refundStatus ==0}">
                                                退款中
                                            </c:when>
                                            <c:otherwise>
                                                已取消
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:when test="${ord.status == -3}">被拒绝</c:when>
                                    <c:when test="${ord.status == -2}">稍后搜索</c:when>
                                    <c:when test="${ord.status == -1}">匹配中</c:when>
                                    <c:when test="${ord.status == 0}">待确定</c:when>
                                    <c:when test="${ord.status == 1}">等待上车</c:when>
                                    <c:when test="${ord.status == 2}">在途</c:when>
                                    <c:when test="${ord.status == 3}">已完成</c:when>
                                    <c:when test="${ord.status == 5}">待出发</c:when>
                                    <c:when test="${ord.status == 4}">支付超时</c:when>
                                    <c:when test="${ord.status == 7}">车辆已返回</c:when>
                                    <c:when test="${ord.refundStatus == 0}">退款中</c:when>
                                    <c:when test="${ord.refundStatus == 1}">已退款</c:when>
                                </c:choose>
                            </td>
                            <td>
                                    <%-- <a href="javascript:query('${ord.orderCode}',1);" class="layui-btn layui-btn-primary layui-btn-mini">详情</a> --%>
                                <c:if test="${ord.status != -1 && ord.status != 0 && ord.status !=1 && ord.status != 2 && ord.status !=3 && ord.recordStatus == 0}">
                                    <!-- <a href="${ctx}/charter/order/pushOrder?orderCode=${ord.orderCode}&flag=3"
                                    class="layui-btn layui-btn-normal layui-btn-mini">修改</a> -->
                                </c:if>
                                <c:if test="${ord.status == -1 && ord.recordStatus == 0}">
                                    <a href="${ctx}/charter/order/detailRelease?orderCode=${ord.orderCode}"
                                       class="layui-btn layui-btn-normal layui-btn-mini">付款</a>
                                </c:if>
                                <c:if test="${(ord.status == -3 || ord.status == -2 || ord.status == -1) && ord.recordStatus == 0}">
                                    <a href="javascript:orderCharterCancel(2,'${ctx}','${ord.orderCode}','${ord.payType}');"
                                       class="layui-btn layui-btn-danger layui-btn-mini">取消</a>
                                </c:if>
                                <c:if test="${ord.recordStatus == 0 && ord.complaintId == null && (ord.status ==3 )}">
                                    <a href="javascript:query('${ord.orderCode}',3);"
                                       class="layui-btn layui-btn-danger layui-btn-mini">投诉</a>
                                </c:if>
                                <c:if test="${ord.recordStatus == 0 && ord.status == 3}">
                                    <!-- <a href="${ctx}/charter/order/pushOrder?orderCode=${ord.orderCode}&flag=4"
                                    class="layui-btn layui-btn-normal layui-btn-mini">再来一单</a> -->
                                </c:if>
                                <c:if test="${ord.recordStatus == 0 && ord.status == 2}">
                                    <!-- <a href="${ctx}/charter/order/pushOrder?orderCode=${ord.orderCode}&flag=5"
                                    class="layui-btn layui-btn-normal layui-btn-mini">再来一单</a> -->
                                </c:if>
                                <c:if test="${ord.recordStatus == 0 && ord.status == 0}">
                                    <a href="javascript:refund('${ctx}','${ord.orderCode}','${ord.amount}');"
                                       class="layui-btn layui-btn-warm layui-btn-mini">退款</a>
                                </c:if>
                                <c:if test="${ord.recordStatus == 0 && ord.status == 5}">
                                    <!-- <a href="${ctx}/charter/order/pushOrder?orderCode=${ord.orderCode}&flag=5"
                                    class="layui-btn layui-btn-normal layui-btn-mini">再来一单</a> -->
                                    <a href="javascript:refund('${ctx}','${ord.orderCode}','${ord.amount}');"
                                       class="layui-btn layui-btn-warm layui-btn-mini">退款</a>
                                </c:if>
                                <c:if test="${ord.recordStatus == 0 && ord.status == 1}">
                                    <!-- <a href="${ctx}/charter/order/pushOrder?orderCode=${ord.orderCode}&flag=5"
                                    class="layui-btn layui-btn-normal layui-btn-mini">再来一单</a> -->
                                    <a href="javascript:refund('${ctx}','${ord.orderCode}','${ord.amount}');"
                                       class="layui-btn layui-btn-warm layui-btn-mini">退款</a>
                                </c:if>

                            </td>
                        </tr>
                        </tbody>
                    </table>
                </c:forEach>
            </div>
            <tags:page pages="${orders}"/>
        </main>
    </div>
</section>
<script type="text/javascript">


    //收藏线路
    function collectOrder(code) {
        $.ajax({
            type: "POST",
            url: "${ctx}/collectionOrder/save",
            data: {'orderCode': code},
            dataType: "json",
            success: function (data) {
                if (data) {
                    layer.msg('收藏成功', {icon: 1, timeout: 500});
                } else {
                    layer.msg('系统错误', {icon: 2, timeout: 1000});
                }
            }
        });
    }

    //查询
    function submitCharterForm() {

        var beginTime = $("#test1").val();
        var endTime = $("#test2").val();
        if ((beginTime == null || '' == beginTime) && (endTime != null && '' != endTime)) {
            layer.tips('开始日期不能为空！', '#beginTime', {tips: [3, '#78BA32']});

            return false;
        }

        var content = $("#dimValue").val();
        var dimValue = $("#dim").val();

        $("[name='orderCodeSe']").val("");
        $("[name='searchPlace']").val("");
        $("[name='orderAccount']").val("");
        $("[name='search_Order_CompanyName']").val("");

        if (content != null && content != "") {
            if (dimValue == 0) {
                $("[name='orderCodeSe']").val(content);
            } else if (dimValue == 1) {
                $("[name='searchPlace']").val(content);
            } else if (dimValue == 2) {
                $("[name='orderAccount']").val(content);
            } else {
                $("[name='search_Order_CompanyName']").val(content);
            }
        }


        $("#searchForm").submit();
    }

    function query(orderCode, type) {
        var width = "1000px";
        var height = "400px;";
        var title = "订单详情";
        if (type == 1) {
            height = "400px;";
            title = "订单详情";
        } else if (type == 3) {
            height = "560px;";
            title = "订单投诉";
        }
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
            content: '${ctx}/charter/order/query?orderCode=' + orderCode + '&type=' + type
        })
    }
</script>
</body>
</html>