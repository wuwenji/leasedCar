<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>个人中心</title>
</head>
<body>
<section>
	<div class="container">
		<jsp:include page="/WEB-INF/layouts/left_menu.jsp" />
		<main>
		<div class="position_all">
			<div class="position">您所在的位置：首页 -> 用户管理 -> 个人中心</div>
		</div>
			<div class="layui-tab layui-tab-card">
			
				<ul class="layui-tab-title">
					<li>企业信息</li>
                    <li class="layui-this">个人信息</li>
					<li>修改密码</li>
				</ul>
                <!--主体内容-->
                <div class="layui-tab-content">
					<!-- 企业信息 start-->
					<div class="layui-tab-item layui-form">
						<input type="hidden" id="companyCodeEncoder" name="companyCodeEncoder"/>
						<form class="layui-form layui-form-pane"  action="${ctx}/transport/center/updateUser" method="post">

							<div class="layui-form-item">
								<label class="layui-form-label">企业名称</label>
								<div class="layui-input-inline">
									<input <%--name="companyName"--%> lay-verify="required" value="${company.companyName}" autocomplete="off" class="layui-input" type="text" disabled>
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">企业编码</label>
								<div class="layui-input-inline">
									<input <%--name="companyCode"--%> lay-verify="required" value="${company.companyCode}" autocomplete="off" class="layui-input" type="text" disabled>
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">联系电话</label>
								<div class="layui-input-inline">
									<input id="companyPhone" name="phone" lay-verify="phone|companyCheckPhone" value="${mainUser.phone}"
										   autocomplete="off" class="layui-input company_phone" type="text"
										   onkeyup="companyChangePhone(this.value);"
										   <c:if test="${user.type eq 0}">disabled</c:if>>
								</div>
								<div class="layui-input-inline">
									<input class="layui-btn company_code_btn" style="background: #c0c0c0;" type="button"
										   value="获取验证码" disabled>
								</div>
							</div>
							<div class="layui-form-item company_code_div" style="display: none;">
								<label class="layui-form-label">验证码</label>
								<div class="layui-input-inline">
									<input type="text" name="code" placeholder="请输入验证码" class="layui-input"
										   lay-verify="">
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">地址</label>
								<div class="layui-input-inline">
									<input <%--name="companyAddress"--%> lay-verify="required" value="${company.companyAddress}" autocomplete="off" class="layui-input" type="text" disabled>
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">邮箱</label>
								<div class="layui-input-inline">
									<input name="email" lay-verify="email" value="${mainUser.email}" autocomplete="off"
										   class="layui-input" type="text" <c:if test="${user.type eq 0}">disabled</c:if> >
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">类型</label>
								<div class="layui-input-inline">
									<input <%--name="type"--%> lay-verify="required" value="股份有限公司" autocomplete="off" class="layui-input" type="text" disabled>
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">法定代表人</label>
								<div class="layui-input-inline">
									<input name="userName" lay-verify="required|existsName" value="${mainUser.userName}" autocomplete="off"
										   class="layui-input" type="text" <c:if test="${user.type eq 0}">disabled</c:if> />
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">注册时间</label>
								<div class="layui-input-inline">
									<input <%--name="registerDate"--%> lay-verify="required"  autocomplete="off" class="layui-input" type="text" disabled
									value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${company.registerDate}"/>'/>
								</div>
							</div>
							<div class="layui-form-item">
								<button lay-submit class="layui-btn layui-btn-normal">确认修改</button>
							</div>
						</form>
					</div>
					<!-- 企业信息 end-->

                    <!-- 个人信息 start-->
                    <div class="layui-tab-item layui-show layui-form">
						<input type="hidden" id="codeEncoder" name="codeEncoder"/>
                        <form class="layui-form layui-form-pane" action="${ctx}/transport/center/updateUser" method="post">
                            <input id="checkphone" value="${user.phone}" type="hidden">
                            <div class="layui-form-item">
                                <label class="layui-form-label">姓名</label>
                                <div class="layui-input-inline">
                                    <input name="userName" lay-verify="required|existsName" value="${user.userName}" autocomplete="off" class="layui-input" type="text">
                                </div>
                            </div>
                            <div class="layui-form-item" style="width: 298px;" pane="">
                                <label class="layui-form-label">性别</label>
                                <div class="layui-input-inline">
                                    <input name="sex" value="1" title="男" <c:if test="${empty user.sex || user.sex == 1}">checked</c:if> type="radio">
                                    <input name="sex" value="0" title="女" <c:if test="${user.sex == 0}">checked</c:if> type="radio">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">身份证</label>
                                <div class="layui-input-inline">
                                    <input name="idCard" lay-verify="identity" value="${user.idCard}" autocomplete="off" class="layui-input" type="text">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">手机号</label>
                                <div class="layui-input-inline">
                                    <input id="userPhone" name="phone" lay-verify="phone|checkPhone" value="${user.phone}"
										   autocomplete="off" class="layui-input person_phone" type="text" onkeyup="changePhone(this.value);">
                                </div>
								<div class="layui-input-inline">
									<input class="layui-btn code_btn" style="background: #c0c0c0;" type="button"
										   value="获取验证码" disabled>
								</div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">创建日期</label>
                                <div class="layui-input-inline">
                                    <input name="registerDate" autocomplete="off" class="layui-input" type="text" disabled
                                           value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${user.registerDate}"/>'/>
                                </div>
                            </div>

                            <div class="layui-form-item">
                                <button class="layui-btn layui-btn-normal">确认修改</button>
                            </div>
                        </form>
                    </div>
                    <!-- 个人信息 end-->
					
					<!-- 修改密码 start-->
					<div class="layui-tab-item layui-form">
						<form class="layui-form layui-form-pane" action="${ctx}/transport/center/updatePw" method="post">
							<div class="layui-form-item">
								<label class="layui-form-label">原始密码</label>
								<div class="layui-input-inline">
									<input name="userPassword" lay-verify="required" autocomplete="off" class="layui-input" type="password">
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">新密码</label>
								<div class="layui-input-inline">
									<input name="newPassword" lay-verify="required" autocomplete="off" class="layui-input" type="password">
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">确认密码</label>
								<div class="layui-input-inline">
									<input name="confirmPassword" lay-verify="required" autocomplete="off" class="layui-input" type="password">
								</div>
							</div>
							<div class="layui-form-item">
								<button type="button" class="layui-btn layui-btn-normal" onclick="submitPw();">确认修改</button>
							</div>
						</form>
					</div>
					<!-- 修改密码 end-->
					
				</div>
			</div>
			</main>
	</div>
</section>
<script type="text/javascript">
//文档加载完毕执行
$(function() {
	var message = '${message}';
	if(message != null && "" != message){
		var msg = message.split("@");
		setTimeout(function(){
			layer.msg(msg[0], {icon: msg[1],time:1000});
		}, 500);
	}
});
//加载表单
layui.use(['form','element','laydate'], function() {
	
    var form = layui.form;
    
  	//监听提交
    form.on('submit(pwForm)', function(data){
      layer.msg(JSON.stringify(data.field));
      return false;
    });
  	
    //自定义验证规则
    form.verify({
        //只能输入数字
        integer:function (value,item) {
            if(!/^[0-9]*$/.exec(value)){
                return "只能输入数字";
            }
        },
        existsName: function (value, item) {
            var msg = "";
            $.ajax({
                type: "POST",
                url: "${ctx}/charter/center/existsName",
                data: {"userName": value},
                dataType: "json",
                async: false,//阻止在未返回结果前弹出（非结果）提示
                success: function (data) {
                    if (data) {
                        msg = "该名称已被注册！";
                    }
                }
            });
            return msg;
        },
        companyCheckPhone: function (value, item) {
            var phone = $('#companyCheckphone').val();
            if (phone != value) {
                var dataJson = {"phone": value};
                var result = check(dataJson, '${ctx}/register/checkLogin');
                if (!result) {
                    return "手机号已被注册！";
                }
            }
        },
        checkPhone: function (value,item) {
            var phone = $('#checkphone').val()
            //alert("phone="+phone)
            if(phone != value ){
            var dataJson = {"phone":value};
            var result = check(dataJson, '${ctx}/register/checkLogin');
            if(!result){
                return "手机号已被注册！";
            }
			}
        },
        companyCheckCode: function (value, item) {
            var phone = $("#companyPhone").val()
            var codeEncoder = $("[name='companyCodeEncoder']").val()
            var dataJson = {"code": value, "phone": phone, "codeEncoder": codeEncoder};
            var result = check(dataJson, '${ctx}/register/checkCode');
            if (!result.state) {
                return "验证码错误或超时！";
            }
        },
        checkCode: function (value, item) {
            var phone = $("#userPhone").val()
            var codeEncoder = $("[name='codeEncoder']").val()
            var dataJson = {"code": value, "phone": phone, "codeEncoder": codeEncoder};
            var result = check(dataJson, '${ctx}/register/checkCode');
            if (!result.state) {
                return "验证码错误或超时！";
            }
        }
    });
});

//提交修改密码
function submitPw(){
	var userPassword = $('[name=userPassword]').val();
	if(userPassword == ''){
		layer.msg('原始密码不能为空', {icon: 2,time:1000});
		$('[name=userPassword]').focus();
		return;
	}
	var newPassword = $('[name=newPassword]').val();
	if(newPassword == ''){
		layer.msg('新密码不能为空', {icon: 2,time:1000});
		$('[name=newPassword]').focus();
		return;
	}
	var confirmPassword = $('[name=confirmPassword]').val();
	if(confirmPassword == ''){
		layer.msg('确认密码不能为空', {icon: 2,time:1000});
		$('[name=confirmPassword]').focus();
		return;
	}
	if(confirmPassword != newPassword){
		layer.msg('确认密码不一致', {icon: 2,time:1000});
		$('[name=newPassword]').focus();
		return;
	}
	 $.ajax({
         type: "POST",
         url: "${ctx}/transport/center/updatePw",
         data: {'userPassword': userPassword, 'newPassword': newPassword},
         dataType: "json",
         success: function(data){
        	 if(data==-2){
        		 layer.msg('系统错误', {icon: 2,time:1000});
        	 }
        	 if(data==-1){
        		 layer.msg('原始密码不正确', {icon: 2,time:1000});
        	 }
        	 if(data==0){
        		 layer.msg('密码修改成功,请重新登陆', {icon: 1,time:2000},function(){
        			 //location.reload();
        			 fun_loging('${ctx}/login');
        		 });
        	 }
         }
     });
}


function companyChangePhone(phone) {
    var checkPhone = $('#companyCheckphone').val();
    if (phone != checkPhone) {
        if (phone != null && '' != phone && phone.trim().length == 11) {
            if ((/^1[3|4|5|7|8][0-9]\d{4,8}$/.test(phone))) {
                $('.company_code_btn').css("background", "");
                $('.company_code_btn').removeAttr("disabled");//启用按钮
                $('.company_code_div').css("display", "");
                $("[name='company_code']").attr("lay-verify", "required|companyCheckCode");
            } else {
                layer.msg("请输入正确的手机号码", {icon: 5});
            }
        }
    } else {
        $('.company_code_btn').attr("disabled", "true");
        $('.company_code_btn').css("background", "#c0c0c0");
        $('.company_code_div').css("display", "none");
        $("[name='company_code']").attr("lay-verify", "");
    }
}

function changePhone(phone) {
    var checkPhone = $('#checkphone').val();
    if (phone != checkPhone) {
        if (phone != null && '' != phone && phone.trim().length == 11) {
            if ((/^1[3|4|5|7|8][0-9]\d{4,8}$/.test(phone))) {
                $('.code_btn').css("background", "");
                $('.code_btn').removeAttr("disabled");//启用按钮
                $('.code_div').css("display", "");
                $("[name='code']").attr("lay-verify", "required|checkCode");
            } else {
                layer.msg("请输入正确的手机号码", {icon: 5});
            }
        }
    } else {
        $('.code_btn').attr("disabled", "true");
        $('.code_btn').css("background", "#c0c0c0");
        $('.code_div').css("display", "none");
        $("[name='code']").attr("lay-verify", "");
    }
}

function checkPhoneExists(value) {
    var result = false;
    if (value == '${user.phone}') {

    } else {
        var dataJson = {'phone': value};
        result = check(dataJson, '${ctx}/register/checkLogin');
        if (!result) {
            layer.msg("手机号码已被注册")
            $("#phone").val(null);
        }
    }
    return result;
}

var wait = 60;
var interValObj;

$('.company_code_btn').click(function () {
    var phone = $(".company_phone").val();
    if (phone != null && '' != phone) {
        if ((/^1[3|4|5|7|8][0-9]\d{4,8}$/.test(phone))) {
            if(checkPhoneExists(phone)){
                $('.company_code_btn').attr("disabled", "true");
                $('.company_code_btn').css("background", "#c0c0c0");
                $('.company_code_btn').val("倒计时" + wait + "秒");
                interValObj = window.setInterval(setRemainTime, 1000);
                $.ajax({
                    type: "post",
                    dataType: "json",
                    url: "${ctx}/register/getSms",
                    data: {"phone": phone},
                    success: function (data) {
                        if (!data.state) {
                            window.clearInterval(interValObj);//停止计时器
                            $('.company_code_btn').css("background", "");
                            $('.company_code_btn').removeAttr("disabled");//启用按钮
                            $('.company_code_btn').val("获取验证码");
                            layer.msg("验证码发送失败！请稍后重试！", {icon: 5});
                        } else {
                            $('#companyCodeEncoder').val(data.code);
                        }
                    }
                });
            }
        } else {
            layer.msg("请输入正确的手机号码", {icon: 5});
        }
    }
});
function setRemainTime() {
    if (wait == 0) {
        window.clearInterval(interValObj);//停止计时器
        $('.company_code_btn').css("background", "");
        $('.company_code_btn').removeAttr("disabled");//启用按钮
        $('.company_code_btn').val("获取验证码");
        wait = 60;
    } else {
        wait--;
        $('.company_code_btn').val("倒计时" + wait + "秒");
    }
}

$('.code_btn').click(function () {
    var phone = $(".person_phone").val();
    if (phone != null && '' != phone) {
        if ((/^1[3|4|5|7|8][0-9]\d{4,8}$/.test(phone))) {
            if(checkPhoneExists(phone)){
                $('.code_btn').attr("disabled", "true");
                $('.code_btn').css("background", "#c0c0c0");
                $('.code_btn').val("倒计时" + wait + "秒");
                interValObj = window.setInterval(setRemainTime, 1000);
                $.ajax({
                    type: "post",
                    dataType: "json",
                    url: "${ctx}/register/getSms",
                    data: {"phone": phone},
                    success: function (data) {
                        if (!data.state) {
                            window.clearInterval(interValObj);//停止计时器
                            $('.code_btn').css("background", "");
                            $('.code_btn').removeAttr("disabled");//启用按钮
                            $('.code_btn').val("获取验证码");
                            layer.msg("验证码发送失败！请稍后重试！", {icon: 5});
                        } else {
                            $('#codeEncoder').val(data.code);
                        }
                    }
                });
            }
        } else {
            layer.msg("请输入正确的手机号码", {icon: 5});
        }
    }
});
function setRemainTime() {
    if (wait == 0) {
        window.clearInterval(interValObj);//停止计时器
        $('.code_btn').css("background", "");
        $('.code_btn').removeAttr("disabled");//启用按钮
        $('.code_btn').val("获取验证码");
        wait = 60;
    } else {
        wait--;
        $('.code_btn').val("倒计时" + wait + "秒");
    }
}

function check(dataJson, url) {
    var result = true;
    $.ajax({
        async: false,
        type: "post",
        url: url,
        dataType: "json",
        data: dataJson,
        success: function (data) {
            result = data.state;
        }
    });
    return result;
}
</script>
</body>
</html>