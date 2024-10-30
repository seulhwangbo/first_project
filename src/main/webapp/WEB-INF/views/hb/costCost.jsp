<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style type="text/css">
    body {
	    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
	    background-color: #f4f4f4;
	    margin: 0;
	    padding: 0;
	    justify-content: center;
	    align-items: center;
	    height: 100vh;
	}
	
	main {
	    padding: 30px 10%;
	    background-color: #fff;
	    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	    margin: 20px auto;
	    border-radius: 8px;
	}
	
	h2 {
	    color: #3333CC;
	    border-bottom: 2px solid #3333CC;
	    padding-bottom: 10px;
	    margin-bottom: 20px;
	}
	
	table {
	    margin: 20px auto;
	    width: 100%;
	    border-collapse: collapse;
	    border-radius: 8px;
	    overflow: hidden;
	    text-align: center;
	}
	
	.tg {
	    border: none;
	    border-color: #4d4d4d;
	}
	
	.tg td {
	    border-color: #007acc;
	    color: #333333;
	    overflow: hidden;
	    padding: 10px 5px;
	    word-break: normal;
	}
	
	.tg th {
	    background-color: #3333CC;
	    border-color: #005999;
	    color: #ffffff;
	    font-size: 14px;
	    font-weight: normal;
	    overflow: hidden;
	    padding: 10px 5px;
	    word-break: normal;
	}
	
	.search-container {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    margin-bottom: 20px;
	}
	
	select, .searchCostBox {
	    background-color: #ffffff;
	    width: 200px;
	    height: 30px;
	    padding: 5px;
	    border-radius: 5px;
	    border: 1px solid #ccc;
	    margin-right: 5px;
	}
	
	button {
	    padding: 5px 10px;
	    border: none;
	    border-radius: 5px;
	    background-color: #3333CC;
	    color: #ffffff;
	    cursor: pointer;
	    transition: background-color 0.3s;
	}
	
	button:hover {
	    background-color: #005999;
	}
	
	.modal {
	    display: none;
	    position: fixed;
	    z-index: 1000;
	    left: 0;
	    top: 0;
	    width: 100%;
	    height: 100%;
	    overflow: auto;
	    background-color: rgba(0, 0, 0, 0.4);
	}
	
	.modal-content {
	    background-color: #fff;
	    margin: 15% auto;
	    padding: 50px;
	    border: 1px solid #888;
	    width: 50%;
	    border-radius: 8px;
	    text-align: center;
	}

	.modal-content table {
	    width: 100%;
	    border-collapse: separate; /* 셀 간격을 조절할 수 있게 설정 */
	    border-spacing: 10px; /* 열 사이에 공간을 추가 */
	    border: 3px solid black;
	}

	.modal-content th, .modal-content td {
	    padding: 10px; /* 각 셀의 내부 여백을 추가 */
	    text-align: left; /* 필요에 따라 정렬 조정 */
	}
	.modal-content .close {
		float: right;
	
	}
    </style>
    <script type="text/javascript">
	    function searchCosts(event) {
	        event.preventDefault();
	        const form = document.getElementById('searchForm');
	        const formData = new FormData(form);
	        const statusValue = document.getElementById('statusFilter').value;
	        formData.append('costStatus', statusValue);
	        
	        // URLSearchParams를 사용해 쿼리 문자열 생성
	        const params = new URLSearchParams(formData).toString();
	        
	        if (!params || (!formData.get('keyword') && !statusValue)) { {
	            alert('검색 조건을 입력해주세요.'); // 사용자에게 알림
	            return; // 검색을 중단
	        }
	        
	        fetch(`costSearch?${params}`, { // 쿼리 문자열을 URL에 추가
	            method: 'GET'
	        })
	        .then(response => response.text())
	        .then(data => {
	            document.getElementById('searchResults').innerHTML = data;
	        })
	        .catch(error => console.error('Error:', error));
	    }
	        
	      
	        
    </script>
    <title>정산</title>
</head>
<body>
    <main>
        <h2>정산 페이지입니다</h2>
        당신의 사번 : ${emp.name }
        <hr color="#3333CC">
        <div class="container">
            <form id="searchForm" action="costSearch" method="get" class="searchCost" onsubmit="searchCosts(event)">
                <select name="costStatus" id="statusFilter" class="searchCost">
                    <option value="100" <c:if test="${selectedStatus == '100'}">selected</c:if>>대기</option>
                    <option value="110" <c:if test="${selectedStatus == '110'}">selected</c:if>>승인</option>
                    <option value="120" <c:if test="${selectedStatus == '120'}">selected</c:if>>거부</option>
                </select>
                <select name="search" id="searchCost" class="searchCost">
                    <option value="codeName" <c:if test="${selectedSearch == 'codeName'}">selected</c:if>>비용항목</option>
                    <option value="name" <c:if test="${selectedSearch == 'name'}">selected</c:if>>신청자</option>
                </select>
                <input type="text" name="keyword" value="${keyword}" class="searchCostBox" placeholder="검색어를 입력하세요">
                <button type="submit" value="검색">검색</button>
            </form>
        </div>

        <div class="costPlus">
            <a href="costPlus"><input type="button" value="정산 신청" style="float: right; margin: 20px;" ></a>
        </div>
        
        <div id="searchResults">
            <table class="tg">
                <thead>
                    <tr>
                        <th class="bold-header header-center">순서</th>
                        <th class="header-center">비용항목</th>
                        <th class="header-center">처리상태</th>
                        <th class="header-center">제목</th>
                        <th class="header-center">신청자</th>
                        <th class="header-center">부서</th>
                        <th class="header-center">신청날짜</th>
                        <th class="header-center">금액</th>
                        <th class="header-center">문서번호</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="CostCodeCost" items="${costList}" varStatus="status">
                        <tr>
                            <td class="cell-center">${status.index + 1}</td>
                            <td class="cell-center">${CostCodeCost.codeName}</td>
                            <td class="cell-center">
                                <c:choose>
                                    <c:when test="${CostCodeCost.costStatus == 100}">
                                        <span style="color: blue;">${costMap[CostCodeCost.costStatus]}</span>
                                    </c:when>
                                    <c:when test="${CostCodeCost.costStatus == 110}">
                                        <span style="color: green;">${costMap[CostCodeCost.costStatus]}</span>
                                    </c:when>
                                    <c:when test="${CostCodeCost.costStatus == 120}">
                                        <span style="color: red;">${costMap[CostCodeCost.costStatus]}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span>${cost.costStatus}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="cell-center" >
                                <a href="javascript:void(0);" style="text-decoration: none;  color: black;" onclick="openModal({
                                    costYear: '${CostCodeCost.costYear}',
                                    codeName: '${CostCodeCost.codeName}',
                                    costTitle: '${CostCodeCost.costTitle}',
                                    name: '${CostCodeCost.name}',
                                    deptno: '${CostCodeCost.deptno}',
                                    costMoney: '${CostCodeCost.costMoney}',
                                    attach: '${CostCodeCost.attach}' })">
                                    ${CostCodeCost.costTitle}</a>
                            </td>
                            <td class="cell-center">${CostCodeCost.name}</td>
                            <td class="cell-center">${CostCodeCost.deptName}</td>
                            <td class="cell-center">${CostCodeCost.signdate}</td>
                            <td class="cell-center">${CostCodeCost.costMoney}</td>
                            <td class="cell-center">${CostCodeCost.costYear}-${CostCodeCost.signdate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- 모달 구조 -->
        <div id="detailModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <h2>비용 상세 내역</h2>
                <table>
                    <tr><th>순서</th><td id="modalCostYear"></td></tr>
                    <tr><th>비용항목</th><td id="modalCodeName"></td></tr>
                    <tr><th>제목</th><td id="modalCostTitle"></td></tr>
                    <tr><th>신청자</th><td id="modalName"></td></tr>
                    <tr><th>부서</th><td id="modalDeptno"></td></tr>
                    <tr><th>금액</th><td id="modalCostMoney"></td></tr>
                    <tr><th>증빙서류</th><td id="modalAttach"></td></tr>
                </table>
            </div>
        </div>
    </main>
    <script>
    function openModal(costDetail) {
        document.getElementById('modalCostYear').innerText = costDetail.costYear;
        document.getElementById('modalCodeName').innerText = costDetail.codeName;
        document.getElementById('modalCostTitle').innerText = costDetail.costTitle;
        document.getElementById('modalName').innerText = costDetail.name;
        document.getElementById('modalDeptno').innerText = costDetail.deptno;
        document.getElementById('modalCostMoney').innerText = costDetail.costMoney;
        document.getElementById('modalAttach').innerText = costDetail.attach;
        document.getElementById('detailModal').style.display = 'block';
    }

    function closeModal() {
        document.getElementById('detailModal').style.display = 'none';
    }

    window.onclick = function(event) {
        const modal = document.getElementById('detailModal');
        if (event.target == modal) {
            closeModal();
        }
    };
    </script>
</body>
</html>
