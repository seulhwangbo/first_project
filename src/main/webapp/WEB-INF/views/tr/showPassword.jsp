<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
비밀번호 보여주기
${LoginInfo.password}
<c:if test="${empty LoginInfo.password}">
   <p> 땡!<p>
   <input type="button" onclick="location.href='/tr/findPassword'" value="진짜 한번만 더 시도 해보기">
</c:if>
<p><input type="button" onclick="location.href='/'" value="로그인 화면">
</body>
</html>