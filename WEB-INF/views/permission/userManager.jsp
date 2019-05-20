<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>用户管理</title>
    <style type="text/css">
        /*.button_left {*/
            /*margin-top: 0px;*/
        /*}*/
        body{
            min-width: 400px !important;
            max-width: 700px !important;
        }
    </style>
</head>
<body>
<form id="searchForm" action="${ctx}/permission/userManager" method="post" class="layui-form" style="margin: 10px 0 auto 40px;">
    <input type="hidden" name="pageNum" value="${user.pageNum}"/>
    <input type="hidden" name="pageSize" value="${user.pageSize}"/>
    <input type="hidden" name="companyCode" value="${user.companyCode}"/>
    <div class="button_right">
        <input type="text" name="param" class="layui-input" placeholder="请输入关键字" value="${user.param}">
        <button id="submitBtn" class="layui-btn layui-btn-small" onclick="selfSubmit()">搜索</button>
    </div>
    <div class="cl"></div>
    <table class="layui-table" style="text-align: center;">
        <colgroup>
            <col width="30">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col>
        </colgroup>
        <thead>
        <tr>
            <th>序号</th>
            <th>账号</th>
            <th>姓名</th>
            <th>性别</th>
            <th>手机号</th>
            <th>身份证号</th>
            <th>状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${users.list}" var="user" varStatus="vs">
            <tr>
                <td>${vs.index+1}</td>
                <td>${user.userAccount}</td>
                <td>${user.userName}</td>
                <td>
                    <c:if test="${user.sex == 0}">
                        女
                    </c:if>
                    <c:if test="${user.sex == 1}">
                        男
                    </c:if>
                </td>
                <td>${user.phone}</td>
                <td>${user.idCard}</td>
                <td>
                    <c:if test="${user.status == 0}">启用</c:if>
                    <c:if test="${user.status == 1}">禁用</c:if>
                    <c:if test="${user.status == 2}">不通过</c:if>
                </td>
                <td style="white-space: nowrap;">
                    <c:if test="${user.status == 0}"><a href="javascript:updateById('${user.id}',1);"
                                                            class="layui-btn layui-btn-primary layui-btn-mini"><i
                            class="icon-remove"></i> 禁用</a></c:if>
                    <c:if test="${user.status == 1}"><a href="javascript:updateById('${user.id}',0);"
                                                            class="layui-btn layui-btn-primary layui-btn-mini"><i
                            class="icon-remove"></i> 启用</a></c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <tags:page pages="${users}"/>
</form>
<script type="text/javascript">

    //提交搜索表单
    function selfSubmit() {
        $("[name='pageNum']").val(1);
        $("#searchForm").submit();
    }

    /*
     * status:
     * 0:启用 1:禁用 2:不通过
     */
    function updateById(id, status) {
        var title = (status == 0 ? '启用' : '禁用');
        parent.layer.confirm('确定' + title + '这个用户么?', {icon: 3, title: '提示'}, function (index) {
            $.ajax({
                type: "POST",
                url: "${ctx}/sys/user/updateById",
                data: {'id': id, 'status': status},
                dataType: "json",
                success: function (data) {
                    if (data > 0) {
                        parent.layer.open({
                            icon: 1,
                            title: '信息',
                            skin: 'layer-ext-myskin',
                            shade: 0, //不显示遮罩
                            content: "操作成功！",
                            yes: function (index1) {
                                parent.layer.close(index1);
                                $('#submitBtn').click();
                            },
                        });
                    } else {
                        parent.layer.open({
                            icon: 2,
                            title: '信息',
                            skin: 'layer-ext-myskin',
                            shade: 0, //不显示遮罩
                            content: "操作失败！"
                        });
                    }
                }
            });
        });
    }


</script>
</body>
</html>