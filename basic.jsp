
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		//한글처리
		request.setCharacterEncoding("UTF-8");
	
		// MultipartRequest클래스 : 파일업로드를 직접 담당 하는 클래스 
		
		//현재 실행중인 웹프로젝트애 대한 정보들이 저장되어 있는 객체 얻기
		ServletContext ctx = getServletContext();
		
		//실제 파일이 업로드되는 경로 얻기
		String realPath = ctx.getRealPath("/upload");
	
		out.println(realPath);
		
		
		//업로드할 수 있는 파일의 최대사이즈 지정 10MB
		int max = 10 * 1024 * 1024;
		
		//실제 파일 업로드 
		//1.request :  form태그에서 요청한  데이터가 저장된 request를 전달
		//2.realPath : 업로드될 파일의 위치를 의미
		//3.max : 최대 크기 
		//4."UTF-8" : 업로드 되는 파일 이름이 한글일 경우 문제가 되므로 인코딩 방식 지정
		//5. new DefaultFileRenamePolicy() : 
		//업로드될 경로에 이미 업로드된 파일이름이 동일할경우
		//파일이름 중복을 방지를 위해 파일이름을 자동으로 변환 해주는 객체 전달         
		MultipartRequest multi 
		= new MultipartRequest(request,
							 	"D://upload",   
							 	max,
							 	"UTF-8",
							 	new DefaultFileRenamePolicy());
		
		//MultipartRequest객체의 getParameter()메소드를 호출해서
		//basic.html에서 입력한 텍스트 값을 얻어 온다.
		String  user = multi.getParameter("user");
		String title = multi.getParameter("title");
		
		out.println(user + "," + title);
		
		out.println("<hr/>");
	
		//basic.html페이지에서 파일업로드를 위해 선택한 
		//<input type="file" name="upFile1">
		//<input type="file" name="upFile2">
		//<input type="file" name="upFile3">
		//.. name속성값을들 모두 Enumeration인터페이스의 자식배열객체에 담아 ..
		//자식 배열 객체를 반환 해서 e변수에 저장
		Enumeration e = multi.getFileNames();
		
		//Enumeration인터페이스의 자식배열객체에 데이터가 존재 하는 동안 반복 
		while(e.hasMoreElements()){
			
			//<input type="file">태그의 name속성값을 차례로 얻어 온다. 
			String name = (String)e.nextElement();
			
			out.println("클라이언트가 업로드한 파일의 원본 이름 : "
						+ multi.getOriginalFileName(name) + "<br>");
			
			out.println("서버경로에 실제로 업로드된 파일의 이름 : "
						+ multi.getFilesystemName(name) + "<br>");
			
			
			//서버경로에 업로드된 파일에 접근 하기 위해..File객체 얻기
			File f = multi.getFile(name);
			
			out.println("업로드된 파일의 사이즈 : " + f.length()  + "byte<br>");
			
			//파일 삭제
			//f.delete();
			
		}
		
		
	%>
	
	



</body>
</html>





