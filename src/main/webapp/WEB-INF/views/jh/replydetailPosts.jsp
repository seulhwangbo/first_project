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
            text-align: center; /* body의 텍스트를 중앙 정렬하여 테이블도 중앙에 배치됩니다. */
            margin: 0;
            padding: 0;
        }

        table {
            margin: 0 auto; /* 테이블을 수평으로 중앙에 배치합니다. */
            border-collapse: collapse; /* 테이블의 셀 경계선이 겹치지 않도록 설정합니다. */
            width: 48%; /* 테이블 너비를 설정합니다. */
        }

        th, td {
            padding: 10px; /* 셀 안쪽에 여백을 추가하여 내용이 셀의 경계와 떨어지도록 합니다. */
            border: 1px solid #ddd; /* 셀에 테두리를 추가합니다. */
            
        }
        td {
        	text-align: left;
        
        }
        

        th {
            background-color: #f2f2f2; /* 테이블 헤더의 배경색을 설정합니다. */
            text-align: center; /* 헤더의 텍스트를 중앙 정렬합니다. */
            width: 75px; /* 기본 너비 설정 (예시, 필요에 따라 조정) */
        }

        /* '내용' 열을 50% 너비로 설정합니다. */
        td:nth-child(3) {
            width: 500%; /* '내용' 열의 너비를 50%로 설정합니다. */
        }

        /* '내용' 행의 높이를 2배로 설정합니다. */
        tr:nth-child(3) {
            height: 8em; /* '내용' 행의 높이를 조정합니다. */
        }

        h2 {
            text-align: center; /* 제목(h2)을 중앙에 정렬합니다. */
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
		    transform: translateX(300px); /* 오른쪽으로 50px 이동 */
		}

        .button-container input[type="button"]:hover {
            background-color: #023e8a; /* 호버 시 배경색 변경 */
        }

        .file-upload {
            display: inline-block; /* 파일 첨부 버튼을 인라인 블록으로 설정합니다. */
  
        }
    </style>
</head>

<body>
    <h2>답글 확인</h2>

    <table>
        <tr>
            <th>작성자</th>
            <td>${posts.name}</td>
        </tr>
        <tr>
            <th>제목</th>
            <td>${posts.postsTitle}</td>
        </tr>
        <tr>
            <th>내용</th>
            <td>${posts.postsCnt}</td>
        </tr>

        <tr>
            <th>조회수</th>
            <td>${posts.postsViews}</td>
        </tr>
    </table>

    <div class="button-container">
	<c:if test="${emp.admin == 140 || emp.admin == 160 || emp.empno == posts.empno}">
	    <input type="button" value="수정" onclick="location.href='/jh/updatePostsFree?postId=${posts.postId}'">
	    <input type="button" value="삭제" onclick="location.href='/jh/deletePostsFree?postsId=${posts.postId}'">
	</c:if>
        <input type="button" value="답글작성" onclick="location.href='/jh/replyfree?postId=${posts.postId}'">
        <input type="button" value="목록" onclick="history.back();">
    </div>
</body>

</html>