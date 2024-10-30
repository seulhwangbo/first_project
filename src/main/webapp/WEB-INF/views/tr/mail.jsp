<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
</style>
<title>메일</title>
</head>
<body>
	<main>
		<h2>메일 페이지입니다</h2>
		<a href="sendMailForm">메일작성</a>
		<div>

			<a href="mail?empno=${emp.empno}">전체메일함</a> <a
				href="readMail?empno=${emp.empno}">읽은메일함</a> <a
				href="notReadMail?empno=${emp.empno}">안읽은메일함</a> <a
				href="importantMail?empno=${emp.empno}">중요메일함</a> <a
				href="sendMail?empno=${emp.empno}">보낸메일함</a> <a
				href="trashMail?empno=${emp.empno}">휴지통</a>


		</div>

		<table border="1">
			<thead>
				<tr>
					<th>제목</th>
					<th>보낸사람</th>
					<th>읽음여부</th>
					<th>보낸시간</th>
					<th>삭제</th>
					<th>중요메일</th>
				</tr>
			</thead>
			<tbody>
				<form action="deleteMail" method="post">
					<c:forEach var="mail" items="${mailList}">
						<tr>
							<td><a href="mailDetail?mailNo=${mail.mailNo}">${mail.mailTitle}</a></td>
							<td>${mail.sendAddress}</td>
							<td><c:choose>
									<c:when test="${mail.mailRead == 1}"><img src="/upload/openmail.png" width="20"></c:when>
									<c:when test="${mail.mailRead == 0}"><img src="/upload/unopenmail.png" width="20"></c:when>
								</c:choose></td>
							<td>${mail.sendDate}</td>
							<td><input type='checkbox' name='maildelete' value='${mail.mailNo}'/></td>
							<td><a href="/tr/importantMailCheck?empno=${emp.empno}&mailNo=${mail.mailNo}&mailBox=0"><c:choose>
									<c:when test="${mail.important == 1}"><img src="<%=request.getContextPath()%>/tr/important.png" width="20"></c:when>
									<c:when test="${mail.important == 0}"><img src="<%=request.getContextPath()%>/tr/unimportant.png" width="20"></c:when>
								</c:choose></a></td>
						</tr>
					</c:forEach>
					<input type="text" value="${emp.empno}" name="empno", hidden="hidden">
					<input type="submit" value="선택 삭제">
				</form>
			</tbody>
		</table>
	</main>
</body>
</html>