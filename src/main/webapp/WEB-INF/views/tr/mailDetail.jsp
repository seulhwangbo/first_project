<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	제목: ${mail.mailTitle}
	<p>보낸사람: ${mail.sendAddress}
	<p>메일 본문: ${mail.mailCnt}
	<p><a href="/tr/mail?empno=${emp.empno}">뒤로가기</a>
</body>
</html>