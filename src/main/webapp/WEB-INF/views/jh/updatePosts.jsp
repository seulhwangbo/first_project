<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        }

        .button-container input[type="button"]:hover,
        .button-container input[type="submit"]:hover {
            background-color: #023e8a;
        }

        input[name="postsTitle"] {
            width: 100%;
        }

        textarea[name="postsCnt"] {
            width: 100%;
            height: 250px;
        }

        .author-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .pinned-checkbox {
            margin-right: 5px;
        }
    </style>
    <script>
        function showUpdateAlert() {
            alert("수정되었습니다.");
        }

    </script>
</head>

<body>
    <h2>게시물 수정</h2>

    <form action="updatePosts1" method="post" onsubmit="showUpdateAlert();">
        <input type="hidden" name="postId" value="${posts.postId}">
        <input type="hidden" name="empno" value="${posts.empno}"> <!-- empno를 히든 필드로 추가 -->

        <table>
            <tr>
                <th>작성자</th>
                <td>
                    <div class="author-container">
                        ${emp.name}
                        <input type="hidden" name="empno" value="${emp.empno}"/>
                        <div>
                            <input type="checkbox" id="isPinned" name="isPinned" value="1" ${posts.isPinned == 1 ? 'checked' : ''} class="pinned-checkbox">
                            <label for="isPinned">상단 고정</label>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th>제목</th>
                <td><input type="text" name="postsTitle" value="${posts.postsTitle}" required="required"></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="postsCnt" required="required">${posts.postsCnt}</textarea></td>
            </tr>
            <tr>
                <th>파일첨부</th>
                <td>
				${posts.fileName}
				<input type="hidden" name="fileName" value="${fileName}">
				<input type="file" name="fileName" class="file-upload">
                </td>
            </tr>
            <tr>
                <th>조회수</th>
                <td>${posts.postsViews}</td>
            </tr>
        </table>

        <div class="button-container">
            <input type="submit" value="수정 완료">
            <input type="button" value="취소" onclick="history.back();">
        </div>
    </form>
</body>

</html>
