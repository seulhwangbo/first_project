<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../1.main/admin_header.jsp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>출근 및 퇴근 시간 수정</title>
<style type="text/css">
body {
    margin: 0;
    padding: 0;
    text-align: left;
    font-family: Arial, sans-serif;
    background-color: #f9f9f9; /* 배경 색상 */
}

h2 {
    color: #333; /* 제목 색상 */
    margin: 30px 0 30px 0;
    text-align: center;
}

form {
	margin: 20px auto; /* 상하 여백을 주고, 좌우는 자동으로 중앙 정렬 */
    max-width: 300px; /* 최대 너비를 설정 */
    background-color: #fff; /* 폼 배경 색상 */
    border-radius: 8px; /* 모서리 둥글게 */
    padding: 30px; /* 안쪽 여백 */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
}

.label-input {
    display: flex; /* 플렉스 박스 레이아웃 */
    align-items: center; /* 수직 중앙 정렬 */
    margin: 10px 0; /* 위아래 간격 */
}

label {
    margin-right: 10px; /* 레이블과 입력란 간격 */
    color: #555; /* 레이블 색상 */
}

input[type="text"] {
    padding: 8px; /* 입력란 크기 조정 */
    border: 1px solid #D5D5D5; /* 테두리 색상 */
    border-radius: 4px; /* 둥근 모서리 */
    width: 150px; /* 전체 너비 */
}

button {
    padding: 10px 15px; /* 버튼 크기 조정 */
    background-color: #D5D5D5; /* 배경색 */
    border: none; /* 테두리 없음 */
    color: black; /* 텍스트 색상 */
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s; /* 부드러운 전환 효과 */
    margin-top: 10px; /* 위쪽 간격 */
}

button:hover {
    background-color: #b0b0b0; /* 호버 시 색상 */
}

a {
    text-decoration: none; /* 링크 기본 스타일 제거 */
}

a button {
    background-color: transparent; /* 취소 버튼 배경색 없음 */
    color: #D5D5D5; /* 텍스트 색상 */
    border: 1px solid #D5D5D5; /* 테두리 색상 */
}

a button:hover {
    background-color: #D5D5D5; /* 호버 시 색상 */
    color: white; /* 텍스트 색상 변경 */
}

.updateAdminAtt {
	margin: 0 200px;
}
</style>
</head>
<body>
<div class="updateAdminAtt">
	<h2>출근 및 퇴근 시간 수정</h2>
	<form action="/he/updateAdminAtt" method="POST">
		<input type="hidden" name="empno" value="${updateAtt.empno}">
			근무일 : ${updateAtt.workDate} <input type="text" required="required" name="workDate" hidden="hidden" value="${updateAtt.workDate}"><p>
			사원명 : ${updateAtt.name} <input type="text" required="required" name="name" hidden="hidden" value="${updateAtt.name}"><p>
		<div class="label-input">
			<label for="clockIn">출근 시간 :</label>
			<input type="text" id="clockIn" name="clockIn" value="${updateAtt.clockIn}" required><p>
		</div>
		<div class="label-input">
			<label for="clockOut">퇴근 시간 :</label>
			<input type="text" id="clockOut" name="clockOut" value="${updateAtt.clockOut}" required><p>
		</div>
			수정자 : ${emp.name} <input type="text" required="required" name="name" hidden="hidden" value="${emp.empno}"><p>
			<button type="submit" onclick="updateClear()">수정 완료</button>
			<a href="/he/adminAtt"><button type="button">취소</button></a>
	</form>
	</div>
<script type="text/javascript">
</script>
</body>
</html>
