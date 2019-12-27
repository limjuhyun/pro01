<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<script type="text/javascript">
		function addInput(){
			//추가할 파일수 값 얻기
			var filecnt = document.f.add.value;
			
			//div 태그 영역 선택해서 가져오기
			var div = document.getElementById("inputDiv");
			
			//입력한 수만큼 반복 하여 <input type="file">태그를 동적으로 생성하여
			//div태그영역에 추가 하여 나타냄
			for(i=0; i<filecnt; i++){
				var msg = "<input type='file' name='upfile"+i+"'/><br>";
				//div영역 앙에 위의 <input type='file'>태그를 누적
				div.innerHTML += msg;
				
			}
		}
	
	</script>


</head>
<body>
	<form action="multi_pro.jsp" enctype="multipart/form=data" method="post" name="f">
	
		이름 : <input type="text" name="name" /><br>
		주소 : <input type="text" name="addr" /><br>
		하고싶은말 : <br>
		 <textarea rows="3" cols="70" name="note"></textarea> <br>
		 업로드할 파일 수 입력 : <input type="text" name="add" size="2">
		 
		 <input type="button" value="입력한 input추가" onclick="addInput();"> <br>
		 <div id="inputDiv"></div>
	
		 <input type="button" value="업로드요청" onclick="Check(this.form)">
	</form>

</body>
</html>
