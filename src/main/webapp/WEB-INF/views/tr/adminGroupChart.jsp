<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../1.main/admin_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
table {
	border-collapse: collapse;
	border: none;
}
</style>
<title>관리자 조직관리</title>
</head>
<body>
	<main>
		<h2>관리자 조직관리 페이지입니다</h2>
		<button onclick="location.href='/tr/addDept'">부서추가</button>
		<table border="1" frame=void;>
			<tr>
				<td
					style="border-right: none; width: 200px; background-color: gray;">부서명</td>
				<td style="border-left: none; background-color: gray;"></td>
			</tr>
			<c:forEach var="dept" items="${deptList}">
				<c:if test="${dept.higherdeptno == 0}">
					<tr>
						<td style="border: none;">${dept.deptName}</td>
						<td style="border: none;"><a
							href="showDeptMember?deptno=${dept.deptno}"><input
								type="button" value="구성원 보기"></a></td>
						<td style="border: none;"><a
							href="editDept?deptno=${dept.deptno}"><input type="button"
								value="부서 편집"></a></td>
					</tr>
					<c:set var="deptno" value="${dept.deptno}"></c:set>
					<c:forEach var="dept" items="${deptList}">
						<c:if test="${dept.higherdeptno == deptno}">
							<tr>
								<td style="border: none;">ㄴ${dept.deptName}</td>
								<td style="border: none;"><a
									href="showDeptMember?deptno=${dept.deptno}"><input
										type="button" value="구성원 보기"></a></td>
								<td style="border: none;"><a
									href="editDept?deptno=${dept.deptno}"><input type="button"
										value="부서 편집"></a></td>
							</tr>
							<c:set var="deptno1" value="${dept.deptno}"></c:set>
							<c:forEach var="dept" items="${deptList}">
								<c:if test="${dept.higherdeptno == deptno1}">
									<tr>
										<td style="border: none;">&nbsp;&nbsp;ㄴ${dept.deptName}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
										<td style="border: none;"><a
											href="showDeptMember?deptno=${dept.deptno}"><input
												type="button" value="구성원 보기"></a></td>
										<td style="border: none;"><a
											href="editDept?deptno=${dept.deptno}"><input
												type="button" value="부서 편집"></a></td>
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