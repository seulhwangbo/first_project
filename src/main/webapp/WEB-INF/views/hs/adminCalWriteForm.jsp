<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../1.main/admin_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin_calWriteForm</title>
<style type="text/css">
	/* 메인 */
	main {
		margin: 0px 120px 0px 150px;
	}
	
	.entirewrite {
	}
	
	table {
		width: 100%;
		border-collapse: collapse;
	}
	th {
		text-align: center;
		padding: 8px;
		border: 1px solid #ddd;
	}
	td {
		text-align: left;
		padding: 8px;
		border: 1px solid #ddd;
	}
	.btn {
		cursor: pointer;
		padding: 5px 10px;
		margin: 2px;
		border: 1px solid #ddd;
		background-color: #f0f0f0;
		border-radius: 5px;
	}
	.btn.selected {
		background-color: #007bff;
		color: white;
		border-color: #007bff;
	}
        
	.btn-address-book {
		cursor: pointer;
		padding: 5px 10px;
		margin: 2px;
		border: 1px solid #ddd;
		background-color: #e0e0e0;
		border-radius: 5px;
	}
        
	.scheduleTypeCell {
		position: relative;
		padding-left: 25px; /* 동그라미 기호 여백 */
	}
	.scheduleTypeCell::before {
		content: '';
		position: absolute;
		left: 0;
		top: 50%;
		transform: translateY(-50%);
		width: 15px;
		height: 15px;
		border-radius: 50%;
		background-color: #f0f0f0; /* 기본 색상 */
	}
	.scheduleTypeCell.personal::before {
		background-color: #ffad60; /* 연한 주황색 */
	}
	.scheduleTypeCell.shared::before {
		background-color: #87ceeb; /* 하늘색 */
	}
	/* 버튼 위치 조정 */
    .form-actions {
        margin-top: 20px;
        text-align: right; /* 버튼을 왼쪽으로 정렬 */
    }
    
	/* 파일 첨부 스타일 */
    .file-attachment-container {
        margin-top: 20px;
        text-align: right;
    }
    .file-attachment-container input[type="file"] {
        display: none;
    }
    .file-attachment-container label {
        display: inline-block;
        padding: 10px 20px;
        background-color: #28a745;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    .file-attachment-container label:hover {
        background-color: #218838;
    }
    .file-attachment-container button {
        margin-left: 10px;
        padding: 10px 20px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    .file-attachment-container button:hover {
        background-color: #0056b3;
    }
    
    .emoti {
    	font-size: 25px;
    	color: #86E57F;		/* 회사일정색상 */
    }
    
    .button-sty {
        background-color: #8C8C8C;
        color: #ffffff;
        border: none; /* 테두리 없음 */
        padding: 5px 10px; /* 여백 */
        text-align: center; /* 중앙 정렬 */
        text-decoration: none; /* 밑줄 없음 */
        display: inline-block; /* 인라인 블록 */
        font-size: 16px; /* 글자 크기 */
        margin: 4px 2px; /* 여백 */
        cursor: pointer; /* 커서 모양 변경 */
        border-radius: 5px; /* 둥근 모서리 */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 기본 그림자 */
        transition: background-color 0.3s, box-shadow 0.3s; /* 배경색 변화 애니메이션 */
    }

    .button-sty:hover {
        background-color: #5D5D5D; /* 호버 시 약간 어두운 회색 */
        box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.2); /* 안쪽 그림자 */
    }
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
	
	function updateEndDate() {
        const startDateTimeInput = document.getElementById('eventStartdate');
        const endDateTimeInput = document.getElementById('eventEnddate');

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
<main>
	<form action="writeAdEvent" method="post" onsubmit="return validateDates()">
		<div class="entirewrite">
		<h2>일정쓰기</h2>
		<input type="hidden" name="eventDelete" value=100>
		<input type="hidden" name="eventWriter" value="${emp.empno }">
			<table>
				<tr>
					<th>제목</th>
					<td><input type="text" name="eventTitle" required="required"></td>
				</tr>
				<tr>
					<th>일시</th>
					<td><input type="datetime-local" name="eventStartdate" id="eventStartdate" required="required" onchange="updateEndDate()">
						<input type="datetime-local" name="eventEnddate" id="eventEnddate" required="required"></td>
				</tr>
				<tr>
					<th>분류</th>
					<td style="color: #62C15B"><input type="hidden" name="eventCategory" required="required" value="100">
						<span class="emoti">●</span> 회사일정
					</td>
				</tr>
				<tr>
					<th>장소</th>
					<td><input type="text" name="eventLoc"></td>
				</tr>
				<tr>
					<th>메모</th>
					<td><input type="text" name="eventMemo"></td>
				</tr>
			</table>
			<div class="form-actions">
				<button type="submit" class="btn-outline-primary btn-sm">등록</button>
			</div>
		</div>
	</form>
</main>
</body>
</html>