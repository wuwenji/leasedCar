<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>添加用户</title>
</head>
<body class="window">
<div style="margin-top: 10px;" class="layui-form">
    <form id="saveOrUpdate" class="layui-form" action="${ctx}/transport/user/saveOrUpdate" method="post"
          enctype="multipart/form-data">
        <input type="hidden" id="id" name="id" value="${user.id}"/>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">账号:</label>
                <div class="layui-input-inline">
                    <input name="userAccount" lay-verify="required|userAccountUnique" autocomplete="off"
                           value="${user.userAccount}" placeholder="账号" class="layui-input" type="text"
                           <c:if test="${not empty user.id}">disabled</c:if>>
                </div>
                <label class="layui-form-label">用户名:</label>
                <div class="layui-input-inline">
                    <input id="username" name="userName" lay-verify="required" autocomplete="off"
                           value="${user.userName}" placeholder="用户名" class="layui-input" type="text"
                           onchange="checkName(this.value);">
                </div>
            </div>
        </div>
        <div class="layui-form-item" pane="">
            <div class="layui-inline">
                <label class="layui-form-label">性别：</label>
                <div class="layui-input-inline" style="width: 193px;">
                    <input name="sex" value="1" title="男"
                           <c:if test="${empty user.sex || user.sex == 1}">checked="checked"</c:if> type="radio">
                    <input name="sex" value="0" title="女"
                           <c:if test="${user.sex == 0}">checked="checked"</c:if> type="radio">
                </div>
                <label class="layui-form-label">身份证号:</label>
                <div class="layui-input-inline">
                    <input type="text" name="idCard" id="idCard" value="${user.idCard}" lay-verify="identity"
                           placeholder="身份证" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">手机号码:</label>
                <div class="layui-input-inline">
                    <input id="phone" name="phone" autocomplete="off" value="${user.phone}"
                    <c:if test="${not empty user.id}"> onkeyup="changePhone(this.value);" </c:if>
                           lay-verify="required|number|phone|checkPhone" placeholder="手机号码" <%--onchange="phone1(this.value);"--%>
                           class="layui-input" type="text">
                </div>
                <div class="layui-input-inline">
                    <input class="layui-btn code_btn" type="button" value="获取验证码"
                           <c:if test="${not empty user.id}">style="background: #c0c0c0;" disabled</c:if>>
                </div>
            </div>
        </div>
        <div class="layui-form-item code_div" <c:if test="${not empty user.id}">style="display: none;"</c:if>>
            <label class="layui-form-label">验证码</label>
            <div class="layui-input-inline">
                <input type="text" name="code" placeholder="请输入验证码" class="layui-input"
                       <c:if test="${empty user.id}">lay-verify="required|checkCode"</c:if>>
            </div>
        </div>
        <div class="layui-form-item" style="width: 504px;">
            <label class="layui-form-label">角色:</label>
            <div class="layui-input-block">
                <select name=role lay-verify="required" lay-search="">
                    <c:forEach items="${roles}" var="role" varStatus="status">
                        <option value="${role.id}"
                                <c:if test="${role.id == user.role}">selected="selected"</c:if>>${role.roleName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <%-- <div class="layui-form-item" style="width: 504px;">
            <label class="layui-form-label">邮箱:</label>
            <div class="layui-input-block">
                <input type="text" name="email" id="email" value="${user.email}" lay-verify="" placeholder="邮箱" autocomplete="off" class="layui-input"/>
            </div>
        </div> --%>
        <c:if test="${empty user.id}">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">密码:</label>
                    <div class="layui-input-inline">
                        <input type="password" name="userPassword" placeholder="密码不能少于6位数" class="layui-input"
                               lay-verify="required|length">
                    </div>
                    <label class="layui-form-label">确认密码:</label>
                    <div class="layui-input-inline">
                        <input type="password" name="newPassword" placeholder="密码不能少于6位数" class="layui-input"
                               lay-verify="required|length|equals">
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${not empty user.id}">
            <div class="layui-form-item" style="width: 504px;">
                <label class="layui-form-label">创建日期:</label>
                <div class="layui-input-block">
                    <input name="registerDate" autocomplete="off" class="layui-input" type="text" disabled
                           value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${user.registerDate}"/>'/>
                </div>
            </div>
        </c:if>
    </form>
</div>
<script type="text/javascript">
    //文档加载完毕执行

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

    /*function phone1(value) {

        if (value == '${user.phone}') {

        } else {
            var dataJson = {'phone': value};
            var result = check(dataJson, '${ctx}/register/checkLogin');
            if (!result) {
                layer.msg("手机号码已被注册")
                $("#phone").val(null);
            }
        }
    }*/

    function checkName(value) {

        if (value == '${user.userName}') {

        } else {
            var dataJson = {'userAccount': value};
            var result = check(dataJson, '${ctx}/user/userAccountUnique');
            if (!result) {
                layer.msg("该账户已被注册")
                $("#username").val(null);
            }
        }

    }


    $(function () {
        var message = '${message}';
        if (message != null && "" != message) {
            var msg = message.split("@");
            setTimeout(function () {
                layer.msg(msg[0], {icon: msg[1]});
            }, 100);
            setTimeout(function () {
                parent.location.reload(true);
            }, 1000);
        }
    });

    //提交表单
    function laySubmit() {
        $('#saveOrUpdate').submit();
    }

    //加载表单
    layui.use(['form', 'element', 'laydate'], function () {
        var form = layui.form;
        //监听提交
        form.on('submit(inputForm)', function (data) {
            //layer.msg(JSON.stringify(data.field));

            return true;
        });

        //自定义验证规则
        form.verify({
            //只能输入数字
            integer: function (value, item) {
                if (!/^[0-9]*$/.exec(value)) {
                    return "只能输入数字";
                }
            },
            userAccountUnique: function (value, item) {

                if (value != '' && value != null) {
                    var dataJson = {'id': $('#id').val(), 'userAccount': value};
                    var result = check(dataJson, '${ctx}/user/userAccountUnique');
                    if (!result) {
                        return "此账号已经存在！";
                    }
                }
            },
            checkPhone: function (value, item) {
                var dataJson = {'id': $('#id').val(), 'phone': value};
                var result = check(dataJson, '${ctx}/user/userAccountUnique');
                if (!result) {
                    return "手机号已被注册！";
                }
            },
            length: function (value, item) {
                if (value.length < 6) {
                    return "密码不能少于6位";
                }
            },
            equals: function (value, item) {
                if ($("[name='userPassword']").val() != value)
                    return "两次密码不一致！";
            }
        });
    });

    function check(dataJson, url) {
        var result = true;
        $.ajax({
            async: false,
            type: "post",
            url: url,
            dataType: "json",
            data: dataJson,
            success: function (data) {
                result = data;
            }
        });
        return result;
    }

    function changePhone(phone) {
        var checkPhone = $('#checkphone').val();
        if (phone != checkPhone) {
            if (phone != null && '' != phone && phone.trim().length == 11) {
                if ((/^1[3|4|5|7|8][0-9]\d{4,8}$/.test(phone))) {
                    checkPhoneExists(phone);
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

    var wait = 60;
    var interValObj;

    $('.code_btn').click(function () {
        var phone = $("#phone").val();
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
</script>
</body>
</html>