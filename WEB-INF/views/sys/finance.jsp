<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>财务管理</title>
    <script>
        //type 5: 额度付款提醒
        function remind(type, ids) {


            $.ajax({
                type:"post",
                url:"${ctx}/sys/finance/remind",
                dataType:"json",
                data:{"ids": ids, "type": type},
                success:function(data) {
                    if(data.state){
                        layer.open({
                            icon: 1,
                            title: '信息',
                            skin: 'layer-ext-myskin',
                            shade: 0, //不显示遮罩
                            content: "提醒成功！",
                            yes: function(){
                                parent.refresh();
                            },
                        });
                    }else{
                        layer.open({
                            icon: 2,
                            title: '信息',
                            skin: 'layer-ext-myskin',
                            shade: 0, //不显示遮罩
                            content: "提醒失败！"
                        });
                    }
                }
            });
        }
    </script>
</head>
<body>
<form id="searchForm" action="${ctx}/sys/finance" method="post" class="layui-form">
    <input type="hidden" name="pageNum" value="${finance.pageNum}"/>
    <input type="hidden" name="pageSize" value="${finance.pageSize}"/>
    <input type="hidden" id="dowloadExcel" name="dowloadExcel" value="${finance.dowloadExcel}"/>
    <div class="button_left">
        <label class="layui-form-label">财务类型:</label>
        <div class="layui-input-block">
            <input type="radio" name="type" value="1" title="个人用户"
                   <c:if test="${finance.type == 1}">checked</c:if> lay-filter="companyType">
            <input type="radio" name="type" value="2" title="包车企业"
                   <c:if test="${finance.type == 2}">checked</c:if> lay-filter="companyType">
            <input type="radio" name="type" value="3" title="运输企业"
                   <c:if test="${finance.type == 3}">checked</c:if> lay-filter="companyType">
        </div>
    </div>
    <div class="button_right">
        <input type="text" name="param" class="layui-input" placeholder="请输入关键字" value="${finance.param}">
        <button class="layui-btn layui-btn-small" onclick="sear();">搜索</button>
        <button type="button" class="layui-btn layui-btn-small" onclick="exportExcel();" lay-submit=""
                lay-filter="demo1">导出Execl
        </button>
    </div>
    <c:if test="${finance.type == 1}">
        <div class="cl"></div>
        <table class="layui-table">
            <colgroup>
                <col width="60">
                <col width="270">
                <col width="270">
                <col>
            </colgroup>
            <thead>
            <tr>
                <th>序号</th>
                <th>用户名称</th>
                <th>付款金额(元)</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${finances.list}" var="finance" varStatus="vs">
                <tr>
                    <td>${vs.index+1}</td>
                    <td>${finance.companyName}</td>
                    <td>
                        <fmt:formatNumber value="${finance.payment}" pattern="#.##" minFractionDigits="2" />
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <tags:page pages="${finances}"/>
    </c:if>
    <c:if test="${finance.type == 2}">
        <div class="cl"></div>
        <table class="layui-table">
            <colgroup>
                <col width="60">
                <col width="270">
                <col width="270">
                <col width="270">
                <col width="270">
                <col>
            </colgroup>
            <thead>
            <tr>
                <th>序号</th>
                <th>企业名称</th>
                <th>应付款金额</th>
                <th>已付款金额</th>
                <th>未付款金额</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${finances.list}" var="finance" varStatus="vs">
                <tr>
                    <td>${vs.index+1}</td>
                    <td>${finance.companyName}</td>
                    <td>
                        <fmt:formatNumber value="${finance.payable}" pattern="#.##" minFractionDigits="2" />
                    </td>
                    <td>
                        <fmt:formatNumber value="${finance.payment}" pattern="#.##" minFractionDigits="2" />
                    </td>
                    <td>
                        <fmt:formatNumber value="${finance.unpaid}" pattern="#.##" minFractionDigits="2" />
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <tags:page pages="${finances}"/>
    </c:if>
    <c:if test="${finance.type == 3}">
        <div class="cl"></div>
        <table class="layui-table">
            <colgroup>
                <col width="60">
                <col width="270">
                <col width="270">
                <col width="270">
                <col width="270">
                <col>
            </colgroup>
            <thead>
            <tr>
                <th>序号</th>
                <th>企业名称</th>
                <th>应收款金额</th>
                <th>已收款金额</th>
                <th>未收款金额</th>
                <th>佣金</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${finances.list}" var="finance" varStatus="vs">
                <tr>
                    <td>${vs.index+1}</td>
                    <td>${finance.companyName}</td>
                    <td>
                        <fmt:formatNumber value="${finance.payable}" pattern="#.##" minFractionDigits="2" />
                    </td>
                    <td>
                        <fmt:formatNumber value="${finance.payment}" pattern="#.##" minFractionDigits="2" />
                    </td>
                    <td>
                        <fmt:formatNumber value="${finance.unpaid}" pattern="#.##" minFractionDigits="2" />
                    </td>
                    <td>
                        <fmt:formatNumber value="0" pattern="#.##" minFractionDigits="2" />
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <tags:page pages="${finances}"/>
    </c:if>
</form>
<script>

    function sear() {
        $("#dowloadExcel").val("2");
        $("#searchForm").submit();
    }

    function exportExcel() {

        $("#dowloadExcel").val("1");

        $("#searchForm").submit();
    }


    //提交搜索表单
    function selfSubmit() {
        $("[name='pageNum']").val(1);//第一页
        $("#searchForm").submit();
    }
    layui.use(['form'], function () {

        var form = layui.form;

        form.on('radio(companyType)', function (data) {
            $("#dowloadExcel").val("2");
            var type = '${finance.type}';
            if (type != data.value) {
                $("[name='pageNum']").val(1);//第一页
                $("[name='param']").val("");
            }
            $("#searchForm").submit();

        });
    });
</script>
</body>
</html>