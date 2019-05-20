
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>手续费设置</title>

    <style>
        body{
            min-width: 0;
            overflow: hidden;
        }
        .plat_box{
            margin-top: 50px;
            margin-left: 50px;
        }
        .plat_box input{
            width: 250px;
        }
        .layui-form-label{
            width: 200px;
        }
    </style>
</head>
<body>
<div class="plat_box">
<form id="inputForm" action="${ctx}/rule/setServiceCharge" class="layui-form" lay-filter="inputForm">
    <div class="layui-inline">
        <label class="layui-form-label">默认手续费(单位：元)：</label>
        <div class="layui-input-inline">
            <input type="text"  id="defaultCharge" name="defaultCharge" value="${serviceCharge.defaultCharge}" class="layui-input" lay-verify="required|number">
        </div>
    </div>
    <br/><br/>
    <div class="layui-inline">
        <label class="layui-form-label">限制数值(单位：元)：</label>
        <div class="layui-input-inline">
            <input type="text"  id="limited" name="limited" value="${serviceCharge.limited}" class="layui-input" lay-verify="required|number">
        </div>
    </div>
    <br/><br/>
    <div class="layui-inline">
        <label class="layui-form-label">限制后的手续费(单位：元)：</label>
        <div class="layui-input-inline">
            <input type="text"  id="limitedCharge" name="limitedCharge" value="${serviceCharge.limitedCharge}" class="layui-input" lay-verify="required|number">
        </div>
    </div>
    <br/><br/>

    <div >
        <button id="submit_btn" class="layui-btn layui-btn-normal submit" style="margin-left: 230px;" >保存</button>
    </div>
</form>
</div>
<script>


    layui.use('layer', function(){
        var layer = layui.layer;
        var state='${state}';
      if(state=='true'){
            parent.layer.msg("保存成功！")
        }
    });

</script>
</body>
</html>
