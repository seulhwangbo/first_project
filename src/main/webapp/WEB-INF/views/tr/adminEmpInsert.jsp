<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../1.main/admin_header.jsp"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 사원정보등록</title>
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
	<main>
		<h2>관리자 사원정보등록 페이지입니다</h2>
		${emp.empno}
		<form name="join" action="addEmp" method="post"
			enctype="multipart/form-data">
			사진: <input type="file" name="image">
			<p>
				이름: <input type="text" required="required" name="name">
			<p>
				이메일 : <input type="text" id="emailId" name="emailId" required>@
				<input type="text" id="emailDomain" name="emailDomain"
					placeholder="직접 입력"> <select id="emailDomainSelect"
					onchange="updateEmailDomain()">
					<option value="custom" selected>직접 입력</option>
					<option value="gmail.com">gmail.com</option>
					<option value="naver.com">naver.com</option>
					<option value="daum.net">daum.net</option>
				</select>
			<p>
				전화번호 :<input type="text" name="phone">
			<p>
				직급: <select name="grade">
					<option value=100>사원</option>
					<option value=110>주임</option>
					<option value=120>대리</option>
					<option value=130>과장</option>
					<option value=140>차장</option>
					<option value=150>부장</option>
					<option value=160>사장</option>
				</select>
			<p>
				직책: <select name="job">
					<option value="100">평사원</option>
					<option value="110">팀장</option>
					<option value="120">대표</option>
				</select>
			<p>
				은행: <input type="text" name="bank">
			<p>
				계좌: <input type="text" name="account">
			<p>
				주소: <input type="text" name="address">
			<p>
				입사일: <input type="date" name="hiredate">
			<p>
				부서 : <select name="deptno">
					<c:forEach var="dept" items="${deptList}">
						<option value="${dept.deptno}">${dept.deptName}</option>
					</c:forEach>
				</select>
			<p>
				<input value="${emp.empno}" name="recentEditor" hidden="hidden">
				<input type="submit" value="제출">
		</form>



	</main>
</body>
</html>