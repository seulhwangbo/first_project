<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp" %>
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
<title>결재</title>
</head>
<body>
<main>
    <h2>전체보관함</h2>
	<c:choose>
	    <c:when test="${searchCount > 0}">
	        <h3>검색된 결과 개수: ${searchCount}</h3>
	    </c:when>
		<c:otherwise>
	        <h3>전체 게시글: ${allApp}</h3>
	    </c:otherwise>
	</c:choose>
	<a href="/se/appStn"><button>결재대기함</button></a>
	<a href="/se/appFin"><button>결재완료함</button></a>
	<table>
		<tr>
			<th>결재항목</th><th>작성자</th><th>문서명</th><th>기안일</th><th>결재상태</th><th>승인일</th>
		</tr>
		<c:set var="lastApprovalNum" value="" />
		<c:forEach var="Approval" items="${allAppList}">
		    <c:if test="${Approval.approvalNum != lastApprovalNum}">
		        <tr>
		        	<td>
			            <c:choose>
								<c:when test="${Approval.documentFormId == 100}">연차</c:when>
								<c:when test="${Approval.documentFormId == 110}">병가</c:when>
								<c:when test="${Approval.documentFormId == 120}">경조사</c:when>
								<c:when test="${Approval.documentFormId == 130}">법인</c:when>
								<c:when test="${Approval.documentFormId == 140}">비품</c:when>
								<c:when test="${Approval.documentFormId == 150}">유류비</c:when>
								<c:when test="${Approval.documentFormId == 160}">휴직</c:when>
								<c:when test="${Approval.documentFormId == 170}">퇴직</c:when>
						</c:choose>
					</td>
		            <td>${Approval.name}</td>
		            <td><a href="appDetail?approvalNum=${Approval.approvalNum}&documentFormId=${Approval.documentFormId}">${Approval.approvalTitle}</a></td>
		            <td>
		            	<fmt:formatDate value="${Approval.approvalDate}" pattern="yy/MM/dd" />
		            </td>
		            <td class="${Approval.approvalCondition == 130 ? 'status-red' : 
		                         Approval.approvalCondition == 120 ? 'status-green' : 
		                         Approval.approvalCondition == 110 ? 'status-yellow' : 
		                         Approval.approvalCondition == 100 ? 'status-white' : ''}">
		                ${statusMap[Approval.approvalCondition]}
		            </td>
					    <td>
			            	<fmt:formatDate value="${Approval.approvalCompleteDate}" pattern="yy/MM/dd" />
			            </td>
		        </tr>
		        <c:set var="lastApprovalNum" value="${Approval.approvalNum}" />
		    </c:if>
		</c:forEach>
	</table>
	
	<c:set var="num" value="${page.total-page.start+1 }"></c:set>
	
	<c:if test="${page.startPage > page.pageBlock}">
		<a href="appAll?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
	</c:if>
	<c:forEach var="i" begin="${page.startPage}" end="${page.endPage }">
		<a href="appAll?currentPage=${i}">[${i}]</a>
	</c:forEach>
	<c:if test="${page.endPage < page.totalPage}">
		<a href="appAll?currentPage=${page.startPage + page.pageBlock}">[다음]</a>
	</c:if>	
	
	<p><a href="draftingForm">기안 작성</a><p>
	
	<form action="allAppListSearch">
		<select name="search">
			<option value="s_approvalTitle">제목</option>
			<option value="s_name">작성자</option>
		</select>
		<input type="text" name="keyword">
		<button type="submit">검색</button><p>
	</form>
</main>
</body>
</html>