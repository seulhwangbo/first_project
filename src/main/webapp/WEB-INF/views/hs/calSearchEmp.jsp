<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>calSearchEmp</title>
<style type="text/css">
	/* 메인 */
	.entire {
		display: flex;
		flex-direction: column;
		margin: 40px 120px 20px 150px;
	}
	
		/* 링크스타일 */
	a {
		color: black;	/* 글자 색상 설정 */
		text-decoration: none;	/* 밑줄제거 */
	}
	
	a:hover {
		font-weight: bold;
	}
	
	
	/* 1구역 */
	.writemyplan {
		display: flex;	/* 플렉스 박스를 사용하여 정렬 */
		flex-direction: row;	/* 가로 방향 정렬 */
		align-items: center;	/* 수직 중앙 정렬 */
	}
	
	.writemyplan img {
		width: 150px;
		height: auto;
	}
	
	.deleteList a {
		display: flex;	/* 플렉스 박스를 사용하여 정렬 */
		justify-content: center; /* 가로 가운데 정렬 */
		align-items: center; /* 세로 가운데 정렬 */
		margin-top: 20px;	/* 위쪽 간격 추가 */
		font-size: 18px;
		font-weight: bold;
		width: 300px;
	}
	
	.writemyplan .deleteList img {
		margin:0 10px 0 10px;	/* 그림과 글씨 사이 간격 조정 */
		width: 30px;
	}
	
	.writemyplan .deleteList a:hover {
		color: rgb(3, 78, 162);
		text-decoration: underline;
	}
	
	/* 1구역의 검색 */
	.container1 {
		display: flex; /* 플렉스 박스를 사용하여 정렬 */
		justify-content: space-between; /* 요소들 사이에 공간 분배 */
		width: 100%; /* 전체 너비 */
		margin-bottom: 20px; /* 아래쪽 여백 추가 */
	}
	
	/* 검색 부분 스타일 */
	.container1 .search {
		width: 100%;
		height: 30px;
		margin-bottom: 20px;
		text-align: right;
	}
	
	#searchForm {
		width: 500px;
	}
	
	
	/* 2구역 */
	.container2 {
		margin: 0px 0px 0px 10px;
		min-width: 800px;
		width: calc(100% - 270px);
		font-align: center;
		display: flex;
		flex-direction: column;
		padding-left: 20px;
	}
	
	/* 제목스타일 */
	.container2 .planTitle {
		width: 97%;
		min-width: 800px;
		max-width:900px;
		border: 1px solid;
		border-radius: 17px;
		padding: 15px;
		background-color: rgb(3, 78, 162);
		color: white;
		display: flex;	/* 플렉스 박스를 사용하여 정렬 */
		align-items: center; /* 세로 가운데 정렬 */
		justify-content: space-between; /* 양쪽 끝으로 정렬 */
		font-weight: bold;
		font-size: 20px;
		margin-bottom: 20px;
		margin-top: 20px;
	}
	
	.planTitle ul {
		display: flex; /* 플렉스 박스 사용 */
		justify-content: flex-end; /* 오른쪽 정렬 */
		list-style: none; /* 기본 목록 스타일 제거 */
		padding: 0; /* 패딩 제거 */
		margin: 0; /* 마진 제거 */
	}
	
		.fc-daygrid-day-events {
    	overflow: auto; /* 넘치는 부분 숨기기 */
	}
	
	/* 스크롤바 숨기기 */
	.fc-dayGrid-day-events::-webkit-scrollbar {
	    width: 0; /* 수직 스크롤바 숨기기 */
	    height: 0; /* 수평 스크롤바 숨기기 */
	}
	
	/* 내용이 넘칠 경우, 마우스 오버 시 스크롤바 표시 */
	.fc-dayGrid-day-events:hover::-webkit-scrollbar {
	    width: 8px; /* 수직 스크롤바 표시 */
	    height: 8px; /* 수평 스크롤바 표시 */
	}

	.fc-day-sun a {
		color: #F15F5F;
	}
	.fc-day-sat a {
		color: #4374D9;
	}
	
	#keyword + ul {
    /* 원하는 스타일 설정 */
    background-color: white !important; /* 배경색을 흰색으로 설정 */
    color: black !important; /* 글자색을 검은색으로 설정 */
	}
	
	.ui-autocomplete {
		padding: 10px !important;
		margin-left : 0px !important;
		max-height: 180px; /* 최대 높이 설정 */
    	overflow-y: auto; /* 스크롤이 필요할 경우 스크롤 표시 */
		
	}
</style>


<!-- 풀캘린더 -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
<link href='https://unpkg.com/@fullcalendar/core@6.1.15/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.15/index.global.min.js'></script>

<!-- jquery (자동완성기능) -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
    	initialView: 'dayGridMonth',
    	locale: 'ko',
    	selectable: true,
    	droppable: false,
    	editable: false,
    	googleCalendarApiKey : "AIzaSyCpqE_3VYLRWTFE66yjA1R6O_eN57yG_W0",
        eventSources :[
            {
            	events: [
            		<c:forEach items="${calShaList}" var="attendee">
	   	            	 {
	   	            		 title: '${attendee.eventTitle}',
	   	            		 start: '${attendee.eventStartdate}',
	   	            		 end: '${attendee.eventEnddate}',
	   	            		 color: '#5AFFFF'
	   	            	 }<c:if test="${!status.last}">,</c:if>
	               	 </c:forEach>
            		<c:forEach items="${calPriList}" var="attendee">
	   	            	 {
	   	            		 title: '${attendee.eventTitle}',
	   	            		 start: '${attendee.eventStartdate}',
	   	            		 end: '${attendee.eventEnddate}',
	   	            		 color: '#FFB85A'
	   	            	 }<c:if test="${!status.last}">,</c:if>
	               	 </c:forEach>
            	]
            },
            {						
                googleCalendarId : 'ko.south_korea.official#holiday@group.v.calendar.google.com'
                , color: 'transparent'   // an option!
                , textColor: 'red' // an option!
                , className: 'ko_event'
            }
        ],
        
        eventClick: function(info) {
            // 링크 클릭 방지
            info.jsEvent.preventDefault();
            // 추가적으로 처리할 로직이 있다면 여기에 작성
        }
    });

    
    try {
        calendar.render();
        console.log(calendar.getEvents());
        
        // 일정이 렌더링된 후에 각 행의 높이를 설정
        setTimeout(function() {
            document.querySelectorAll('.fc-daygrid-day-events').forEach(function(day) {
                day.style.height = '70px'; // 원하는 높이로 설정
            });
        }, 0); // 최소한의 지연 후 실행
       
    } catch (error) {
        console.error('Error rendering calendar:', error);
    }
  });
  
	function getGradeLabel(grade) {
	    switch (grade) {
	        case 100: return '사원';
	        case 110: return '주임';
	        case 120: return '대리';
	        case 130: return '과장';
	        case 140: return '차장';
	        case 150: return '부장';
	        case 160: return '사장';
	        default: return '';
	    }
	}
	
	function getJobLabel(job) {
	    switch (job) {
	        case 110: return '팀장';
	        case 120: return '대표';
	        default: return '';
	    }
	}
  
	// 검색 구현
	$(document).ready(function() {
		
		$('#keyword').autocomplete ({
			source: function(request, response) {
				var keyword = request.term;	//사용자가 입력한 검색어
				var deptno = $('#deptno').val();	//선택된 부서
				//source: 입력 시 보일 목록
				console.log("keyword>>>" + keyword);
				$.ajax({
					url: "<%=request.getContextPath()%>/hs/autocomplete",
					type: "POST",
					dataType: "JSON",
					data: {	keyword: keyword,
							deptno: deptno},
					success: function(data) {
						response(
							$.map(data.resultList, function(item) {
								var gradeLabel = getGradeLabel(item.grade); // 등급 레이블
								
								return {
									label: item.empno + " " + item.name + " " + gradeLabel,
									value: item.empno
								};
							})
						)
					},
					error: function() {
						alert("오류가 발생했습니다.");
					}
				});
			},
			focus: function(event, ui) {	//방향키로 자동완성 항목 선택 가능하게
				return false;	//기본동작 방지
			},
			minLength: 0,	//최소 글자 수
			autoFocus: true, 	//첫 번쨰 항목에 자동으로 초점 맞추기
			delay: 100,	//autocomplete 지연 시간 (ms)
			select: function(evt, ui) {

			 	// label에서 사번, 이름, 등급 추출
			    var parts = ui.item.label.split(" ");
			    
			    // 사번, 이름, 등급 변수 설정 (설정해주지 않으면 검색창에 undefined 나옴)
			    var empno = parts[0]; // 사번
			    var name = parts[1]; // 이름
			    var grade = parts[2]; // 등급
			    
			    
				//사용자가 선택할 때 사번을 숨겨진 필드에 저장한다
				$("#empno").val(empno);	//사번을 숨겨진 필드에 저장
				$("#keyword").val(empno + " " + name + " " + grade);	//사번을 숨겨진 필드에 저장
				
				$('.search1').css('padding', '10px !important'); // 원하는 padding 값으로 변경
				return false;	//기본 동작을 방지
			}
		}).focus(function() {
			$(this).autocomplete("search",$(this).val());
		});
		
		$('#searchForm').submit(function(event) {
			//empno만 전송하고 다른 값들은 무시하도록 설정
			$('#deptno').val('');
			$('#keyword').val('');
			
			// empno 값만 있는지 확인
	        if ($('#empno').val() === '') {
	            alert('사원을 선택해주세요.'); // empno가 비어있을 경우 경고
	            event.preventDefault(); // 폼 전송 중단
	        }
		});
	});
</script>
</head>
<body>
<body>
	<div class="entire">
		<div class="container1">
			<div class="writemyplan">
				<a href="/hs/calWriteForm">
					<img src="/hsimg/1out.png" alt="일정쓰기">
				</a>
				<a href="/hs/cal">
					<img src="/hsimg/0out.png" alt="내일정">
	    		</a>
	    		
	    		<table>
					<tr>
						<td class="deleteList">
							<div style="display: flex; align-items: center">
								<a href="/hs/calDelete">
									<img alt="trash" src="/hsimg/trashfile.png" width="30px"> 삭제된 일정 목록
								</a>
							</div>
						</td>
					</tr>
				</table>
				
				<div class="search"  style="display: flex; align-items: center;">
					<!-- 사원검색 -->
					<div class="search1" style="display: flex; justify-content: flex-start;">
						<form id="searchForm" action="calSearch" method="post">
							<span><im3.g alt="search" src="/hsimg/dot.png" style="width: 15px; margin-left: 20px; margin-right: 10px;">사원검색
								<select id="deptno">
									<option value="" selected="selected">전체</option>
									<c:forEach var="dept" items="${deptList }">
										<option value="${dept.deptno }">${dept.deptName }</option>
									</c:forEach>
								</select>
								<input type="text" id="keyword" placeholder="사원 이름을 입력하세요" autocomplete="on">
								<input type="hidden" id="empno" name="empno" value="">
								<input type="submit" value="검색">
							</span>
						</form>
					</div>
					
				</div>
			</div>
		</div>
			
		<div class="container2">
			<div class="planTitle">
				${empp.empno } ${empp.name } ${empgrade[empp.grade] }
			</div>
			<!-- 메인페이지 -->
			<div class="eventdetail">
				<div id='calendar'></div>
			</div>
		</div>
</body>
</html>