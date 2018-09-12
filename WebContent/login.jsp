<%@ page language="java" contentType="text/html; charset=GB18030" pageEncoding="GB18030"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>    
<meta http-equiv="Content-Type" content="text/html; charset=GB18030"> 
<script src="http://how2j.cn/study/js/jquery/2.0.0/jquery.min.js"></script>
<link href="http://how2j.cn/study/css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<script src="http://how2j.cn/study/js/bootstrap/3.3.6/bootstrap.min.js"></script>
<script language="javascript" src="js/AjaxRequest.js"></script>	
<script language="javascript">
	function check(form) {
		if(form.username.value=="") {
			alert("请输入用户帐号!");
			form.username.focus();
			return false;
		}
		if(form.password.value==""){
			alert("请输入登录密码!");
			form.password.focus();
			return false;
		}
		document.form2.submit();
	}
</script>
<title>登录页面</title>
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
<body>  
    <form name="form2" method="post" action="UserServlet?action=login" >  
        <table width="240" height="276" align="center" cellspacing="5" >  
            <tr>  
              <td height="61" colspan="2">
           	  <p align="center" class="STYLE1"><span class="STYLE2">请登录</span></p>                	</td>  
            </tr>  
            <tr>  
                <td width="30" height="39" align="left" valign="middle" nowrap>帐号:</td>  
              <td width="179"><input name="username" type="text" id="username" size="35" placeholder="请输入用户名" /></td>  
            </tr>  
            <tr>  
                <td height="27" align="left" valign="middle" nowrap>密码:</td>  
                <td><input name="password" type="password" id="password" size="35"/></td>  
            </tr>
			<tr>
				<td height="39" colspan="3">
			  <div align="right"><a href="">找回密码</a> </div></td>
			</tr>  
            <tr>  
                <td height="49" colspan="2">
              <input type="button" class="btn btn-block btn-primary" value="登录" onClick="check(this.form)" color="red"/></td>
            </tr>
			<tr>
			  <td height="22" colspan=""><div align="center"><a href="register.jsp">注册</a></div></td><div align="left"></div>
			</tr>
      </table> 
    </form>  

    </div>
</body>  
</html>