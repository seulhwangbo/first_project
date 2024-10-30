<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function updateEmailDomain() {
		const domainSelect = document.getElementById("emailDomainSelect");
		const domainInput = document.getElementById("emailDomain");

	
		if (domainSelect.value === "custom") {
			domainInput.value = "";
			domainInput.readOnly = false;
			domainInput.focus();
		} else {
			domainInput.value = domainSelect.value;
			domainInput.readOnly = true;
		}
	}
</script>
</head>
<body>
	<h2>개인정보수정</h2>
	<form action="updateOwnEmp" method="post">
		이름: ${emp.name}
		<p>
			사원번호: ${emp.empno} <input type="number" required="required"
				name="empno" hidden="hidden" value="${emp.empno}">
		<p>
			이메일 : <input type="text" id="emailId" name="emailId" required value="${emp.email1}">
			@	<input type="text" id="emailDomain" name="emailDomain"	placeholder="직접 입력" value="${emp.email2}">
			 <select id="emailDomainSelect" onchange="updateEmailDomain()">
					<option value="custom" selected>직접 입력</option>
					<option value="gmail.com">gmail.com</option>
					<option value="naver.com">naver.com</option>
					<option value="daum.net">daum.net</option>
				</select>
		<p>
			전화번호 :<input type="text" name="phone" value="${emp.phone}">
		<p>
			은행: <input type="text" name="bank" value="${emp.bank}">
		<p>
			계좌: <input type="text" name="account" value="${emp.account}">
		<p>
			주소: <input type="text" name="address" value="${emp.address}">
		<p>
			<input value="${emp.empno}" name="recentEditor" hidden="hidden">
		<p>
			<input type="submit" value="수정">
	</form>



</body>
</html>