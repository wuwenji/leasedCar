<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>

    <title>订单对账</title>
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
                <div class="position">您所在的位置：首页 -> 财务管理 -> 订单对账</div>
            </div>

            <div class="">
                <form id="searchForm" class="layui-form" action="${ctx}/transport/finance/balanceList" method="post">
                    <input type="hidden" name="pageNum" id="pageNum" value="${order.pageNum}"/>
                    <input type="hidden" name="pageSize" id="pageSize" value="${order.pageSize}"/>
                    <input type="hidden" id="order" name="order" value="${order.order}"/>
                    <input type="hidden" id="sortType" name="sortType" value="${order.sortType}"/>
                    <input type="hidden" id="orderCode" name="orderCode" value="${order.orderCode}"/>
                    <input type="hidden" id="searchPlace" name="searchPlace" value="${order.searchPlace}"/>
                    <input type="hidden" id="carType" name="carType" value="${order.carType}"/>
                    <input type="hidden" id="driverName" name="driverName" value="${order.driverName}"/>
                    <input type="hidden" id="linkMan" name="linkMan" value="${order.linkMan}"/>
                    <input type="hidden" id="searchType" name="searchType" value="0">
                    <input type="hidden" id="orderCodes" name="orderCodes" value="${orderCodes}">

                    <div class="button_left info">
                        <div class="layui-inline">
                            <label class="layui-form-label">订单日期:</label>
                            <div class="layui-input-inline">
                                <input class="layui-input search_text input_date" id="beginTime" name="beginTime"
                                       type="text" autocomplete="off"
                                       value='<fmt:formatDate value="${order.beginTime}" pattern="yyyy-MM-dd"/>'
                                       onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endTime\')}'})"/>
                            </div>
                            -
                            <div class="layui-input-inline">
                                <input class="layui-input search_text input_date" id="endTime" name="endTime"
                                       type="text" autocomplete="off"
                                       value='<fmt:formatDate value="${order.endTime}" pattern="yyyy-MM-dd"/>'
                                       onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'beginTime\')}'})"/>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">查询内容:</label>
                            <div style="width:80px;" class="layui-inline">
                                <select name="searchNum" id="dim" lay-filter="dim">
                                    <option value="0" <c:if test="${order.searchNum  == 0}">selected="selected"</c:if>>订单号</option>
                                    <option value="1" <c:if test="${order.searchNum  == 1}">selected="selected"</c:if>>地点</option>
                                    <option value="2" <c:if test="${order.searchNum  == 2}">selected="selected"</c:if>>包车企业</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <input class="search_text" id="dimValue" name="searchParam" type="text" autocomplete="off" value="${order.searchParam}" placeholder="输入查询内容"/>
                        </div>
                        <div class="layui-inline" style="margin-right:10px;">
                            <a class="layui-btn layui-btn-danger layui-btn-small" href="javascript:selfSubmit();">搜索</a>
                        </div>
                    </div>
                    <div class="layui-form">
                        <table class="layui-table">
                            <thead>
                            <tr>
                                <th style="text-align: center;"><input name="" lay-skin="primary" lay-filter="allChoose" type="checkbox"></th>
                                <%--<th style="text-align: center;"><a style="font-weight: bold;">序号</a></th>--%>
                                <th style="text-align: center;"><a style="font-weight: bold;">订单号</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">包车企业</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">订单日期</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">起点</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">终点</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">订单金额</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">增减费用</a></th>
                                <th style="text-align: center;"><a style="font-weight: bold;">状态</a></th>
                            </tr>
                            </thead>
                            <tr>
                                <c:forEach items="${orders.list}" var="orders" varStatus="vs">
                            <tr>
                                <td><input name="check_order" lay-skin="primary" type="checkbox" value="${orders.orderCode}"></td>
                                <%--<td style="text-align: right;">${vs.index+1}</td>--%>
                                <td style="text-align: center;">${orders.orderCode}</td>
                                <td style="text-align: center;">${orders.charterCompanyName}</td>
                                <td style="text-align: right;"><fmt:formatDate value="${orders.boardingTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <td style="text-align: center;">${orders.startPoint}</td>
                                <td style="text-align: center;">${orders.endPoint}</td>
                                <td style="text-align: right;">${orders.amount}</td>
                                <td style="text-align: center;"></td>
                                <td style="text-align: center;">已完成</td>
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
    });

    //搜索框的状态记忆
//    var selectValue = $("#dim").val();
//    if (selectValue == null && selectValue == '') {
//        selectValue = '0';
//    }
    layui.use('form', function () {

        var form = layui.form;


        //各种基于事件的操作，下面会有进一步介绍
        form.on('select(dim)', function (data) {
            selectValue = data.value; //得到被选中的值
        });
        form.on('checkbox(check_order)', function(data){
            var orderCodes = queryCheckedValue();
            $("#orderCodes").val(orderCodes);
        });
    });

    //获取所有选中checkbox的值
    function queryCheckedValue() {
        var str = "";
        $("input:checkbox[name='check_order']:checked").each(function() {
            var val = $(this).val();
            if(str.length > 0){
                str += "," + val;
            }else{
                str += val;
            }
        });
        return str;
    }

    //提交搜索表单
    function selfSubmit() {
        $("#pageNum").val("1");
        $("#pageSize").val("10");
        $("#searchForm").submit();
    }

//    function set(id, value) {
//
//        $("#orderCodeSe").val('');
//        $("#searchPlace").val('');
//        $("#carType").val('');
//        $("#driverName").val('');
//        $("#linkMan").val('');
//
//        $("#" + id).val(value);
//    }

    //跳到第一页
//    function selfSearch() {
//        $("[name='pageNum']").val(1);//第一页
//        selfSubmit();
//    }

    function wechatPay(orderCode, amount) {
        var width = "400px";
        var height = "300px;";
        var title = "订单支付";
        layer.open({
            type: 2,
            title: title,
            shadeClose: true,
            shade: 0.5,
            scrollbar:false,
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
