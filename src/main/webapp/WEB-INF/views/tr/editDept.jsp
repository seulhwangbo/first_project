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
	<h2>부서 수정</h2>
	<form action="updateDept" method="post">
		<input hidden="hidden" type="text" value="${dept.deptno}"
			name="deptno"> 부서명:<input type="text"
			value="${dept.deptName}" name="deptName">
		<p>
			부서장:<select name="manager">
				<c:forEach var="emp1" items="${empList}">
					<option value="${emp1.empno}"
						<c:if test="${dept.manager eq emp1.empno}"> selected="selected" </c:if>>
						<c:choose>
							<c:when test="${emp1.grade == 100}">${emp1.empno} 사원</c:when>
							<c:when test="${emp1.grade == 110}">${emp1.empno} 주임</c:when>
							<c:when test="${emp1.grade == 120}">${emp1.empno} 대리</c:when>
							<c:when test="${emp1.grade == 130}">${emp1.empno} 과장</c:when>
							<c:when test="${emp1.grade == 140}">${emp1.empno} 차장</c:when>
							<c:when test="${emp1.grade == 150}">${emp1.empno} 부장</c:when>
							<c:when test="${emp1.grade == 160}">${emp1.empno} 사장</c:when>
						</c:choose> ${emp1.name}
					</option>
				</c:forEach>
			</select>
		<p>
			부서대표번호:<input type="text" value="${dept.depttel}" name="deptTel">
		<p>

			<input type="submit" value="수정">
			<button type="button"  onclick="location.href='/tr/deleteDept?deptno=${dept.deptno}'">삭제</button>
	</form>


</body>
</html>