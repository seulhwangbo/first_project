<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>resWriteForm</title>
<style type="text/css">
	/* 메인 */
	.entire {
		display: flex;
		margin: 40px 120px 20px 150px;
	}
	
	/* 버튼 위치 조정 */
    .form-actions {
        margin-top: 20px;
        text-align: right; /* 버튼을 왼쪽으로 정렬 */
    }
    
    
    
	.ins {
		background-color: #8FFF86; /* 하늘색 */
		color: black;
	}

	.ins:hover {
		background-color: #59DA50; /* 호버 시 색상 변화 */
		box-shadow: inset 0 4px 6px rgba(0, 0, 0, 0.2); /* 눌리는 느낌 */
    }
</style>

<script type="text/javascript">
	function validateDates() {
	    const startDate = document.getElementById('resStart').value;
	    const endDate = document.getElementById('resEnd').value;
	
	    if (startDate && endDate) {
	        if (new Date(startDate) > new Date(endDate)) {
	            alert("종료일은 시작일 이후의 날짜여야 합니다.");
	            return false; // 폼 제출을 중단
	        }
	    }
	    return true; // 유효성 검사 통과
	}
	
	 function updateEndDate() {
	        const startDateTimeInput = document.getElementById('resStart');
	        const endDateTimeInput = document.getElementById('resEnd');

	        // 시작 날짜가 입력된 경우
	        if (startDateTimeInput.value) {
	            // 시작 날짜를 Date 객체로 변환
	            const startDateTime = new Date(startDateTimeInput.value);

	            // 종료 날짜를 한 시간 뒤로 설정
	            startDateTime.setHours(startDateTime.getHours() + 10);

	            // 종료 날짜를 YYYY-MM-DDTHH:mm으로 포맷
	            const endDateTime = startDateTime.toISOString().slice(0, 16);

	            // 종료 날짜 입력에 설정
	            endDateTimeInput.value = endDateTime;
	        } else {
	            // 시작 날짜가 비어있으면 종료 날짜도 비워줌
	            endDateTimeInput.value = '';
	        }
	    }
</script>
</head>
<body>
<div class="entire">
	<form action="writeReserv" method="post" onsubmit="return validateDates()">
		<div class="writeReservation">
			<h2>시설 예약</h2>
			<input type="hidden" name="resState" value="100">
			<input type="hidden" name="resWriter" value="${emp.empno }">
			<table>
				<tr>
					<th>시설명</th>
					<td>
						<select name="facilId">
							<c:forEach var="facility" items="${facilSort }">
								<option value="${facility.facilId }">${facility.facilType } ${facility.facilName }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>일시</th>
					<td>
						<input type="datetime-local" name="resStart" id="resStart" required="required" onchange="updateEndDate()">
						<input type="datetime-local" name="resEnd" id="resEnd" required="required">
					</td>
				</tr>
				<tr>
					<th>예약내용</th>
					<td><input type="text" name="resContent" required="required"></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><input type="tel" name="resTel"></td>
				</tr>
				<tr>
					<th>요청사안</th>
					<td><input type="text" name="resRequest"></td>
				</tr>
			</table>
			<div class="form-actions">
				<button type="submit" class="btn btn-outline-info btn-sm">신청</button>
			</div>
		</div>
	</form>
</div>
</body>
</html>