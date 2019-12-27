<%@page import="java.util.Enumeration"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

	<script type="text/javascript">
		/*  
			두번째 form태그에 저희는 업로드될 파일개수를 사용자에 의해서 동적으로 입력 받기 때문에
			두번째 form태그 내부에 for문을 이용하여 <input type="file">태그가 동적으로 만들어짐
			동적으로 만들어진 <input type="file">태그중에서 .. 업로드할 파일 경로를 지정하지 않은?
			<input>태그가 존재 한다면..
			x번째 파일 정보가 누락되었습니다. 라고~ 경고 메세지창을 띄워 줘야 합니다.
		*/
		function Check(f){
				//두번째 form태그에 접근하여 form태그 내부에 있는 모든 input태그의 개수 구하기
				//forms[] 배열 : <form>태그에 접근 하는 방법
				//elements : <form>태그 내부에 존재하는 모든 <input>태그들을 말함.
				//length : 개수 ,길이
				var cnt = f.elements.length;
				/*  
					위 cnt변수에 들어갈 <input>태그의 개수에 대한 설명!
					-> 두번째 <form>태그에 고정된 <input type="hidden">3개,
					                        <input type="button">1개 이므로..
					총 4개의 <input>이 고정으로 만들어져 있다.
				*/
				//누락된 파일 업로드 위치를 나타낼 변수 선언
				var filecnt = 1;
					
					//두번째 form태그 내부의 모든 <input>태그의 개수만큼 반복
					for(i=0;i<cnt;i++){
						
						//만약에 두번째 <form>태그 내부에 있는 <input>태그의 type속성값이 file이고				
						if(f.elements[i].type == "file"){
							
							//만약에 <input type="file">인 태그들 중에서..
							//업로드할 파일을 선택하지 않은 태그가 존재 한다면
							if(f.elements[i].value == ""){
								
								//x번째 <input type="file">내용이 바뀌었습니다! 라고 경고메세지
								var msg = filecnt + "번째 파일정보가 누락되었습니다.\n 올바른 선택을 해주세요"
								
								alert(msg);
								//파일 업로드시 선택하지 않은<input>태그에 포커스 주기
								f.elements[i].focus();
								//for반복문을 빠져 나감
								return;
							}//안쪽 if
							
							filecnt++; //<input type="file">일때만.. ++
							
						}//바깥 if
					}//for
					//두번째 form태그 다중파일업로드 요청 전송!
					f.submit();
						
			}		
		
		
	
	</script>


</head>
<body>
	<%--
		multi.jsp의 2번 폼태그에서 요청한 텍스트데이터 + 업로드할 파일정보는?
		request내장객체영역에 저장되어 유지 되고 있다.
		request내장객체 영역에 저장된 요청 값 얻기
	 --%>
	<%
		//한글처리
		request.setCharacterEncoding("UTF-8");
		
		//업로드될 실제 서버 경로 얻기 
		String realFolder = getServletContext().getRealPath("/upload");
		//out.println(realFolder);
	
		//업로드할수 있는 파일의 최대 크기 지정 10MB
		int max = 10 * 1024 * 1024;
		
		//실제 파일 업로드 담당 객체 생성 하여 다중 파일 업로드 처리
		MultipartRequest multipartRequest = 
		new MultipartRequest(request, 
							 realFolder, 
							 max, "UTF-8", new DefaultFileRenamePolicy() );
		//다중파일 업로드 후 ...
		//우리가 입력한 텍스트 값 얻기
		String name = multipartRequest.getParameter("name");
		String addr = multipartRequest.getParameter("addr");
		String note = multipartRequest.getParameter("note");
	
		//서버에 실제로 업로드된 파일의 "이름"을 저장할 컬렉션프레임워크에 속해 있는
		//ArrayList가변길이 객체 배열 생성
		ArrayList saveFiles = new ArrayList();
		
		//클라이언트가 서베에 실제로 업로드 하기전의 원본파일명을 저장할 용도의 ArrayList객체 생성
		ArrayList originFiles = new ArrayList();
		
		//multi.jsp페이지에서 ..파일업로드를 하기 위해 선택했던
		//<input type="file" name="upFilex"태그들중...
		//name속성값들을 모두 Enumeration인터페이스의 자식배열객체에 담아..
		//Enumeration인터페이스의 자식배열객체 자체르 반환 받는다.
		Enumeration e =  multipartRequest.getFileNames();
		
		while(e.hasMoreElements()){
			
			//<input type="file">인 태그의 name속성값을 하나씩 꺼내어 얻는다.
			Object obj = e.nextElement();
			String filename = (String)obj;
			
			//서버에 실제로 업로드된 파일의 이름을 하나씩 얻어 ArrayList가변길이 배열에 담기
			saveFiles.add(multipartRequest.getFilesystemName(filename));
			
			//클라이언트가 업로드한 파일의 원본이름을 하나씩 얻어 ArrayList가변길이 배열에 담기
			originFiles.add(multipartRequest.getOriginalFileName(filename));
			
		}
	%>
	
	<ul>
		<li>이름 : <%=name %></li>
		<li>주소 : <%=addr %></li>
		<li>하고싶은말 : <%=note %></li>
	</ul>
	<hr/>
	업로드된 파일리스트<br>
	<ul>
		<%
			for(int i=0; i<saveFiles.size(); i++){
		%>		
				<a href="#">
				<li><%=originFiles.get(i) %></li>
				</a>
				 
		<%		
			}
		%>
	
	</ul>
	
	
		
		


</body>
</html>






