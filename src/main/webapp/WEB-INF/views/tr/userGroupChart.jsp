<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
body {
	
}

table {
	border-collapse: collapse;
	background: linear-gradient(45deg, #49a09d, #5f2c82);
}

td {
	
}
</style>
<title>조직도조회</title>
</head>
<body>
	<main>
		<h2>조직도조회 페이지입니다</h2>
		<table border="1">
			<tr>
				<td style="border-right: none; width: 200px;">부서명</td>
				<td style="border-left: none;"></td>
			</tr>
			<c:forEach var="dept" items="${deptList}">
				<c:if test="${dept.higherdeptno == 0}">
					<tr>
						<td style="border-right: none;" >${dept.deptName}</td>
						<td style="border-left: none;"><a
							href="showDeptMemberUser?deptno=${dept.deptno}"><input
								type="button" value="구성원 보기"></a></td>
					</tr>
					<c:set var="deptno" value="${dept.deptno}"></c:set>
					<c:forEach var="dept" items="${deptList}">
						<c:if test="${dept.higherdeptno == deptno}">
							<tr>
								<td style="border-right: none;" >ㄴ${dept.deptName}</td>
								<td style="border-left: none;"><a
									href="showDeptMemberUser?deptno=${dept.deptno}"><input
										type="button" value="구성원 보기"></a></td>
							</tr>
							<c:set var="deptno1" value="${dept.deptno}"></c:set>
							<c:forEach var="dept" items="${deptList}">
								<c:if test="${dept.higherdeptno == deptno1}">
									<tr>
										<td style="border-right: none;">&nbsp;&nbsp;ㄴ${dept.deptName}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
										<td style="border-left: none;"><a
											href="showDeptMemberUser?deptno=${dept.deptno}"><input
												type="button" value="구성원 보기"></a></td>
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
					</c:forEach>
				</c:if>
			</c:forEach>
		</table>
	</main>
</body>
</html>