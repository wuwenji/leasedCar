<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>包车方时间设置</title>
    <style>
        body {
            min-width: 0;
            overflow: hidden;
        }

        .plat_box {
            margin-top: 50px;
            margin-left: 50px;
        }

        .plat_box input {
            width: 250px;
        }

        .layui-form-label {
            width: 100px;
        }
    </style>
</head>
<body>
<div class="plat_box">
    <form id="inputForm" action="" class="layui-form" lay-filter="inputForm">
        <input type="hidden" name="type" value="${type}">
        <input type="hidden" name="id" value="${setValue.id}">
        <input type="hidden" name="companyCode" value="${companyCode}">
        <div class="layui-inline">

            <c:if test="${type == 1}">
                <label class="layui-form-label">时间：</label>
            </c:if>
            <c:if test="${type == 2}">
                <label class="layui-form-label">自运营车上限数量：</label>
            </c:if>

            <div class="layui-input-inline">
                <input type="text" name="value" value="${setValue.value}" class="layui-input"
                       lay-verify="required|number">
            </div>
        </div>
        <br/><br/>
        <div style="display: none;">
            <button id="submit_btn" class="layui-btn layui-btn-normal submit" lay-submit></button>
        </div>
    </form>
</div>
<script>
    //校验
    layui.use(['form'], function () {
        var form = layui.form;
        //监听提交
        form.on('submit(inputForm)', function (data) {
            doSetDiscount();
            return false;
        });
        //自定义验证规则
        form.verify({
            double: function (value, item) {
                if (!/(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/.exec(value)) {
                    return "请输入正确的优惠率！";
                }
            }

        });
    });

    function doSetDiscount() {

        var companyCode = $("[name='companyCode']").val();
        var id = $("[name='id']").val();
        var type = $("[name='type']").val();
        var value = $("[name='value']").val();

        var dataJson = {"id": id, "type": type, "value": value, "companyCode": companyCode};

        $.ajax({
            type: "post",
            url: "${ctx}/charter/order/setDay",
            dataType: "json",
            data: dataJson,
            success: function (data) {

                if (data.state == 'success') {
                    layer.msg("操作成功！", {
                            icon: 1,
                            time: 1000
                        },
                        function () {
                            parent.layer.closeAll();

                        }
                    );
                }
            }
        });
    }
</script>
</body>
</html>