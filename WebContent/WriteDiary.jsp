<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>写日记</title>
<script src="ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor_msg.js"></script>
<script type="text/javascript">

//判断内容是否为空
function test() {
    var editor_data = CKEDITOR.instances.editor1.getData();
    var title= myform.txtTitle.value;
    if(title==null|| title=="") { alert("请填写标题！");}
    if(editor_data==null || editor_data==""){  alert("请填写内容！");}
    else{
	//以下为Ajax	
	//alert("else executed.")
	    var param = "title="+ title+ "&content="+ encodeURIComponent(editor_data)+"&uid="+${sessionScope.uid}
	    + "&userName=" + "${sessionScope.userName}";//字符串必须把el打上引号，否则语句不执行。
	    //alert("else executed after param.");
    	var URL="DiaryServlet?action=save&nocache="+new Date().getTime();
    		//document.myform.submit();//把表单里的内容传给request
		var xmlhttp;
		if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
  			xmlhttp=new XMLHttpRequest();
  		}
		else{// code for IE6, IE5
  			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  		}
		xmlhttp.onreadystatechange=function(){
			//alert("readystate"+xmlhttp.readyState)
  			if (xmlhttp.readyState==4 && xmlhttp.status==200){
	    		//document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
				//alert(xmlhttp.responseText);		//弹出提示信息
				document.getElementById("div_info").innerHTML=xmlhttp.responseText;
				setTimeout("window.location.href='DiaryServlet?action=listMyDiary'",1500);//跳转到日记列表
    		}else{
    			//alert("出错了2！");
    			document.getElementById("div_info").innerHTML="发表失败！请稍后重试。";
    		}
  		}
		xmlhttp.open("POST", URL, false);
		xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		//alert(param);
		xmlhttp.send(param);
    }
}
</script>
</head>
<body>
<div id="navigation">
	<div style="float:left;color:#006700;">
		<b> &nbsp; &nbsp;  ${sessionScope.userName}</b>
	</div>
	<div style="float:right;text-align: right;">	
		&nbsp;| &nbsp;<a href="DiaryServlet?action=listMyDiary">我的日记</a>
		&nbsp; | &nbsp;<a href="index.jsp">主页</a>
		&nbsp; | &nbsp;<a href="UserServlet?action=exit">退出登录</a>
	</div>
</div>
<br><br>

<!----------------------------------------- 编辑器部分 ------------------------------------------->

 		<form action="DiaryServlet.save" name="myform" method="post" id="myform"> 
 		标题：<input type="text" id="txtTitle" name="txtTitle" size="130" height="150%"></input>
            <textarea name="editor1" id="editor1" rows="10" cols="80">
            </textarea>
            <script type="text/javascript">
            // Replace the <textarea id="editor1"> with a CKEditor
         // instance, using default configuration.
            CKEDITOR.replace( 'editor1');
            </script>
			<input type="button" onclick="test()" value="提交数据"/>
        </form>
<!-- 日志提交信息提示 -->
<div id="div_info" style="text-align: center; color:red;"></div>        
</body>
</html>