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
            width: 100%;
        }

        textarea {
            width: 100%;
            height: 200px;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .button-container input[type="submit"], 
        .button-container input[type="button"] {
            margin-right: 20px;
            padding: 5px 8px;
            font-size: 1.2em;
            background-color: #034EA2;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .button-container input[type="submit"]:hover,
        .button-container input[type="button"]:hover {
            background-color: #023e8a;
        }

        .file-upload {
            display: inline-block;
        }
    </style>
    <script>
        function showAlert() {
            alert("게시물이 작성되었습니다.");
        }
    </script>
</head>

<body>
    <h2>글 작성</h2>

    <form action="writeFaqq" method="post" enctype="multipart/form-data" onsubmit="showAlert()">
        <table>
            <tr>
                <th>작성자</th>
                <td>
                    ${emp.name} 
                    <input type="hidden" name="empno" value="${emp.empno}"/>
                </td>
            </tr>
            <tr>
                <th>제목</th>
                <td><input type="text" name="postsTitle" required></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="postsCnt" rows="5" required></textarea></td>
            </tr>
            <tr>
                <th>파일첨부</th>
                <td><input type="file" name="fileName" class="file-upload"></td>
            </tr>
        </table>

        <div class="button-container">
            <input type="submit" value="작성하기">
            <input type="button" value="취소" onclick="history.back();"> 
        </div>
    </form>
</body>

</html>
