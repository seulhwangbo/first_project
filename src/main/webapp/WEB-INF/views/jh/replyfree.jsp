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

        h2 {
            text-align: center;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .button-container input[type="button"],
        .button-container input[type="submit"] {
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

        .button-container input[type="button"]:hover,
        .button-container input[type="submit"]:hover {
            background-color: #023e8a;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
        }

        textarea {
            height: 200px;
        }
    </style>
    <title>답글 작성</title>
</head>

<body>
    <h2>답글 작성</h2>

    <!-- 답글 작성 폼 -->
	<form action="replyfree1" method="get">
	


        <table>
            <tr>
                <th>작성자</th>
                <td>${emp.name}</td> <!-- 작성자 필드는 readonly -->
            </tr>
            <tr>
                <th>제목</th>
                <td><input type="text" name="title" value="${posts.postsTitle}" placeholder="제목을 입력하세요" required="required"></td> <!-- 제목은 이제 입력 가능 -->
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="content" placeholder="내용을 입력하세요" required="required"></textarea></td> <!-- 내용 입력 필드 -->
            </tr>

        </table>
        <input hidden="hidden" name="postId" value="${postId}">
        <input hidden="hidden" name="empno" value="${emp.empno}">

        <!-- 버튼 영역 -->
        <div class="button-container">
            <input type="submit" value="답변저장"> <!-- 답변 저장 버튼 -->
            <input type="button" value="목록" onclick="history.back();"> <!-- 목록 버튼 -->
        </div>
    </form>
</body>

</html>
