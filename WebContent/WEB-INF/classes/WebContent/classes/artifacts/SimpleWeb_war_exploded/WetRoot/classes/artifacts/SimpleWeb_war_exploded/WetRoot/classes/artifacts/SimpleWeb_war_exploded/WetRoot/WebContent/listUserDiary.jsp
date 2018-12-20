<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!-- ���ʻ���ǩ�� -->   
<jsp:useBean id="pagination" class="com.allan.tool.MyPagination" scope="session"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>�ҵ��ռ�</title>
</head>
<body>
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
		&nbsp;| &nbsp;<a href="index.jsp">��ҳ</a>
		&nbsp;| &nbsp;<a href="WriteDiary.jsp">д�ռ�</a>
		&nbsp;| &nbsp;<a href="UserServlet?action=exit">�˳���¼</a>
		</c:if>		
		<br><br>
	</div>
	</div>
<!------------------------------------ �����б� ---------------------------------------->
		<br><br>
<div id ="box">
	<c:if test="${!empty requestScope.diaryList}">
		<c:forEach items="${requestScope.diaryList}" var="diaryList" varStatus="id">
			<div style="border-bottom-color:#CBCBCB;padding:5px;border-bottom-style:dashed;
			border-bottom-width: 1px;margin: 10px 20px;color:#0F6548">
				<font color="#CE6A1F" style="font-weight: bold;font-size:14px;">${diaryList.username}</font>
					&nbsp;�������£�<b>${diaryList.title}</b>
				<div id="diary${id.count }" >
					${diaryList.content }
				</div>
				<div style="padding:10px;background-color:#FFFFFF;text-align:right;color:#999999;">
					����ʱ�䣺<fmt:formatDate value="${diaryList.writeTime}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/> 
					<c:if test="${sessionScope.userName==diaryList.username}">
						<a href="DiaryServlet?action=delDiary&id=${diaryList.id }&url=${requestScope.url}"
						onclick="return delConfirm();">[ɾ��]</a> 						
					</c:if>
				</div>
			</div>
		</c:forEach>
	</c:if>
</div>
<c:if test="${empty requestScope.diaryList}">
�������£�
</c:if>
<!-- ɾ��ȷ��-->
<script type="text/javascript">
function delConfirm(){
	var r=confirm("���½���ɾ�������ɻָ�!");
	if (r==true){
		//a href will executed.
		return true;
	}
	else{
	  	return false;//a href will not be executed.
	}
}

</script>
<!-- ��ʾ��ҳ���� -->
<div style="background-color: #FFFFFF;">
	 <%=pagination.printCtrl(Integer.parseInt(request.getAttribute("Page").toString()),"DiaryServlet?action="+request.getAttribute("url"),"")%> 
	 <!-- //����pagination��bean,��һ�������ǻ�ȡ��ǰҳ�� -->
	</div>
	<br>
</body>
</html>