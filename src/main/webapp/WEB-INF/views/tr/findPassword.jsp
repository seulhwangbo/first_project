<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
비밀번호 찾기 : 
 <p>
 <form action="findPasswordCheck">
 사번: <input type="number" name="empno" required="required">
비밀번호 질문: 
<select name="passQuiz">
<option value=1> 좋아하는 색깔은? </option>
<option value=2> 좋아하는 음식은?</option>
<option value=3> 좋아하는 취미는?</option>
<option value=4> 좋아하는 동물은?</option>
<option value=5> 을밀대의 현 주소는?</option>
</select>
<p>
비밀번호 답: <input type="text" name="passAnswer"><p>
<input type="submit" value="확인">
</form>
	

</body>
</html>