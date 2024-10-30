<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../1.main/user_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	@media print {
	 	@page {
            size: A4; /* 페이지 크기 설정 (A4) */
            margin: 0; /* 여백 제거 */
        }
        
	    body * {
	        display: none; /* 모든 요소 숨김 */
	        transform: scale(0.9);
	        height: auto;
	    }
	    #printableArea, #printableArea * {
	        display: block; /* 인쇄할 영역 보이기 */
	    }
	}
</style>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<!-- 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	
	let selectedApprovers = [];
	let selectedReferrers = [];
	let modalType = 'approver'; // 기본값: 결재자
	
	// 모달 열기
	function openApproverModal() {
		
		$('#myForm').off('submit');
		
	    $.ajax({
	        url: '<%=request.getContextPath()%>/se/empDeptApp',
	        method: 'GET',
	        dataType: 'json',
	        contentType: 'application/json',
	        success: function(data) {
	        	
	           populateEmpList(data);
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
	            console.error('직원 데이터 가져오기 오류:', textStatus, errorThrown);
	        }
	    });
	}
	
	// 모달 닫기 함수
	function closeModal() {
	    // 모달 닫기
	    $('#addressModal').modal('hide');
		
	    // 유효성 검사 다시 활성화
	    $('#myForm').on('submit', function(event) {
	        // 유효성 검사 로직
	        if (!validateForm()) {
	            event.preventDefault(); // 폼 제출 방지
	        }
	    });
	}
	
	// 입력 필드 유효성 검사 함수
	function validateForm() {
	    // 예: 필수 입력 필드 검사
	    const isValid = $('#usagePeriod').val() && $('#furloughStartDate').val() && $('#furloughEndDate').val();
	    if (!isValid) {
	        alert('모든 필드를 입력해주세요.');
	    }
	    return isValid;
	}
	
	// 직원 목록 채우기
	function populateEmpList(empList) {
	    const empListContainer = $('.accordion');
	    empListContainer.empty(); // 이전 결과 초기화
	
	    if (empList.length === 0) {
	        empListContainer.append('<div>직원이 없습니다.</div>');
	        return;
	    }
	
	    const deptList = empList.reduce((acc, employee) => {
	        const deptName = employee.deptName;
	        if (deptName) {
	            if (!acc[deptName]) {
	                acc[deptName] = [];
	            }
	            acc[deptName].push(employee);
	        } else {
	            console.error('부서명이 없습니다:', employee);
	        }
	        return acc;
	    }, {});
	
	    Object.keys(deptList).forEach(deptName => {
	        let departmentItem = `
	            <div class="accordion-item">
	                <h2 class="accordion-header">
	                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse` + deptName + `" aria-expanded="false" aria-controls="collapse` + deptName + `">
	                        ` + deptName + `
	                    </button>
	                </h2>
	                <div id="collapse` + deptName + `" class="accordion-collapse collapse" data-bs-parent="#accordionFlushExample">
	                    <div class="accordion-body">
	        `;
	
	        const sortedEmployees = deptList[deptName].sort((a, b) => b.grade - a.grade);
	        
	        sortedEmployees.forEach(employee => {
	            let gradeLabel = getGradeLabel(employee.grade);
	            let jobLabel = getJobLabel(employee.job);
	            if (gradeLabel || jobLabel) {
	                departmentItem += `
	                	<div style="cursor: pointer;">
	                    <button type="button" class="btn btn-link" onclick="addToList('` + employee.name + `', '` + employee.empno + `', '` + gradeLabel + `', '` + jobLabel + `')" style="text-decoration: none;">
	                        <strong>` + employee.empno + `</strong> ` + employee.name + ` ` + gradeLabel + ` ` + jobLabel + `
	                    </button>
	                </div>
	                `;
	            }
	        });
	
	        departmentItem += `
	                    </div>
	                </div>
	            </div>
	        `;
	
	        empListContainer.append(departmentItem);
	    });
	}
	
	// 직급과 직무 라벨 변환
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
	
	let approverIdCounter = 110; // 결재자 ID 시작값
	let referrerIdCounter = 900;  // 참조자 ID 시작값
	
	// 직원 추가 함수
	function addToList(name, empno, gradeLabel, jobLabel) {
	const newEntry = { name, empno, grade: gradeLabel, job: jobLabel };
	
	if (modalType === 'approver') {
	    if (!selectedApprovers.some(item => item.empno === newEntry.empno)) {
	        if (selectedApprovers.length < 3) {
	            selectedApprovers.push(newEntry);
	            updateSelectedList('#selectedApprovers', selectedApprovers);
	            updateHiddenApproversInput();
	        } else {
	            console.warn('결재자는 최대 3명까지 선택할 수 있습니다.');
	        }
	    } else {
	        console.warn(name + '는 이미 선택되었습니다.');
	    }
	
	} else {
	    if (!selectedReferrers.some(item => item.empno === empno) && !selectedApprovers.some(item => item.empno === empno)) {
	        selectedReferrers.push(newEntry);
	        updateSelectedList('#selectedReferrers', selectedReferrers);
	        updateHiddenReferrersInput();
	    } else {
	        console.warn(name + '는 이미 선택되었습니다.');
	    }
	}
	}
	
	function updateSelectedApproval() {
	    const approverNames = selectedApprovers.map(approver => 
	        approver.name + ' ' + approver.grade
	    ).join(' ');
	    $('#selectedApproval').text(approverNames); // 결재자 이름 업데이트
	    $('#approvalList').text(approverNames);
	}
	
	// 선택 목록 업데이트
	function updateSelectedList(selector, list) {
	    const container = $(selector);
	    container.empty();
	
	    const title = selector === '#selectedApprovers' ? '결재자 목록' : '참조자 목록';
	    container.append('<h5>' + title + '</h5>');
	    
	    list.forEach(item => {
	        container.append(`
	            <div>
	                ` + item.empno + ` ` + item.name + ` ` + item.grade + ` ` + item.job + `
	                <button type="button" class="btn btn-danger btn-sm" onclick="removeFromList('` + item.empno + `', '` + (selector === '#selectedApprovers' ? 'approver' : 'referrer') + `')">제거</button>
	            </div>
	        `);
	    });
	}
	
	// 목록에서 제거
	function removeFromList(empno, type) {
	    if (type === 'approver') {
	        selectedApprovers = selectedApprovers.filter(item => item.empno !== empno);
	        updateSelectedList('#selectedApprovers', selectedApprovers);
	        updateHiddenApproversInput();
	    } else {
	        selectedReferrers = selectedReferrers.filter(item => item.empno !== empno);
	        updateSelectedList('#selectedReferrers', selectedReferrers);
	        updateHiddenReferrersInput();
	    }
	}
	
	// 결재자 목록 업데이트 함수
	function updateHiddenApproversInput() {
		const approversData = selectedApprovers.map(approver => approver.empno);
	    $('#selectedApproversInput').val(approversData.join(',')); // 배열을 문자열로 변환하여 설정
	}

	// 참조자 목록 업데이트 함수
	function updateHiddenReferrersInput() {
	    const referrersData = selectedReferrers.map(referrer => referrer.empno);
	    $('#selectedReferrersInput').val(referrersData.join(',')); // 배열을 문자열로 변환하여 설정
	}
	
	// 모달 유형 설정
	function setModalType(type) {
	    modalType = type;
	    openApproverModal(); // 모달 열기
	}
	
	function addApprovers() {
	    const approverNames = selectedApprovers.map(approver => 
	        approver.name + ' ' + approver.grade
	    ).join(' ');
	    $('#selectedApproval').text(approverNames); // 결재자 업데이트
	    $('#approvalList').text(approverNames);
	}
	
	function addReferrers() {
	    const referrerNames = selectedReferrers.map(referrer => 
	        referrer.name + ' ' + referrer.grade
	    ).join(', ');
	    $('#selectedReference').text(referrerNames); // 참조자 업데이트
	    $('#referrerList').text(referrerNames);
	}
	
	// 추가 버튼 클릭 시
	function addSelectedMembers() {
	    addApprovers();
	    addReferrers();
	
	    // approversData와 referrersData를 생성
	    const approversData = selectedApprovers.map((approver, index) => ({
	        approverOrder: 110 + index * 10,
	        empno: approver.empno
	    }));
	
	    const referrersData = selectedReferrers.map((referrer, index) => ({
	        approverOrder: 900 + index,
	        empno: referrer.empno
	    }));
	
	 	// 기존에 선언된 변수가 있다면 재사용
	    const updatedApproversData = selectedApprovers.map((approver) => ({
	        empno: approver.empno
	    }));
	
	    // hidden input에 값 설정
	    $('#approversInput').val(JSON.stringify(updatedApproversData));
	    
	    // 모달 닫기
	    closeModal(); // Ensure this function correctly hides the modal
	
	}
	
	let currentRow = 1; // 현재 보이는 행의 인덱스
	
	function addRow() {
	    const maxRows = 5; // 최대 보이는 행 수
	    if (currentRow < maxRows) {
	        const nextRow = document.getElementById(`row${currentRow + 1}`);
	        nextRow.style.display = ''; // 행을 보이도록 설정
	        currentRow++; // 현재 행 인덱스 증가
	    }
	}
	
	function calculateTotal() {
	    let total = 0;
	    const rows = document.querySelectorAll('#tableBody tr');
	    rows.forEach(row => {
	        const amountInput = row.querySelector('input[type="number"]');
	        if (amountInput) {
	            total += Number(amountInput.value) || 0;
	        }
	    });
	    document.getElementById('costTotal').value = total;
	}
	
    function addFileNames(divId, files) {
        const fileNamesDiv = document.getElementById(divId);
        fileNamesDiv.innerHTML = ""; // 기존 파일 이름 지우기

        for (const file of files) {
            const fileNameElement = document.createElement('div');
            fileNameElement.textContent = file.name;
            fileNamesDiv.appendChild(fileNameElement);
        }
    }

    function goBack() {
        window.history.go(-2);
    }
    
    function resetForm() {
        document.getElementById("expForm").reset();
        
        document.getElementById('usagePeriod').innerText = "";
        document.getElementById('usageDays').innerText = "";
        document.getElementById('fileNames').innerHTML = "";
        document.getElementById('attachedFileNames').innerHTML = "";

        const tableBody = document.getElementById('tableBody');

        // 기존 행 모두 삭제
        while (tableBody.firstChild) {
        tableBody.removeChild(tableBody.firstChild);
    }

        // 초기 행 추가
        addRow(); // 기본 행을 다시 추가

        document.getElementById('totalAmount').value = ""; // 합계 초기화
    }

    function calculateTotal() {
        const rows = document.querySelectorAll('#tableBody tr');
        let total = 0;

        rows.forEach(row => {
            const amount = row.querySelector('input[type="number"]').value;
            if (amount && !isNaN(amount)) { // 금액이 숫자인 경우만 더함
                total += parseFloat(amount);
            }
        });

        document.getElementById('totalAmount').value = total;
    }
 	// 삭제
    function deleteApproval(documentFormId, approvalNum) {
        if (confirm("정말 삭제하시겠습니까?")) {
            const formData = new FormData();
            formData.append('documentFormId', documentFormId);
            formData.append('approvalNum', approvalNum);

            fetch('/se/deleteApp', { // 수정된 URL
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (response.ok) {
                    alert("삭제가 완료되었습니다.");
                    window.location.href = "/se/appAll";
                } else {
                    alert("삭제에 실패했습니다.");
                }
            })
            .catch(error => {
                console.error("Error:", error);
                alert("서버 오류가 발생했습니다.");
            });
        }
    }
</script>
<title>${approvalDto.documentFormTitle} 수정</title>
</head>
<body>
<main id="printableArea">
    <form action="updateApp" id="expForm" method="post">
    	<input type="hidden" name="documentFormId"  value="${documentFormId}">
        <input type="hidden" name="empno"           value="${emp.empno}">
        <input type="hidden" id="selectedApproversInput" name="selectedApprovers" value="">
		<input type="hidden" id="selectedReferrersInput" name="selectedReferrers" value="">
        <table>
            <tr>
                <td>결재:
                	<span id="approvalList">
                    <c:forEach var="appLine" items="${appLineList}" varStatus="status">
                        <c:if test="${appLine.approverOrder <= 130}">
                            ${appLine.name} 
                            <c:choose>
                                <c:when test="${appLine.grade == 100}">사원</c:when>
                                <c:when test="${appLine.grade == 110}">주임</c:when>
                                <c:when test="${appLine.grade == 120}">대리</c:when>
                                <c:when test="${appLine.grade == 130}">과장</c:when>
                                <c:when test="${appLine.grade == 140}">차장</c:when>
                                <c:when test="${appLine.grade == 150}">부장</c:when>
                                <c:when test="${appLine.grade == 160}">사장</c:when>
                                <c:otherwise>( ${appLine.grade} )</c:otherwise>
                            </c:choose>
                            <c:if test="${!status.last}"> </c:if>
                        </c:if>
                    </c:forEach>
                    </span>
                    <span id="selectedApproval" style="display:none;"></span> <!-- 기본적으로 숨김 -->
			        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addressModal" onclick="setModalType('approver')">결재자</button>
                </td>
            </tr>
            <tr>
                <td>참조:
                	<span id="referrerList">
	                    <c:forEach var="appLine" items="${appLineList}" varStatus="status">
	                        <c:if test="${appLine.approverOrder >= 900}">
	                            ${appLine.name} 
	                            <c:choose>
	                                <c:when test="${appLine.grade == 100}">사원</c:when>
	                                <c:when test="${appLine.grade == 110}">주임</c:when>
	                                <c:when test="${appLine.grade == 120}">대리</c:when>
	                                <c:when test="${appLine.grade == 130}">과장</c:when>
	                                <c:when test="${appLine.grade == 140}">차장</c:when>
	                                <c:when test="${appLine.grade == 150}">부장</c:when>
	                                <c:when test="${appLine.grade == 160}">사장</c:when>
	                                <c:otherwise>( ${appLine.grade} )</c:otherwise>
	                            </c:choose>
	                            <c:if test="${!status.last}"> </c:if>
	                        </c:if>
	                    </c:forEach>
                    </span>
                    <span id="selectedReference"style="display:none;"></span>
                    <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#addressModal" onclick="setModalType('referrer')">참조자</button>
                </td>
            </tr>
            <tr>
                <td>제목:<input type="text" name="approvalTitle" value="${approvalDto.approvalTitle}" required></td>
            </tr>
        </table>

        <h2>${approval.documentFormTitle} 승인 기안</h2>
		
		<c:forEach var="appLine" items="${appLineList}" varStatus="status">
		    <c:if test="${appLine.approverOrder <= 130}">
		        ${appLine.name} 
		        <c:choose>
		            <c:when test="${appLine.grade == 100}">사원</c:when>
		            <c:when test="${appLine.grade == 110}">주임</c:when>
		            <c:when test="${appLine.grade == 120}">대리</c:when>
		            <c:when test="${appLine.grade == 130}">과장</c:when>
		            <c:when test="${appLine.grade == 140}">차장</c:when>
		            <c:when test="${appLine.grade == 150}">부장</c:when>
		            <c:when test="${appLine.grade == 160}">사장</c:when>
		            <c:otherwise>( ${appLine.grade} )</c:otherwise>
		        </c:choose>
		        <c:if test="${!status.last}"> </c:if>
		    </c:if>
		</c:forEach>
		<br />
		<c:forEach var="appLine" items="${appLineList}" varStatus="status">
		    <c:if test="${appLine.approverOrder <= 130}">
		        <div style="display: inline-block; margin-right: 10px;">
		            <c:choose>
		                <c:when test="${appLine.approvalType == 120 || appLine.approvalType == 140}">
		                    <img src="/se/Yes.png" alt="Final Yes" style="width: 80px; height: 80px;"/> 
		                </c:when>
		                <c:when test="${appLine.approvalType == 130}">
		                    <img src="/se/None.png" alt="None" style="width: 80px; height: 80px;"/> 
		                </c:when>
		                <c:when test="${appLine.approvalType == 110}">
		                    <img src="/se/FinalYes.png" alt="Yes" style="width: 80px; height: 80px;"/> 
		                </c:when>
		                <c:otherwise>
		                    <!-- 다른 경우에 대한 처리 (필요 시) -->
		                </c:otherwise>
		            </c:choose>
		        </div>
		        <c:if test="${!status.last}"> | </c:if>
		    </c:if>
		</c:forEach>
		<div style="margin-top: 10px;">
		    <c:forEach var="appLine" items="${appLineList}" varStatus="status">
		        <c:if test="${appLine.approverOrder <= 130}">
		            <span style="margin-right: 10px;">${appLine.approvalCompleteDate}</span>
		            <c:if test="${!status.last}"> | </c:if>
		        </c:if>
		    </c:forEach>
		</div>
		
        <table class="appEmp">
			<tr>
                <td>문서번호:</td>
                <td><span id="approvalNum">${approvalDto.approvalNum}</span></td> <!-- Integer approvalNum -->
            </tr>
			<tr>    
                <td>기안일자</td>
                <td id="approvalDate"><%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %></td>
            </tr>
			<tr>	
				<td>기안자</td>
				<td><span id="name">${approvalDto.name}</span><br></td>
			</tr>
			<tr>	
				<td>기안자부서</td>
				<td><span id="deptName">${approvalDto.deptName}</span><br></td>
			</tr>
			<tr>	
				<td>기안자직급</td>
				<td>
					<c:choose>
                        <c:when test="${approvalDto.grade == 100}">사원</c:when>
                        <c:when test="${approvalDto.grade == 110}">주임</c:when>
                        <c:when test="${approvalDto.grade == 120}">대리</c:when>
                        <c:when test="${approvalDto.grade == 130}">과장</c:when>
                        <c:when test="${approvalDto.grade == 140}">차장</c:when>
                        <c:when test="${approvalDto.grade == 150}">부장</c:when>
                        <c:when test="${approvalDto.grade == 160}">사장</c:when>
                    </c:choose>
				</td>
			</tr>
		</table>
        
        <h2>아래와 같이 기안하오니 검토 후 결재 바랍니다.</h2>
        
        <h3>${approval.documentFormTitle} 요청 정보</h3>
        
		<table>
	     	<tr>
	     		<th>항목코드</th>
	     		<th>내용</th>
	     		<td>금액</td>
	     	</tr>
	   </table> 
	   <c:set var="costTotal" value="0" />	
   	   <table>
       <c:forEach var="appCost" items="${appCostList}">
               <tr>
               	<td>
                   	<select name="costDetailsCode">
                           <option value="100" <c:if test="${appCost.costDetailsCode == 100}">selected</c:if>>비품</option>
                           <option value="110" <c:if test="${appCost.costDetailsCode == 110}">selected</c:if>>유류비</option>
                           <option value="120" <c:if test="${appCost.costDetailsCode == 120}">selected</c:if>>공과금</option>
                           <option value="130" <c:if test="${appCost.costDetailsCode == 130}">selected</c:if>>특수비용</option>
                       </select>
                   </td>    
                   <td>
                       <input type="text" name="costDetailsCnt" value="${appCost.costDetailsCnt}" />
                   </td>
                   <td>
                       <input type="number" name="costAmount" value="${appCost.costAmount}" />
                   </td>
               </tr>
		</c:forEach>
    </table>

        <h3>첨부 파일</h3>
        <div style="margin-bottom: 20px;">
            <label for="relatedDocuments">연관문서:</label>
            <button type="button" onclick="document.getElementById('relatedDocument').click()" style="margin-top: 5px;">찾아보기</button>
            <input type="file" id="relatedDocuments" name="relatedDocuments" style="display:none;" multiple onchange="addFileNames('fileNames', this.files)"/>
            <div id="fileNames" style="margin-top: 10px; display: flex; flex-direction: column;"></div>
        </div>
        <div style="margin-bottom: 20px;">
            <label for="fileAttachment">파일첨부:</label>
            <button type="button" onclick="document.getElementById('fileAttachment').click()" style="margin-top: 5px;">찾아보기</button>
            <input type="file" id="fileAttachment" name="fileAttachment" style="display:none;" multiple onchange="addFileNames('attachedFileNames', this.files)"/>
            <div id="attachedFileNames" style="margin-top: 10px; display: flex; flex-direction: column;"></div>
        </div>

        <div class="btn-group">
		    <button type="submit" class="btn btn-primary">작성</button>
		    <button type="button" class="btn btn-secondary" onclick="resetForm()">초기화</button>
		    <button type="button" onclick="deleteApproval(${approvalDto.documentFormId}, ${approvalDto.approvalNum})">삭제</button>
		    <button type="button" class="btn btn-outline-secondary" onclick="goBack()">목록</button>
		</div>
    
    <!-- 모달 -->    
	 <div class="modal fade" id="addressModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h1 class="modal-title fs-5" id="exampleModalLabel">결재라인 추가</h1>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body">
	                <div class="container-fluid">
	                    <div class="row">
	                        <div class="col-sm-7">
	                            <div class="accordion accordion-flush" id="accordionFlushExample">
	                                <!-- 직원 아코디언 항목이 동적으로 추가될 부분 -->
	                            </div>
	                        </div>
	
	                        <div class="col-md-4 ms-auto">
	                            <div class="text-center">
	                                <span class="font-weight-bold text-primary">결재자</span>
	                                <div class="selected-approvers text-start" id="selectedApprovers">
	                                    <!-- 선택된 결재자 목록 -->
	                                </div>
	                            </div>
	                            <hr>
	                            <div class="text-center">
	                                <span class="font-weight-bold text-primary">참조자</span>
	                                <div class="selected-referrers text-start" id="selectedReferrers">
	                                    <!-- 선택된 참조자 목록 -->
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	
	            <div class="modal-footer">
					<button type="button" class="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-outline-warning btn-sm" onclick="addSelectedMembers();">적용</button>
	            </div>
	        </div>
	    </div>
	</div>
    </form>
</main>
</body>
</html>
