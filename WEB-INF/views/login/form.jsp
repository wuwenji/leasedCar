<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>登陆1</title>
    <style>
        body{background: #ffffff;}
    </style>
    <script src="http://res.wx.qq.com/connect/zh_CN/htmledition/js/wxLogin.js"></script>
</head>
<body>
<div class="logout_left"></div>
<div class="logout_right">
    <div class="logout_box">
        <%--<ul class="login-tab">--%>
        <%--<li class="loginpic"></li>--%>
        <%--<li class="loginma"></li>--%>
        <%--</ul>--%>
        <div class="logout_info">
            <h2></h2>
            <form  id="inputForm" class="layui-form" action="${ctx}/login/init" method="post" lay-filter="inputForm">
                <input type="hidden" id="codeEncoder" name="codeEncoder"/>
                <div class="layui-form-item">
                    <label class="layui-form-label"><span class="red">*</span> 手机号</label>
                    <div class="layui-input-inline" style="width:230px;">
                        <input type="text" name="phone" class="layui-input" placeholder="请输入手机号" lay-verify="required|phone|checkPhone" style="width: 100%;">
                    </div>
                    <div class="layui-input-inline" style="width:auto;margin-right:0px;">
                        <input class="layui-btn code_btn" type="button" value="获取验证码" lay-verify="required">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label"><span class="red">*</span> 验证码</label>
                    <div class="layui-input-block">
                        <input type="text" name="code" placeholder="请输入验证码" class="layui-input" lay-verify="required|checkCode" style="width: 50%;">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label"><span class="red">*</span> 密码</label>
                    <div class="layui-input-block">
                        <input type="password" name="userPassword" placeholder="密码不能少于6位数" class="layui-input" lay-verify="required|length" style="width: 50%;">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label"><span class="red">*</span> 确认密码</label>
                    <div class="layui-input-block">
                        <input type="password" name="newPassword" placeholder="密码不能少于6位数" class="layui-input" lay-verify="required|length|equals" style="width: 50%;">
                    </div>
                </div>
                <div class="center" style="margin-left: 60px; margin-top: 50px;">
                    <a href="javascript:;" class="layui-btn layui-btn-normal sign-next" lay-filter="inputForm" lay-submit>提&nbsp;&nbsp;交</a>
                    <a class="layui-btn layui-btn-primary" onclick="cleanPwd();">重&nbsp;&nbsp;置</a>
                </div>
            </form>
        </div>
        <div class="logout_info1">
            <br/><br/>
            <div id="di"></div>
            <!--<img src="${ctx}/static/images/wx.jpg" alt=""> -->
            <div class="cl"></div>
            <br/>
            手机扫码，安全登录
        </div>
    </div>
</div>
<script>
    var wait=60;
    var interValObj;
    $('.code_btn').click(function () {
        var phone = $("[name='phone']").val();
        if(phone != null && '' != phone){
            if((/^1[3|4|5|7|8][0-9]\d{4,8}$/.test(phone))){
                $('.code_btn').attr("disabled", "true");
                $('.code_btn').css("background", "#c0c0c0");
                $('.code_btn').val("倒计时" + wait + "秒");
                interValObj = window.setInterval(setRemainTime, 1000);
                $.ajax({
                    type:"post",
                    dataType:"json",
                    url:"${ctx}/register/getSms",
                    data:{"phone":phone},
                    success: function(data) {
                        if(!data.state){
                            window.clearInterval(interValObj);//停止计时器
                            $('.code_btn').css("background", "");
                            $('.code_btn').removeAttr("disabled");//启用按钮
                            $('.code_btn').val("获取验证码");
                        }else{
                            $('#codeEncoder').val(data.code);
                        }
                    }
                });
            }else{
                layer.msg("请输入正确的手机号码", {icon: 5});
            }
        }
    })
    function setRemainTime() {
        if (wait == 0) {
            window.clearInterval(interValObj);//停止计时器
            $('.code_btn').css("background", "");
            $('.code_btn').removeAttr("disabled");//启用按钮
            $('.code_btn').val("获取验证码");
            wait = 60;
        }else {
            wait--;
            $('.code_btn').val("倒计时" + wait + "秒");
        }
    }

    //校验
    layui.use(['form'], function() {
        var form = layui.form;
        //监听提交
        form.on('submit(inputForm)', function(data){
           // console.log(data.field)
            //var dataJson = JSON.stringify(data.field);
            submit_(data.field);
            return false;
        });
        //监听下拉
        form.on('select(roleName)', function(data){
            if(data.value.indexOf("admin") != -1){
                $("#company_div").slideDown();
                $("[name='Address']").attr('lay-verify','required');
                $("[name='companyName']").attr('lay-verify','required');
            }else{
                $("#company_div").slideUp();
                $("[name='Address']").removeAttr('lay-verify');
                $("[name='companyName']").removeAttr('lay-verify');
            }
        });
        //自定义验证规则
        form.verify({
            checkCode: function (value,item) {
                var phone = $("[name='phone']").val()
                var codeEncoder = $("[name='codeEncoder']").val()
                var dataJson = {"code":value, "phone":phone, "codeEncoder":codeEncoder};
                var result = check(dataJson, '${ctx}/register/checkCode');
                if(!result.state){
                    return "验证码错误或超时！";
                }
            },
            length: function (value, item) {
                if(value.length < 6){
                    return "密码不能少于6位";
                }
            },
            equals: function (value,item) {
                if( $("[name='userPassword']").val()!=value)
                    return "两次密码不一致！";
            }
        });
    });

    function cleanPwd() {
        $("[name='userPassword']").val(null);
        $("[name='newPassword']").val(null);
    }


    function submit_(dataJson) {
        $('.layui-layer-btn0').css('pointer-events','none');
        $.ajax({
            type:"post",
            url:"${ctx}/login/init",
            dataType:"json",
            data:dataJson,
            success:function(data) {
                if(data.state == true){
                    layer.msg("修改成功,请重新登录！", {icon: 1,time:1000});
                    var index=parent.layer.getFrameIndex(window.name);

                    setTimeout(function(){close(index);},2000);
                }else {
                    layer.msg("修改失败,请联系管理员！", {icon: 5});
                }
            }
        });
    }

    function close(index) {
        parent.layer.close(index);
    }
</script>
</body>
</body>
</html>