<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../1.main/admin_header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>정산 상세 페이지입니다</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ccc;
        }

        th {
            background-color: #f2f2f2; /* 헤더 회색 */
        }

        tr:nth-child(even) {
            background-color: #e9e9e9; /* 짝수 행 회색 */
        }

        tr:hover {
            background-color: #d0d0d0; /* 마우스 오버 시 색상 변화 */
        }
    </style>
</head>
<body>
    <h2>정산 상세 정보</h2>
    <table>
        <tr>
            <th>처리상태</th>
            <td>
                <select id="adminStatusSelect">
                    <c:forEach var="costStatus" items="${statusList}">
                        <option value="${costStatus.key}" 
                                <c:if test="${costDetail.costStatus == costStatus.key}">selected</c:if>
                        >${costStatus.value}</option>
                    </c:forEach>
                </select>
                <div class="button-container">
                    <input type="button" value="상태 변경" onclick="changeStatus()">
                </div>
            </td>
        </tr>
        <tr><th>순서</th><td>${costDetail.costYear}</td></tr>
        <tr><th>비용항목</th><td>${costDetail.codeName}</td></tr>
        <tr><th>제목</th><td>${costDetail.costTitle}</td></tr>
        <tr><th>신청자</th><td>${costDetail.name}</td></tr>
        <tr><th>부서/부서번호</th><td>${costDetail.deptName}/${costDetail.deptno }</td></tr>
        <tr><th>금액</th><td>${costDetail.costMoney}</td></tr>
        <tr><th>증빙서류</th><td>${costDetail.attach}</td></tr>
        <tr>
            <td colspan="2">
                <input type="button" value="목록" onclick="location.href='adminCostCheck'">
            </td>
        </tr>
    </table>
		
    <script>
        function changeStatus() {
            var selectedStatus = document.getElementById("adminStatusSelect").value;
            var costTitle = "${costDetail.costTitle}";
            var costYear = "${costDetail.costYear}";

            console.log("Selected Status:", selectedStatus);
            console.log("Cost Title:", costTitle);
            console.log("Cost Year:", costYear);

            // AJAX 요청
            $.ajax({
                url: 'adminStatusSelect',
                method: 'GET',
                data: {
                    costTitle: costTitle,
                    costStatus: selectedStatus,
                    costYear: costYear
                },
                success: function(data) {
                    alert(data);
                    location.reload(); // 페이지 새로고침
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert('오류 발생: ' + textStatus);
                    console.error('오류:', errorThrown);
                }
            });
        }
    </script>
</body>
</html>
