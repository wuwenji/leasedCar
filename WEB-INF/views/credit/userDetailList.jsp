<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>权限管理</title>
    <style type="text/css">
        .button_left {
            margin-top: 0;
        }
    </style>
    <script>
        function examine(userId, companyName) {
            parent.layer.open({
                type: 2,
                title: "【" + companyName + '】审核信息',
                shadeClose: true,
                shade: 0.1,
                btn: ['同意', '拒绝'],
                btn1: function (index, layero) {
                    var iframe = window.top[layero.find('iframe')[0]['name']];//获取iframeWin对象
                    iframe.doExamine(0, 2);
                },
                btn2: function (index, layero) {
                    var iframe = window.top[layero.find('iframe')[0]['name']];//获取iframeWin对象
                    iframe.doExamine(2, null);
                    return false;
                },
                skin: "layui-layer-molv",
                area: ["750px", "500px"],
                content: "${ctx}/permission/examine?id=" + userId
            })
        }
    </script>
</head>
<body>
<form id="searchForm" action="${ctx}/credit/CreditDetail" method="post" class="layui-form">

    <input type="hidden" name="pageNum" value="${credit.pageNum}"/>
    <input type="hidden" name="pageSize" value="${credit.pageSize}"/>
    <input type="hidden" name="companyCode" value="${credit.companyCode}">
    <input type="hidden" name="actionTypa" value="${credit.actionTypa}">
    <input type="hidden" id="dowloadExcel" name="dowloadExcel" value="${credit.dowloadExcel}"/>
    <div class="button_left">
        <label class="layui-form-label">消费类型:</label>
        <div class="layui-input-block">
            <input type="radio" name="TabNum" value="1" title="消费情况"
                   <c:if test="${TabNum == 1}">checked</c:if> lay-filter="companyType">
            <input type="radio" name="TabNum" value="2" title="结算情况 "
                   <c:if test="${TabNum == 2}">checked</c:if> lay-filter="companyType">
            <input type="radio" name="TabNum" value="3" title="调整情况"
                   <c:if test="${TabNum == 3}">checked</c:if> lay-filter="companyType">
        </div>
    </div>
    <div class="button_right">
        <c:if test="${TabNum == 1}">
            <div class="layui-inline">
                <label class="layui-form-label">日期范围：</label>
                <div class="layui-input-inline" style="top: 5px;">
                    <input class="layui-input search_text input_date" id="beginTime" name="beginTime" type="text"
                           value='<fmt:formatDate value="${credit.beginTime}" pattern="yyyy-MM-dd"/>'
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endTime\')}'})"/>_
                </div>
                <div class="layui-input-inline" style="top: 5px;">
                    <input class="layui-input search_text input_date" id="endTime" name="endTime" type="text"
                           value='<fmt:formatDate value="${credit.endTime}" pattern="yyyy-MM-dd"/>'
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'beginTime\')}'})"/>
                </div>
            </div>
        </c:if>
        <c:if test="${TabNum == 1 || TabNum == 2}">
            <div class="layui-inline">
                <input type="text" name="param" class="layui-input" placeholder="请输入关键字" value="${credit.param}">
            </div>
            <button type="button" id="submitBtn" class="layui-btn layui-btn-small" onclick="selfSubmit()">搜索</button>
            <button type="button" class="layui-btn layui-btn-small" onclick="exportExcel();" lay-submit=""
                    lay-filter="demo1">导出Execl
            </button>
        </c:if>
    </div>
    <c:if test="${TabNum == 1}">
        <div class="cl"></div>
        <table class="layui-table">
            <colgroup>
                <col width="150">
                <col width="300">
                <col width="250">
                <col width="250">
                <col width="250">
                <col width="150">
            </colgroup>
            <thead>
            <tr>
                <th>序号</th>
                <th>订单号</th>
                <th>操作用户</th>
                <th>订单金额</th>
                <th>任务日期</th>
                <th>订单状态</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${credits.list}" var="credit" varStatus="vs">
                <tr>
                    <td>${vs.index+1}</td>
                    <td>${credit.orderCode}</td>
                    <td> ${credit.userAccount}</td>
                    <td>
                            <%--${credit.money}--%>
                            ${credit.amount}
                    </td>
                    <td><fmt:formatDate value="${credit.boardingTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${credit.status == -4}">已取消</c:when>
                            <c:when test="${credit.status == -3}">被拒绝</c:when>
                            <c:when test="${credit.status == -2}">待匹配</c:when>
                            <c:when test="${credit.status == -1}">匹配中</c:when>
                            <c:when test="${credit.status == 0}">待接受</c:when>
                            <c:when test="${credit.status == 1}">等待上车</c:when>
                            <c:when test="${credit.status == 2}">在途</c:when>
                            <c:when test="${credit.status == 3}">完成</c:when>
                            <c:when test="${credit.status == 4}">支付超时</c:when>
                            <c:when test="${credit.status == 5}">待出发</c:when>
                            <c:when test="${credit.status == 6}">取消车辆锁定中</c:when>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <tags:page pages="${credits}"/>
    </c:if>


    <c:if test="${TabNum == 2}">
        <div class="cl"></div>
        <table class="layui-table">
            <colgroup>
                <col width="60">
                <col width="300">
                <col width="300">
                <col width="250">
                <col width="250">
                <col width="250">
                <col width="250">
                <col width="100">
                <col width="100">
            </colgroup>
            <thead>
            <tr>
                <th>序号</th>
                <th>订单号</th>
                <th>结算时间</th>
                <th>结算账户</th>
                <th>结算金额</th>
                <th>操作用户</th>
                <th>结算方式</th>
                <th>状态</th>
                <c:if test="${isCharter == 0}">
                    <th>操作</th>
                </c:if>
                <%--<th>调整前</th>--%>
                <%--<th>调整额</th>--%>
                <%--<th>调整后</th>--%>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${creditDetilBillPageInfo.list}" var="credit" varStatus="vs">
                <tr>
                    <td>${vs.index+1}</td>
                    <td>${credit.bigOrderCode}</td>
                    <!--<td><a href="javascript:query('${credit.orderCode}',1);" style="color: orange;">${credit.orderCode}</a></td>-->
                    <td>
                        <fmt:formatDate value="${credit.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                    <td>
                            ${credit.userAccount}
                    </td>
                    <td> ${credit.credit}</td>
                    <td> ${credit.userAccount}</td>
                    <td>
                        <%--<c:choose>--%>
                            <%--<c:when test="${credit.payMode == 0}">账户余额</c:when>--%>
                            <%--<c:when test="${credit.payMode == 2}">微信</c:when>--%>
                            <%--<c:when test="${credit.payMode == 3}">支付宝</c:when>--%>
                            <%--<c:when test="${credit.payMode == 4}">银联</c:when>--%>
                            <%--<c:when test="${credit.payMode == 5}">申请退款</c:when>--%>
                            <%--<c:when test="${credit.payMode == 6}">下单扣除额度</c:when>--%>
                            <%--<c:when test="${credit.payMode == 7}">调整额度</c:when>--%>
                        <%--</c:choose>--%>
                        <c:choose>
                            <c:when test="${credit.billType == 2}">线下</c:when>
                            <c:otherwise>银联</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${credit.billStatus == 2}">
                                结算中
                            </c:when>
                            <c:otherwise>
                                已结算
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <c:if test="${isCharter == 0}">
                        <td>
                            <c:if test="${credit.billStatus == 2}">
                                <a href="javascript:void(0);" onclick="queryOrder('${credit.bigOrderCode}');" class="layui-btn layui-btn-small">确认结算</a>
                            </c:if>
                        </td>
                    </c:if>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <tags:page pages="${creditDetilBillPageInfo}"/>
    </c:if>


    <c:if test="${TabNum == 3}">
        <button type="button" class="layui-btn layui-btn-small" onclick="exportExcel();" lay-submit=""
                lay-filter="demo1">导出Execl
        </button>
        <div class="cl"></div>
        <table class="layui-table">
            <colgroup>
                <col width="60">
                <col width="300">
                <%--<c:if test="${credit1.actionTypa != 2}">--%>
                    <col width="250">
                <%--</c:if>--%>
                <col width="250">
                <col width="250">
                <col width="250">
            </colgroup>
            <thead>
            <tr>
                <th>序号</th>
                <th>时间</th>
                <%--<c:if test="${credit.actionTypa != 2}">--%>
                    <th>操作用户</th>
                <%--</c:if>--%>
                <th>调整前</th>
                <th>调整额</th>
                <th>调整后</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${creditDetilBillPageInfo.list}" var="credit" varStatus="vs">
                <tr>
                    <td>${vs.index+1}</td>
                    <td>
                        <fmt:formatDate value="${credit.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                    <%--<c:if test="${credit1.actionTypa != 2}">--%>
                        <td>
                                ${credit.userAccount}
                        </td>
                    <%--</c:if>--%>

                    <td> ${credit.creditBefore}</td>
                    <td> ${credit.credit}</td>
                    <td> ${credit.creditAfter}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <tags:page pages="${creditDetilBillPageInfo}"/>
    </c:if>


</form>
<script type="text/javascript">

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


    //提交搜索表单
    function selfSubmit() {
        $("[name='pageNum']").val(1);//第一页
        $("#searchForm").submit();
    }


    var radiovaLue;
    layui.use(['form', 'element', 'laydate'], function () {

        var form = layui.form;

        form.on('radio(companyType)', function (data) {
            $("#dowloadExcel").val("2");
            //console.log(data.elem); //得到radio原始DOM对象
            //console.log(data.value); //被点击的radio的value值
            var type = '${TabNum}';
            if (type != data.value) {
                $("[name='pageNum']").val(1);//第一页
                $("[name='param']").val("");
                $("[name='beginTime']").val("");
                $("[name='endTime']").val("");
            }
            $("#searchForm").submit();

        });
    });

    function query(orderCode, type) {
        var width = "900px";
        var height = "350px;"
        var title = "订单详情";
        if (type == 1) {
            height = "350px;"
            title = "订单详情";
        } else if (type == 3) {
            height = "560px;"
            title = "订单投诉";
        }
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
            content: '${ctx}/charter/order/query?orderCode=' + orderCode + '&type=' + type
        })
    }

    function queryOrder(bigOrderCode){
        var width = "900px";
        var height = "400px;";
        var title = "结算订单列表";
        layer.open({
            type: 2,
            title: title,
            shadeClose: true,
            shade: 0.5,
            btn:["确认收款","取消"],
            area: [width, height],
            content: '${ctx}/charter/order/findSettlementOrderList?billOrderCode=' + bigOrderCode,
            yes: function (index, layero) {
                //var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象
                $.ajax({
                    url: '${ctx}/charter/order/updateSettlementOrder',
                    type:'post',
                    data:{'billOrderCode':bigOrderCode},
                    dataType:'json',
                    async:false,
                    success:function (result) {
                        if(result.state){
                            layer.open({
                                icon: 1,
                                title: '信息',
                                skin: 'layer-ext-myskin',
                                shade: 0, //不显示遮罩
                                shadeClose: true,
                                content: "操作成功！",
                                yes: function (index1) {
                                    layer.close(index1);
                                    selfSubmit();
                                    //parent.location.reload();
                                }
                            });

                        }else{
                            layer.open({
                                icon: 2,
                                title: '信息',
                                skin: 'layer-ext-myskin',
                                shade: 0, //不显示遮罩
                                shadeClose: true,
                                content: "操作失败！"
                            });
                        }
                    },
                    error:function (errMsg) {

                    }
                });
            }
        })
    }
</script>
</body>
</html>