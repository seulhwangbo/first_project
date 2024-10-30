<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <style type="text/css">
        h2 {
            margin-top: 80px;
        }

        body {
            text-align: center;
            margin: 0;
            padding: 0;
        }

        table {
            margin: 0 auto;
            border-collapse: collapse;
            width: 60%;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ddd;
        }

        td {
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
            text-align: center;
            width: 75px;
        }

        td:nth-child(3) {
            width: 50%;
        }

        tr:nth-child(3) {
            height: 2.5em;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .button-container input[type="button"] {
            margin-right: 20px;
            margin-bottom: 100px;
            padding: 5px 8px;
            font-size: 1.2em;
            background-color: #034EA2;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            display: inline-block;
        }

        .button-container input[type="button"]:hover {
            background-color: #023e8a;
        }

        .file-upload {
            display: inline-block;
        }
    </style>
    <script>
        function showDeleteAlert() {
            alert("게시물이 삭제되었습니다.");
        }

        function confirmDelete(postId) {
            if (confirm('정말로 삭제하시겠습니까?')) {
                location.href = '/jh/deletePostsFaq?postsId=' + postId;
                showDeleteAlert();
            }
        }
    </script>
</head>

<body>
    <h2>게시물 확인</h2>

    <table>
        <tr><th>작성자</th><td>${posts.name} &nbsp;👤</td></tr>
        <tr><th>제목</th><td>${posts.postsTitle}</td></tr>
        <tr><th>내용</th><td>${posts.postsCnt}</td></tr>
        <tr>
            <th>파일첨부</th>
           <td>
	    <c:if test="${posts.fileName != null}">
	        <a href="/upload/jh${posts.fileName}" download="${posts.fileName}">${posts.fileName}</a>📄
	    </c:if>
	    <c:if test="${posts.fileName == null}">
	        파일 없음
	    </c:if>
	</td>
        </tr>
        <tr><th>조회수</th><td>${posts.postsViews}</td></tr>
    </table>

    <div class="button-container">
        <c:if test="${emp.admin == 150 || emp.admin == 170}">
            <input type="button" value="수정" onclick="location.href='/jh/updatePostsFaq?postId=${posts.postId}'">
            <input type="button" value="삭제" onclick="confirmDelete('${posts.postId}')">
        </c:if>
        <input type="button" value="목록" onclick="history.back();">
    </div>

</body>

</html>
