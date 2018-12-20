<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript">
function out(obj){

var i=obj;
if(i==0) document.location.href="index.jsp";
document.body.innerHTML="登录成功！"+i+"秒后自动跳转...";//!-- 在body中要显示出来的内容 
i--;
setTimeout("out("+i+")",1000);/* setTimeout() 方法用于在指定的毫秒数后调用函数或计算表达式。 */
}
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>跳转页</title>
</head>
<body onload="out(3)">
		<a href="index.jsp">立即跳转</a>"
</body>
</html>