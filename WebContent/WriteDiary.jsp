<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>д�ռ�</title>
<script src="ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor_msg.js"></script>
<script type="text/javascript">

//�ж������Ƿ�Ϊ��
function test() {
    var editor_data = CKEDITOR.instances.editor1.getData();
    var title= myform.txtTitle.value;
    if(title==null|| title=="") { alert("����д���⣡");}
    if(editor_data==null || editor_data==""){  alert("����д���ݣ�");}
    else{
	//����ΪAjax	
	//alert("else executed.")
	    var param = "title="+ title+ "&content="+ encodeURIComponent(editor_data)+"&uid="+${sessionScope.uid}
	    + "&userName=" + "${sessionScope.userName}";//�ַ��������el�������ţ�������䲻ִ�С�
	    //alert("else executed after param.");
    	var URL="DiaryServlet?action=save&nocache="+new Date().getTime();
    		//document.myform.submit();//�ѱ�������ݴ���request
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
				//alert(xmlhttp.responseText);		//������ʾ��Ϣ
				document.getElementById("div_info").innerHTML=xmlhttp.responseText;
				setTimeout("window.location.href='DiaryServlet?action=listMyDiary'",1500);//��ת���ռ��б�
    		}else{
    			//alert("������2��");
    			document.getElementById("div_info").innerHTML="����ʧ�ܣ����Ժ����ԡ�";
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
		&nbsp;| &nbsp;<a href="DiaryServlet?action=listMyDiary">�ҵ��ռ�</a>
		&nbsp; | &nbsp;<a href="index.jsp">��ҳ</a>
		&nbsp; | &nbsp;<a href="UserServlet?action=exit">�˳���¼</a>
	</div>
</div>
<br><br>

<!----------------------------------------- �༭������ ------------------------------------------->

 		<form action="DiaryServlet.save" name="myform" method="post" id="myform"> 
 		���⣺<input type="text" id="txtTitle" name="txtTitle" size="130" height="150%"></input>
            <textarea name="editor1" id="editor1" rows="10" cols="80">
            </textarea>
            <script type="text/javascript">
            // Replace the <textarea id="editor1"> with a CKEditor
         // instance, using default configuration.
            CKEDITOR.replace( 'editor1');
            </script>
			<input type="button" onclick="test()" value="�ύ����"/>
        </form>
<!-- ��־�ύ��Ϣ��ʾ -->
<div id="div_info" style="text-align: center; color:red;"></div>        
</body>
</html>