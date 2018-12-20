<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="GB18030"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!-- ���ʻ���ǩ�� -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="./js/jquery.min.js"></script>
<!--//��ȡ�����������-->
  <script type="text/javascript">  
		function hitCount(){
			//alert("hitCount executed.")
			$.ajax({  
	      		url:"PageServlet",//servlet�ļ�������
	      		type:"post",
	      		data:{action:"get"},
	      		success:function(message, Status){
      				$("div#hitCount").text(message);
      				//alert(message);
	      		}
	      	});			
		}
  </script>

	<script type="text/javascript">
		function toWriteDiary(){
			window.location.href="WriteDiary.jsp";
		}
	</script>
	
 	<style>
 	div.count{
		float:right 
	}
	</style>
<title>SimpleBlog</title>
</head>
<body onload="hitCount()">
<div id="navigation">
	<div style="float:left;color:#006700;">
		<c:if test="${!empty sessionScope.userName}">	<!-- ��Session�ķ�Χ�У�ȡ��userName -->	
			<b> &nbsp; &nbsp;  ${sessionScope.userName}, ��ӭ������</b>
		</c:if>
		<c:if test="${empty sessionScope.userName}">		
			<b> &nbsp; &nbsp; �οͣ���ӭ��</b>
		</c:if>
	</div>
	<div style="float:right;text-align: right;">
		<c:if test="${empty sessionScope.userName}">	
		&nbsp; | &nbsp;<a href="login.jsp">��¼</a>
		&nbsp; | &nbsp;<a href="register.jsp">ע��</a>
		&nbsp; | &nbsp;<a href="forgetPwd_1.jsp">�һ�����</a>	 
		</c:if>
		<c:if test="${!empty sessionScope.userName}">		
		&nbsp;| &nbsp;<a href="DiaryServlet?action=listMyDiary">�ҵ��ռ�</a>
		&nbsp;| &nbsp;<a href="WriteDiary.jsp">д�ռ�</a><!-- javascript:;" onclick="toWriteDiary() -->
		&nbsp;| &nbsp;<a href="UserServlet?action=exit">�˳���¼</a>
		</c:if>		
	</div>
</div>
<!--------------------------------------- iframe ---------------------------------->
	<iframe id="iframe1" frameborder="0" width="1080" height="1" onload="setHeight()" scrolling="no" 
	src="DiaryServlet?action=listDiary" src="PageServlet?action=get" allowTransparency="true" style="background-color:transparent;">	
	</iframe>
	<script type="text/javascript">    
    function getIframeWindow(obj) {  
        return obj.contentWindow || obj.contentDocument.parentWindow;  
    }  
    function getIframeHeight(obj){  
        var idoc = getIframeWindow(obj).document;   
        if(idoc.body){  
            return Math.max(idoc.body.scrollHeight,idoc.body.offsetHeight);     
        }else if(idoc.documentElement){  
            return Math.max(idoc.documentElement.scrollHeight,idoc.documentElement.offsetHeight);     
        }  
    }  
    function setHeight(){     
        var myiframe = document.getElementById("iframe1");  
        myiframe.height = getIframeHeight(myiframe);  
    }   
    </script>
     
    <div >    	
    	<div class="count" id = "hitCount" style="color:Blue"></div>
    	<div class="count" style="color:Blue">��������</div>
 	</div>
	

</body>
</html>