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

   <!--
    <div class="logout_box">
        <ul class="login-tab">
            <li class="loginpic"></li>
            <li class="loginma"></li>
        </ul>
      -->
        <div class="logout_info">
            <h2></h2>
            <form id="login_form" action="${ctx}/login" method="post">
                <input type="hidden" id="codeEncoder" name="codeEncoder"/>
                <div class="input-prepend" style="margin-top: 25px;">
                    <span class="add-on"><i class="icon-user icon-large"></i></span>
                    <input class="span2" id="username" name="username" type="text" placeholder="请输入账号">
                </div>
                <div class="input-prepend" style="margin-top: 25px;">
                    <span class="add-on"><i class="icon-key icon-large"></i></span>
                    <input class="span2" id="password" name="password" type="password" placeholder="请输入密码">
                </div>
                <p class="logphone"><a href="javascript:;">短信快捷登录</a></p>
                <p style="text-align:center;margin-left:0;margin-top:50px">
                    <a class="layui-btn layui-btn-normal" onclick="login();">登&nbsp;录</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a class="layui-btn layui-btn-primary" onclick="register();">注&nbsp;册</a>
                </p>
                <p>
                    <a style="color: #1E9FFF;margin-left: 55px;" onclick="forgetPwd();">忘记密码?</a>
                </p>
            </form>
            <form  id="login_form2" action="${ctx}/login" method="post">
                <div class="input-prepend" style="margin-top: 25px;">
                    <span class="add-on"><i class="icon-phone icon-large"></i></span>
                    <input class="span2" id="phone" name="phone" type="text" placeholder="请输入手机号">
                </div>
                <div class="input-prepend" style="margin-top: 25px;">
                    <span class="add-on"><i class="icon-key icon-large"></i></span>
                    <input class="span2 code"  id="code" name="code" type="text" placeholder="请输入验证码">
                  <!--  <span class="span2 getcode">获取验证码</span> -->
                    <input class="layui-btn code_btn" type="button" value="获取验证码" lay-verify="required" style="margin-left: 10px;margin-bottom: 10px !important;">
                </div>
                <p class="loguser"><a href="javascript:;">用户名密码登录</a></p>
                <p style="text-align:center;margin-left:0;margin-top:50px">
                    <a class="layui-btn layui-btn-normal" onclick="phonelogin();">登&nbsp;录</a>&nbsp;&nbsp;&nbsp;&nbsp;
                    <a class="layui-btn layui-btn-primary" onclick="register();">注&nbsp;册</a>
                </p>
                <p>
                    <a style="color: #1E9FFF;margin-left: 55px;" onclick="forgetPwd();">忘记密码?</a>
                </p>
            </form>
        </div>
        <div class="logout_info1" >
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
    //登录窗口方式切换
    $('.logphone a').click(function() {
        $('#login_form').hide()
        $('#login_form2').show()
    })
    $('.loguser a').click(function() {
        $('#login_form').show()
        $('#login_form2').hide()
    })
    var obj = new WxLogin({
        id:"di",
        appid: "wxb2acefba99a3fbcf",
        scope: "snsapi_login",
        redirect_uri: "http%3a%2f%2ftravelbus.jmqyjt.com%2fWechatLogin%2fwechatLogin",
        state: "",
        style: "black",
        href: ""
    });




    $('.login-tab li').click(function(){
        $(this).css('display','none');
        $(this).siblings().css('display','block');
        if($(this).index() == 1){
            $('.logout_info1').show();
            $('.logout_info').hide();
        }else{
            $('.logout_info').show();
            $('.logout_info1').hide();
        };
    });
    document.onkeydown=function(e){
        if((e.keyCode || e.which) == 13){
            login();
        }
    }

    function login() {
        var username = $("#username").val();
        if(!(username != null && '' != username)){
            layer.tips('请输入账号！', '#username', {tips: [3, '#78BA32']});
            return false;
        }
        var password = $("#password").val();
        if(!(password != null && '' != password)){
            layer.tips('请输入密码！', '#password', {tips: [3, '#78BA32']});
            return false;
        }
        $("#login_form").submit();
    }

    
    
    function phonelogin() {
        var phone = $("#phone").val();
        if(!(phone != null && '' != phone)){
            layer.tips('请输入手机号码！', '#phone', {tips: [3, '#78BA32']});
            return false;
        }
        var code = $("#code").val();
        if(!(code != null && '' != code)){
            layer.tips('请输入验证码！', '#code', {tips: [3, '#78BA32']});
            return false;
        }

        var codeEncoder =$("#codeEncoder").val();
        var dataJson = {"code":code, "phone":phone, "codeEncoder":codeEncoder};


        var result = check(dataJson, '${ctx}/register/checkCode');
        if(!result.state){

            layer.tips('验证码错误或超时！', '#code', {tips: [3, '#78BA32']});
            return false;
        }
        $("#login_form2").submit();
    }

    function check(dataJson, url) {
        var result = true;
        $.ajax({
            async:false,
            type:"post",
            url:url,
            dataType:"json",
            data:dataJson,
            success:function(data) {
                result = data.state;
            }
        });
        return result;
    }

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


    
    function register(){
    	parent.location.href="${ctx}/register";
    }

    layui.use(['form'], function(){
        var message = '${message}';
        if(message != null && '' != message){
            if(message=='0'){
                layer.msg('登陆成功！',{icon:1, time:500},function(){
                	  var role = '${role}';
                      if(role.indexOf('sys') != -1){
                          top.location.href = "${ctx}/main";
                          return false;
                      }else if(parent.location.href.indexOf('search/charter') != -1){
                     		parent.loginAfter();
                         	//parent.layer.closeAll();
                      }else{
                      	top.location.href = "${ctx}/user/main";
                      }
                });
            }
            if(message=='1'){
                layer.tips('请输入正确的账号！', '#username', {tips: [3, '#78BA32']});
                return false;
            }
            if(message=='2'){
                layer.tips('请输入正确的密码！', '#password', {tips: [3, '#78BA32']});
                return false;
            }
            if(message=='3'){
                layer.msg('账号被禁用或在审核中！', function () {});
                return false;
            }
            if(message=='4'){
                layer.msg('账号无分配权限，请联系管理员！', function () {});
                return false;
            }
            if(message =='5'){
                layer.msg('该手机号码暂未注册！');
            }
        }
    });

    $('body').click(function(){
        if($('#dl_show').next('dl').css('display') == 'block'){
            $('#dl_show').next('dl').slideUp();
        }
    })


    function forgetPwd() {
        parent.layer.open({
            type: 2,
            title: "重置密码",
            shadeClose: false,
            shade: 0.5,
            /*  shift:-1, */
            area: ['570px', '490px'],
            content: "${ctx}/login/forgetPwd",
            btn: ['取消'],
            yes: function (index, layero) {
              parent.layer.close(index);
            },
            cancel: function (index, layero) {
            }
        })
    }

</script>
</body>
</body>
</html>