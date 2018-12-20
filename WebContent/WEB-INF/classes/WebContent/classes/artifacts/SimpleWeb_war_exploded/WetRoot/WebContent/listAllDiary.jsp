<%@ page language="java" contentType="text/html; charset=GB18030" pageEncoding="GB18030"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!-- ���ʻ���ǩ�� -->
<jsp:useBean id="pagination" class="com.allan.tool.MyPagination" scope="session"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">

<title>Simple</title>
</head>
<body onload="">

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
					����ʱ�䣺<fmt:formatDate value="${diaryList.writeTime}" type="both"  pattern="yyyy-MM-dd HH:mm:ss"/>  
					<c:if test="${sessionScope.userName==diaryList.username}">
						<!-- a href="DiaryServlet?action=delDiary&id=${diaryList.id }&url=${requestScope.url}">[ɾ��]</a> --> 
					</c:if>
				</div>
			</div>
		</c:forEach>
	</c:if>
</div>
<c:if test="${empty requestScope.diaryList}">
�������£�
</c:if>
<!-- ��ʾ��ҳ���� -->
<div style="background-color: #FFFFFF;">
	 <%=pagination.printCtrl(Integer.parseInt(request.getAttribute("Page").toString()),"DiaryServlet?action="+request.getAttribute("url"),"")%> 
	 <!-- //����pagination��bean,��һ�������ǻ�ȡ��ǰҳ�� -->
	</div>
	<br>
</body>
</html>