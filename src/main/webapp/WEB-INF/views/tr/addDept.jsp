<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../1.main/admin_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>부서 추가</h2>
	<form action="insertDept">
		부서명: <input type="text" name="deptName">
		<p>
			부서장: <select name="empno">
				<c:forEach var="emp" items="${empList}">

					<option value="${emp.empno}"><c:choose>
							<c:when test="${emp.grade == 100}">${emp.empno} 사원</c:when>
							<c:when test="${emp.grade == 110}">${emp.empno} 주임</c:when>
							<c:when test="${emp.grade == 120}">${emp.empno} 대리</c:when>
							<c:when test="${emp.grade == 130}">${emp.empno} 과장</c:when>
							<c:when test="${emp.grade == 140}">${emp.empno} 차장</c:when>
							<c:when test="${emp.grade == 150}">${emp.empno} 부장</c:when>
							<c:when test="${emp.grade == 160}">${emp.empno} 사장</c:when>
						</c:choose> ${emp.name}
					</option>
				</c:forEach>
			</select>
		<p>
			상위부서: <select name="upperDept">
				<c:forEach var="dept" items="${deptList}">
					<option value="${dept.deptno}">${dept.deptName}</option>
				</c:forEach>
			</select>
		<p>
			부서전화번호: <input type="text" name="tel">
		<p>
			<input type="submit" value="추가">
	</form>

</body>
</html>