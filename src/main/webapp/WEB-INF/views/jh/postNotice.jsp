<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
    /* 기존 스타일 유지 */
    table {
        margin: 0 auto; /* 테이블을 가운데로 정렬 */
        border-collapse: collapse; /* 테두리 겹침 제거 */
        width: 70%; /* 테이블 전체 너비 설정 */
    }

    th, td {
        border: 1px solid black; /* 테두리 설정 */
        padding: 10px; /* 셀 내부 여백 */
        text-align: center; /* 텍스트 가운데 정렬 */
        color: black; /* 텍스트 색상 설정 */
    }

    th:nth-child(2), td:nth-child(2) {
        width: 50%; /* '내용' 열을 50% 너비로 설정 */
    }

    th:nth-child(1), td:nth-child(1){
        width: 5%; /* 'no'와 '작성자' 열의 너비를 10%로 설정 */
    }
     th:nth-child(3),td:nth-child(3) {
      width: 10%; 
    }

    /* 검색창 스타일 */
    #search-container {
        text-align: center; /* 검색창 가운데 정렬 */
        margin-bottom: 10px; /* 검색창과 테이블 사이 간격 */
    }

    input[type="text"] {
        padding: 5px;
        width: 200px;
    }

    /* 버튼 스타일 */
    button {
        margin-top: 100px; /* 전체 페이지를 100px 아래로 이동 */
        padding: 5px 10px;
        background-color: #034EA2;
        color: white;
        border: none;
        cursor: pointer;
    }

    button:hover {
        background-color: #0056b3; /* 호버 시 배경색 변경 */
    }

    /* 버튼 컨테이너 스타일 */
    .button-container {
        position: relative;
 
        margin-bottom: 20px;
        text-align: right;
    }

    .button-container input[type="button"] {
        margin-right: 300px; /* 오른쪽으로 220px 이동 */
        padding: 6px 12px; /* 버튼 크기 조정 (패딩을 통해) */
        font-size: 1.2em; /* 글자 크기 조정 */
        background-color: #034EA2; /* 배경색 설정 */
        color: white; /* 글자 색상 설정 */
        border: none; /* 기본 테두리 제거 */
        border-radius: 5px; /* 버튼 모서리 둥글게 */
        cursor: pointer; /* 마우스 커서 모양 변경 */
    }

    .button-container input[type="button"]:hover {
        background-color: #023e8a; /* 호버 시 배경색 변경 */
    }

    a {
        text-align: center;
    }
    /* 페이지 네비게이션 스타일 */
    .pagination {
        text-align: center; /* 페이지 네비게이션 가운데 정렬 */
        margin: 20px 0; /* 상하 여백 추가 */
    }

    .pagination a {
        text-decoration: none; /* 링크 밑줄 제거 */
        color: #007bff; /* 링크 색상 설정 */
        padding: 0 10px; /* 링크 좌우 여백 추가 */
    }

    .pagination a:hover {
        text-decoration: underline; /* 호버 시 밑줄 추가 */
    }
</style>
<title>공지사항</title>
</head>
<body>
<main>

	<form action="listSearch3" style="text-align: center;">
	    <h2 style="margin-top: 50px; margin-bottom: 1px; padding-right: 800px;">공지게시판</h2>
	    <select name="search">
	        <option value="title">제목</option>
	        <option value="content">내용</option>
	    </select>
	    <input type="text" name="keyword" placeholder="입력하세요">
	    <button type="submit">검색</button><p>
	</form>
	
	    <c:set var="num" value="${page.total - page.start + 1}"></c:set>
	    <table border="1">
	        <tr>
	            <th style="color: blue; font-size: 18px;">no</th>
	            <th style="color: blue; font-size: 18px;">제목</th>
	            <th style="color: blue; font-size: 18px;">작성일</th>
	        </tr>
	        
	        <!-- 게시물 출력 -->
	        <c:if test="${empty listPosts}">
	            <tr>
	                <td colspan="3">게시물이 없습니다.</td>
	            </tr>
	        </c:if>
	
<c:forEach var="posts" items="${listPosts}" varStatus="status">

    <c:if test="${posts.isPinned == 1}">
        <tr style="background-color: ;">
            <td>
                <img src="/jh/notice.png"  style="width: 20px; height: auto;"> <!-- 이미지 삽입 -->
            </td>
            <td style="text-align: left;">
                <a href="detailPosts/${posts.postId}">${posts.postsTitle}</a>
            </td>
            <td>${posts.creationDate}</td>
        </tr>
        <c:set var="num" value="${num - 1}"></c:set>
    </c:if>
</c:forEach>
	
	<c:forEach var="posts" items="${listPosts}" varStatus="status">
	    <c:if test="${posts.isPinned == 0 or posts.isPinned == null}">
	        <tr>
	            <td>${num}</td>
	            <td style="text-align: left;">
	                <a href="/jh/detailPosts/${posts.postId}">${posts.postsTitle}</a>
	            </td>
	            <td>${posts.creationDate}</td>
	        </tr>
	        <c:set var="num" value="${num - 1}"></c:set>
	    </c:if>
	</c:forEach>
	        
	    </table>
	
	    <div class="pagination">
	        <c:if test="${page.startPage > page.pageBlock}">
	            <a href="postNotice?currentPage=${page.startPage - page.pageBlock}">[이전]</a>
	        </c:if>
	        <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
	            <a href="postNotice?currentPage=${i}">[${i}]</a>
	        </c:forEach>
	        <c:if test="${page.endPage < page.totalPage}">
	            <a href="postNotice?currentPage=${page.startPage + page.pageBlock}">[다음]</a>
	        </c:if>
	    </div>
	
	    <div class="button-container">
	    <c:if test="${emp.admin == 150 || emp.admin == 170}">
	      
	    <input type="button" value="글작성" onclick="location.href='writeNotice';">
	   </c:if>
	    </div>
	</main>
</body>
</html>
