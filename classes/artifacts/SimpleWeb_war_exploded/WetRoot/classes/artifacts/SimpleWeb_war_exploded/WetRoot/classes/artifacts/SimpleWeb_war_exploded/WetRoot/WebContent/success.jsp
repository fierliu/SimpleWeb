<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript">
function out(obj){

var i=obj;
if(i==0) document.location.href="index.jsp";
document.body.innerHTML="��¼�ɹ���"+i+"����Զ���ת...";//!-- ��body��Ҫ��ʾ���������� 
i--;
setTimeout("out("+i+")",1000);/* setTimeout() ����������ָ���ĺ���������ú����������ʽ�� */
}
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>��תҳ</title>
</head>
<body onload="out(3)">
		<a href="index.jsp">������ת</a>"
</body>
</html>