<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>calUpdate</title>
<style type="text/css">
	/* 메인 */
	main {
		margin: 0px 120px 0px 150px;
	}
/* 	
	/* 버튼 스타일 */
	.btn {
		padding: 4px 10px;
		border: none;
		border-radius: 5px;
		font-size: 16px;
		cursor: pointer;
		transition: all 0.3s ease;
		box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 기본 그림자 */
		font-size: 14px;
    }
    
	.upd {
		background-color: #4374D9; /* 하늘색 */
		color: white;
	}

	.upd:hover {
		background-color: #1F50B5; /* 호버 시 색상 변화 */
		box-shadow: inset 0 4px 6px rgba(0, 0, 0, 0.2); /* 눌리는 느낌 */
    }
     */
</style>

<script type="text/javascript">
	function validateDates() {
	    const startDate = document.getElementById('eventStartdate').value;
	    const endDate = document.getElementById('eventEnddate').value;
	
	    if (startDate && endDate) {
	        if (new Date(startDate) > new Date(endDate)) {
	            alert("종료일은 시작일 이후의 날짜여야 합니다.");
	            return false; // 폼 제출을 중단
	        }
	    }
	    return true; // 유효성 검사 통과
	}
</script>

</head>
<body>
<main>
<form action="updateEvent" method="post" onsubmit="return validateDates()">
	<div class="entire">
		<h2>일정 수정하기</h2>
		<input type="hidden" name="eventId" value="${calTotal.eventId }">
		<input type="hidden" name="eventCategory" value="${calTotal.eventCategory}">
		<input type="hidden" name="eventWriter" value="${calTotal.eventWriter }">
		<table>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="eventTitle" required="required" value="${calTotal.eventTitle }">
				</td>
			</tr>
			<tr>
				<th>일시</th>
				<td>
					<input type="datetime-local" name="eventStartdate" required="required" value="${calTotal.eventStartdate }"> - 
					<input type="datetime-local" name="eventEnddate" required="required" value="${calTotal.eventEnddate }">  
				</td>
			</tr>
			<tr>
				<th>분류</th>
				<td>
					${cateMap[calTotal.eventCategory]}
				</td>
			</tr>
			<tr>
				<th>장소</th>
				<td>
					<input type="text" name="eventLoc" value="${calTotal.eventLoc }">
				</td>
			</tr>
			<tr>
				<th>메모</th>
				<td>
					<input type="text" name="eventMemo" value="${calTotal.eventMemo }">
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: right;">
					<button type="submit" class="btn btn-outline-success btn-sm">수정</button>
				</td>
			</tr>
		</table>
	</div>
</form>
</main>
</body>
</html>