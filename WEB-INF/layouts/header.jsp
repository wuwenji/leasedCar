<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style>
    #reminds{
        position: absolute;
        top: 15px;
        right: 0;
    }
    .logout{
        padding: 0 0;
    }
    .layui-nav{
        height: 40px;
        padding-left: 10px;
        padding-right: 0;
    }
    .layui-nav .layui-nav-item{
        line-height: 40px;
        margin-left: 5px;
        margin-right: 5px;
    }
    .layui-nav .layui-nav-item:hover{
        /*background-color: #00F7DE;*/
    }
    .layui-nav .layui-nav-more{
        top: 20px;
    }
    .layui-nav .layui-nav-mored{
        top: 12px;
    }
    .layui-nav-child{
        top:40px;
    }
</style>
<header>
    <div class="container">
        <div class="logo" onclick="forward('${ctx}/index', 0);">
        </div>
        <div>
            <span style="position:absolute;top:35px;font-size: 24px;color: red;font-weight: 600;"><shiro:principal property="companyName"/></span>
        </div>
        <%--<div class="search">--%>
        	<%--扫一扫关注微信&nbsp;<img src="${ctx}/static/images/wx.jpg" title="扫一扫关注微信" style="width: 65px; height: 65px;">--%>
        <%--</div>--%>
    </div>
</header>
<div class="nav_t"></div>
<nav>
    <div class="container">
        <ul class="menu">
            <li id="首页" onclick="forward('${ctx}/index', 0);"><a href="javascript:;">首页</a></li>
            <%--<li id="租赁包车" class="chartered"><a href="javascript:forward('${ctx}/search/charter',0);">租赁包车</a></li>--%>
            <%--<li id="定制巴士"><a href="javascript:;">定制巴士</a> </li>--%>
            <%--<li id="客运班车"><a href="javascript:;">客运班车</a></li>--%>
            <%--<li id="周边游"><a href="javascript:;">周边游</a></li>--%>
            <li id="会员中心" onclick="forward('${ctx}/user/main', 1);"><a href="javascript:;">会员中心</a></li>
        </ul>
        <div class="logout" style="font-size: 13px;background-color: #393D49;">
            <shiro:guest>
                <%--<a class="loging" href="javascript:;">登录</a> | <a id="register" href="javascript:;">注册</a>--%>
                <ul class="layui-nav">
                    <li class="layui-nav-item">
                        <a class="loging" href="javascript:;">登录</a>
                    </li>
                    <li class="layui-nav-item">
                        <a id="register" href="javascript:;">注册</a>
                    </li>
                </ul>
            </shiro:guest>
            <shiro:user>
            <%--<div style="display: block;" class="logout1">--%>
				 <%--<i class="icon-user-circle-o">&nbsp;&nbsp;</i>--%>
                <%--<shiro:principal property="roleName"/>--%>
                <%--<div class="layui-inline user_account"">--%>
                    <%--<shiro:principal property="userAccount"/>--%>
                    <%--<i class="icon-sort-down"></i>--%>
                <%--</div>--%>
                <%--<span>--%>
					<%--<a id="logout" href="javascript:;">退出</a><br>--%>
					<%--<a href="${ctx}/remind/list"><span id="reminds">0</span><i class="icon-envelope icon-large"></i></a>--%>
                <%--</span>--%>


                     <ul class="layui-nav">
                         <c:if test="${user.type == 0}">
                             <li class="layui-nav-item">
                                 <a href=""><shiro:principal property="roleName"/></a>
                             </li>
                         </c:if>
                         <li class="layui-nav-item" lay-unselect="">
                             <a href="javascript:;" style="padding-left: 10px;">
                                 <%--<img src="//t.cn/RCzsdCq" class="layui-nav-img">--%>
                                 <shiro:principal property="userAccount"/>
                                 <span class="layui-nav-more"></span>
                             </a>
                             <dl class="layui-nav-child">
                                 <dd onclick="toGeRen()"><a href="${ctx}/charter/center/personal">个人信息</a></dd>
                                 <%--<dd><a href="javascript:;">切换账户</a></dd>--%>
                                 <dd><a id="logout" href="javascript:;">退出</a></dd>
                             </dl>
                         </li>
                         <li onclick="toGeRen()" class="layui-nav-item">
                             <a href="${ctx}/remind/list"><i class="icon-envelope icon-large"></i><span  id="reminds" class="layui-badge">0</span></a>
                         </li>
                     </ul>
            <%--</div>--%>
            </shiro:user>
        </div>
    </div>
</nav>
<script>
    //导航栏
    $(document).ready(function() {
        var top_menu = $("#top_menu").val();
        if(top_menu == '首页'){
            $("#"+top_menu).addClass('menu_action');
        }
        var position = $(".position").text();
        if(position.indexOf('租赁包车') > 0){
            $("#租赁包车").addClass('menu_action');
        }
        if(position.indexOf('中心') > 0){
            $("#会员中心").addClass('menu_action');
        }
        var shiroUser = '<shiro:principal/>';
        if(shiroUser != null && '' != shiroUser){
            setTimeout(function(){
                remind();
            }, 500);
        }
    });
    function toGeRen() {
        localStorage.setItem('newPage', '个人信息')
    }
    //url: 跳转路径  type: 0不需要登陆 1需要登陆
    function forward(url, type) {
        localStorage.setItem('newPage', '个人信息')
        var shiroUser = '<shiro:principal/>';
        if(type == 0){
            window.location.href = url;
            return false;
        }
        if(shiroUser != null && '' != shiroUser){
            window.location.href = url;
        }else{
            fun_loging('${ctx}/login');
        }
    }
    //登陆
    $('.loging').click(function () {
        fun_loging('${ctx}/login');
    });
    //退出
    $('#logout').click(function () {
        top.location.href = "${ctx}/login/out";
    });
    //注册
    $('#register').click(function () {
        top.location.href = "${ctx}/register";
    });
    //显示提醒消息条数
    function remind(){
        $.ajax({
            type: "POST",
            url: "${ctx}/remind/statistics",
            data: {},
            dataType: "json",
            success: function(data){
                $('#reminds').html(data);
                var remindAmount = $("#提醒通知").text();
                if(remindAmount != null && '' != remindAmount){
                    $('#'+remindAmount).append("<span class='layui-badge' style='margin-left:5px;'>"+data+"</span>");
                }
            }
        });
    }
</script>
