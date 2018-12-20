<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
        <%  
String path = request.getContextPath();  //是为了解决相对路径的问题，可返回站点的根路径。
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
//request.getScheme()：返回当前链接使用的协议，比如http。request.getServerName()：获取你的网站的域名,
//如果是在本地的话就是localhost
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<base href="<%=basePath%>"> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="http://how2j.cn/study/css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<script src="http://how2j.cn/study/js/bootstrap/3.3.6/bootstrap.min.js"></script>
<script language="javascript" src="js/AjaxRequest.js"></script>	
<script language="javascript" src="js/checkFunction.js"></script>
<script language="javascript">
//验证注册时输入信息的有效性
var flag_user=true;		//记录用户是否合法
var flag_pwd=true;			//记录密码是否合法
var flag_repwd=true;		//确认密码是否通过
var flag_email=true;		//记录E-mail地址是否合法

//验证用户名是否合法，并且未被注册
function checkUser(str){
	if(str==""){			//当用户名为空时
		document.getElementById("div_user").innerHTML="请输入用户名！";//获得指定ID值的对象.设置提示文字(表示将 "请输入用户名！"
		//替换到id为的div_user的div标签中去，可实现在不刷新页面的情况下更改页面的部分内容.)
		document.getElementById("tr_user").style.display='';	//显示提示信息
		flag_user=false;
	}else if(!checkeUser(str)){	//判断用户名是否符合要求,checkFunction.js中的方法
		document.getElementById("div_user").innerHTML="您输入的用户名不合法！";	//设置提示文字
		document.getElementById("tr_user").style.display='block';		//显示提示信息
		flag_user=false;
	}else{		//进行异步操作，判断用户名是否被注册
		var loader=new net.AjaxRequest("UserServlet?action=checkUser&username="+str+"&nocache="
				+new Date().getTime(),deal,onerror,"GET");

	}	//发送请求到UserServlet.java,并调用其checkUser方法
}
function deal(){
	result=this.req.responseText;								//获取返回的检测结果
	result=result.replace(/\s/g,"");								//去除Unicode空白符
	if(result=="1"){											//当用户名没有被注册
		document.getElementById("div_user").innerHTML="";		//清空提示文字
		document.getElementById("tr_user").style.display='none';		//隐藏提示信息显示行
		flag_user=true;		
	}else{												//当用户名已经被注册
		document.getElementById("div_user").innerHTML=result;		//设置提示文字
		document.getElementById("tr_user").style.display='';		//显示提示信息
		flag_user=false;
	}	
}
/*************************************************************************************************************/
//验证密码
function checkPwd(str){
	if(str==""){		//当密码为空时
		document.getElementById("div_pwd").innerHTML="请输入密码！";	//设置提示文字
		document.getElementById("tr_pwd").style.display='';		//显示提示信息
		flag_pwd=false;
	}else if(!checkePwd(str)){		//当密码不合法时
		document.getElementById("div_pwd").innerHTML="您输入的密码不合法！";	//设置提示文字
		document.getElementById("tr_pwd").style.display='';	//显示提示信息
		flag_pwd=false;
	}else{		//当密码合法时
		document.getElementById("div_pwd").innerHTML="";	//清空提示文字
		document.getElementById("tr_pwd").style.display='none';		//隐藏提示信息显示行
		flag_pwd=true;
	}
}
//验证 '确认密码' 是否正确
function checkRepwd(str){
	if(str==""){		//当确认密码为空时
		document.getElementById("div_pwd").innerHTML="请确认密码！";	//设置提示文字
		document.getElementById("tr_pwd").style.display='';	//显示提示信息
		flag_repwd=false;
	}else if(form1.pwd.value!=str){		//当确认密码与输入的密码不一致时
		document.getElementById("div_pwd").innerHTML="两次输入的密码不一致！";	//设置提示文字
		document.getElementById("tr_pwd").style.display='';	//显示提示信息
		flag_repwd=false;
	}else{	//当两次输入的密码一致时
		document.getElementById("div_pwd").innerHTML="";	//清空提示文字
		document.getElementById("tr_pwd").style.display='none';		//隐藏提示信息显示行
		flag_repwd=true;
	}
}
//验证E-mail地址
function checkEmail(str){
	if(str==""){//当E-mail地址为空时
		document.getElementById("div_email").innerHTML="请输入E-mail地址！";//设置提示信息
		document.getElementById("tr_email").style.display='';		//显示提示信息
		flag_email=false;
	}else if(!checkemail(str)){//当E-mail地址不合法时
		document.getElementById("div_email").innerHTML="您输入的E-mail地址不正确！";//设置提示信息
		document.getElementById("tr_email").style.display='';		//显示提示信息
		flag_email=false;
	}else{
		document.getElementById("div_email").innerHTML="";//清空提示信息
		document.getElementById("tr_email").style.display='none';//不显示提示信息
		flag_email=true;	
	}
}
/************************************************************************************************************************************/
//保存用户注册信息，即点了提交按钮
 function save(){
		if(form1.user.value==""){		//当用户名为空时
			alert("save method test请输入用户名！");form1.user.focus();return;
		}
		if(form1.pwd.value==""){		//当密码为空时
			alert("save2请输入密码！");form1.pwd.focus();return;
		}
		if(form1.repwd.value==""){		//当没有输入确认密码时
			alert("save3请确认密码！");form1.repwd.focus();return;
		}
		if(form1.email.value==""){		//当E-mail地址为空时
			alert("save4请输入E-mail地址！");form1.email.focus();return;
		}
		if(flag_user && flag_pwd && flag_repwd && flag_email ){	//所有数据都符合要求时
			var param="username="+form1.user.value+"&pwd="+form1.pwd.value+"&email="+form1.email.value; 		//组合参数
			var loader=new net.AjaxRequest("UserServlet?action=save&nocache="+new Date().getTime(),deal_save,onerror,"POST",param);
			//将请求发送至UserServlet并调用其save方法
		}else{
			alert("您填写的注册信息不正确，请确认！");
		}
	}
	//处理UserServlet.java的save方法的返回值
	function deal_save(){
		document.getElementById("td_submit_button").style.display='none';
		document.getElementById("tr_submit_message").style.display='';
		document.getElementById("td_submit_message").innerHTML=this.req.responseText;
		if (this.req.responseText=="userdao用户注册成功！")	out(3);	
		//alert(this.req.responseText);		//弹出提示信息：注册成功与否-->改成直接在网页上提示
		//form_reset(form1);		//重置表单
		//document.getElementById("div_gologin").style.display="block";		//跳转到登录页面-->未跳转
		
	}
	function out(obj){//显示倒计时自动跳转
		var i=obj;
		if(i==0) document.location.href="login.jsp";
		document.getElementById("td_submit_message").innerHTML=i+"秒后自动跳转到登录页面";
		i--;
		setTimeout("out("+i+")",1000);/* setTimeout() 方法用于在指定的毫秒数后调用函数或计算表达式。 */
		}
/************************************************************************************************************************************/
	function form_reset(form){
		form.reset();		//重置表单
		getProvince();		//获取省和直辖市
		document.getElementById("tr_user").style.display='none';
		document.getElementById("tr_pwd").style.display='none';
		document.getElementById("tr_email").style.display='none';
		document.getElementById("tr_question").style.display='none';
		document.getElementById("tr_answer").style.display='none';
	}
	function onerror(){		//错误处理函数
		alert("onerror出错了");
	}
</script>
<title>用户注册</title>
<style type="text/css">
<!--
.STYLE1 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-weight: bold;
}
.STYLE2 {font-size: 24px}
-->
</style>
</head>

	<div id="register" style="width:1063; height:421; padding:4px; z-index:11;" align="center">
  <form name="form1" action="" method="post" >

			<table border="0" cellpadding="0" cellspacing="0" align="center">
			  <tr>
				<td height="50" style="font-size: 24px;"><b>用户注册</b></td>
			  </tr>
			</table>
			
			<table  height="231" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" align="center">								
				<tr>
				  <td width="93" height="30" align="right">用户名：</td>
				  <td height="30" align="left"><input name="user" type="text" onBlur="checkUser(this.value)" >
					&nbsp;*长度限制为20个字母或10个汉字</td>
				</tr>	
				<tr id="tr_user" style="display:none">	<!-- style="display:"不能用block,否则会出现colspan失效的问题，
				 在做tr显示与隐藏是，最好用none和“”来切换，不要用block-->
				  <td></td>			  
				  <td height="20" align="left"><div id="div_user" style="color:red" ></div>
					<!-- 用于显示提示信息 -->
				  </td>				  
				</tr>	
								

				<tr>
				  <td height="30" align="right">密码：</td>
				  <td height="30" align="left"><input name="pwd" type="password" onBlur="checkPwd(this.value)" >
					&nbsp;* 密码由字母、数字或下划线组成，长度大于6位小于30位</td>
				</tr>
				<tr id="tr_pwd" style="display:none"><!--若两次密码不一致，用于显示提示信息 -->
				  <td></td>
				  <td height="20" align="left"><div id="div_pwd" style="color:red"></div>
				  </td>
				</tr>	
				<tr>
				  <td height="30" align="right">确认密码：</td>
				  <td height="30" align="left"><input name="repwd" type="password"  onBlur="checkRepwd(this.value)">
					&nbsp;* 请确认密码 </td>
				</tr>
					
				
				<tr>
				  <td height="30" align="right">E-mail：</td>
				  <td height="30" align="left"><input name="email" type="text" size="35" onBlur="checkEmail(this.value)" >
					&nbsp;* 请输入有效的E-mail地址，在找回密码时应用 </td>
				</tr>
				<tr id="tr_email" style="display:none">
				  <td></td>
				  <td height="20" align="left"><div id="div_email" style="color:red"></div></td>
				</tr>
				
				<tr id="tr_question" style="display:none">
				  <td></td>
				  <td height="20" align="left"><div id="div_question" style="color:red"></div></td>
				</tr>
				
				<tr id="tr_submit_button">
				  <td height="40">&nbsp;</td>
				  <td id="td_submit_button" height="40" align="center">
				  	<input name="btn_sumbit" type="button" class="btn btn-primary" value="提交" onClick="save()">
					&nbsp;
					<input name="btn_reset" type="button" class="btn btn-primary" value="重置" onClick="form_reset(this.form)">
					&nbsp;
					</td>
				</tr>
				
				<tr id ="tr_submit_message" style="display:none">
					<td id="td_submit_message" colspan="2" align="center"></td>					
				</tr>
					
				<tr id="tr_gologin" >
				   <td colspan="2" height="40" align="right">
						<div id="div_gologin" style="display:">
							 <a href="login.jsp">登录</a>
						</div>
					</td>
				</tr>
			</table>
      <tr>
        <td height="10" align="center" valign="top" bgcolor="#FEFEFC">&nbsp;</td>
        <td></td>
      </tr>

	</form>
  </div>
</html>