<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<title>注册信息</title>
<style>
body{
    min-width: 0;
}
.plat_box{
    margin-top: 50px;
}
.plat_box input{
    width: 235px;
}
.layui-form-label{
    width: 80px;
}
</style>
</head>
<body>
<div class="plat_box">
    <form id="inputForm" action="" class="layui-form" lay-filter="inputForm">
        <input type="hidden" id="id" name="id" value="${user.id}">
        <%--<input type="hidden" id="companyId" name="companyId" value="${user.companyId}">--%>
        <div class="layui-inline">
            <label class="layui-form-label">姓名：</label>
            <div class="layui-input-inline" style="float: left;">
                <input type="text" value="${user.userName}" class="layui-input" readonly="readonly">
            </div>
            <label class="layui-form-label">性别：</label>
            <div class="layui-input-inline" style="float: left;">
                <c:if test="${user.sex == 1}">
                    <input type="text" value="男" class="layui-input" readonly="readonly">
                </c:if>
                <c:if test="${user.sex == 0}">
                    <input type="text" value="女" class="layui-input" readonly="readonly">
                </c:if>
            </div>
        </div>
        <br/><br/>
        <div class="layui-inline">
            <label class="layui-form-label">手机号：</label>
            <div class="layui-input-inline" style="float: left;">
                <input type="text" value="${user.phone}" class="layui-input" readonly="readonly">
            </div>
            <label class="layui-form-label">身份证号：</label>
            <div class="layui-input-inline" style="float: left;">
                <input type="text" value="${user.idCard}" class="layui-input" readonly="readonly">
            </div>
        </div>
        <br/><br/>
        <div class="layui-inline">
            <label class="layui-form-label">注册时间：</label>
            <div class="layui-input-inline" style="float: left;">
                <input type="text" value="<fmt:formatDate value="${user.registerDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" class="layui-input" readonly="readonly">
            </div>
        </div>
        <br/><br/>
        <c:if test="${user.companyType == 2 || user.companyType == 3}">
            <div class="layui-inline">
                <label class="layui-form-label">企业名称：</label>
                <div class="layui-input-inline" style="float: left;">
                    <input type="text" value="${company.companyName}" class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label">企业编码：</label>
                <div class="layui-input-inline" style="float: left;">
                    <input type="text" value="${company.companyCode}" class="layui-input" readonly="readonly">
                </div>
            </div>
            <br/><br/>
            <div class="layui-inline">
                <label class="layui-form-label">地址：</label>
                <div class="layui-input-inline" style="float: left;">
                    <input type="text" value="${company.companyAddress}" class="layui-input" readonly="readonly">
                </div>
                <label class="layui-form-label">营业执照:</label>
                <div class="layui-input-inline" style="margin-left: 20px;">
                    <img class="img-mini zheng_a" src="${ctx}${company.businessPic}" onclick="fun_zheng(this);" alt="营业执照" id="businessPicImg">
                </div>
            </div>
            <br/><br/>
        </c:if>
    </form>
</div>
<script>
    //图片放大
    function fun_zheng(obj) {
        layer.open({
            type: 2,
            title: false,
            shadeClose: false,
            shade: 0,
            shift: -1,
            area: ['570px', '390px'],
            content: obj.src
        })
    }
</script>
</body>
</html>