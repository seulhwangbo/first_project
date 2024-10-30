<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        h2 {
            color: #034EA2;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #000;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #034EA2;
            color: white;
        }

        tr:hover {
            background-color: #d1e4ff;
        }

        a {
            color: #034EA2;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
.requestApp {
	margin: 50px 200px;
}
</style>
<title>결재 요청함</title>
</head>
<body>
<main>
	<h2>결재요청함</h2>
	<h3>전체 게시글: ${reqApp}</h3>
	<a href="/se/appReqFin"><button>결재 완료함</button></a>
	<table>
		<tr>
			<th>결재항목</th>
			<th>작성자</th>
			<th>문서명</th>
			<th>기안일</th>
			<th>결재상태</th>
			<th>결재일</th>
		</tr>
		<c:set var="lastApprovalNum" value="" />
			<c:forEach var="requestApp" items="${requestList}">
			<c:if test="${requestApp.approvalNum != lastApprovalNum}">
				<tr>
					<td>
						<c:choose>
							<c:when test="${requestApp.documentFormId == 100}">연차</c:when>
							<c:when test="${requestApp.documentFormId == 110}">병가</c:when>
							<c:when test="${requestApp.documentFormId == 120}">경조사</c:when>
							<c:when test="${requestApp.documentFormId == 130}">법인</c:when>
							<c:when test="${requestApp.documentFormId == 140}">비품</c:when>
							<c:when test="${requestApp.documentFormId == 150}">유류비</c:when>
							<c:when test="${requestApp.documentFormId == 160}">휴직</c:when>
							<c:when test="${requestApp.documentFormId == 170}">퇴직</c:when>
						</c:choose>
					</td>
					<td>${requestApp.appName}</td>
					<td>
						<a href="appDetail?approvalNum=${requestApp.approvalNum}&documentFormId=${requestApp.documentFormId}">${requestApp.approvalTitle}</a>
					</td>
					<td><fmt:formatDate value="${requestApp.approvalDate}" pattern="yy/MM/dd" /></td>
					<td>
						<c:choose>
							<c:when test="${requestApp.approvalCondition == 100}">결재요청</c:when>
							<c:when test="${requestApp.approvalCondition == 110}">결재진행</c:when>
							<c:when test="${requestApp.approvalCondition == 120}">결재완료</c:when>
							<c:when test="${requestApp.approvalCondition == 130}">결재반려</c:when>
						</c:choose>
					</td>
					<td>
						<fmt:formatDate value="${requestApp.approvalCompleteDate}" pattern="yy/MM/dd" />
					</td>
				</tr>
				<c:set var="lastApprovalNum" value="${requestApp.approvalNum}" />
				</c:if>
			</c:forEach>
	</table>
	
	<c:set var="num" value="${page.total-page.start+1 }"></c:set>
	
	<c:if test="${page.startPage > page.pageBlock}">
		<a href="appReq?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
	</c:if>
	<c:forEach var="i" begin="${page.startPage}" end="${page.endPage }">
		<a href="appReq?currentPage=${i}">[${i}]</a>
	</c:forEach>
	<c:if test="${page.endPage < page.totalPage}">
		<a href="appReq?currentPage=${page.startPage + page.pageBlock}">[다음]</a>
	</c:if>	
	
</main>
</body>
</html>