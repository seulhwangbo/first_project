<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
        
    }
    main {
        padding: 30px 10%;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        margin: 20px auto;
        border-radius: 8px;
    }
    h2 {
        color: #333;
        border-bottom: 2px solid #3333CC; /* 진한 파란색 */
        padding-bottom: 10px;
    }
    .container {
        text-align: center;
        margin-bottom: 20px;
        display: flex; /* Flexbox 사용 */
        justify-content: center; /* 수평 중앙 정렬 */
    }

    .searchCard {
        margin-right: 10px; /* 검색 버튼과의 간격 */
        background-color: white; /* 버튼 배경색 */
        color: black; /* 버튼 글자색 */
        cursor: pointer;
        border: none;
        border-radius: 5px;
        padding: 5px 10px;
        transition: background-color 0.3s; /* 부드러운 효과 */
    }

    .searchCardBox {
        margin-right: 10px; /* 입력 박스와의 간격 */
    }
    .searchCardBox:focus, .searchCard:focus {
        border-color: #3333CC; /* 진한 파란색 포커스 */
        outline: none;
    }
    .  submitButton {
    	background-color: #3333CC
    }
    
    .searchCard:hover {
        background-color: #3333CC; /* 버튼 호버 시 색상 변경 */
    }
    .cardLost {
        float: right;
        margin: 20px;
        background-color: #3333CC; /* 진한 파란색 */
        color: #fff;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s; /* 부드러운 효과 */
    }
    .cardLost:hover {
        background-color: #005999; /* 버튼 호버 시 색상 변경 */
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    th, td {
        padding: 12px;
        text-align: center;
        border: 1px solid #ddd;
    }
    th {
        background-color: #3333CC; /* 진한 파란색 헤더 배경 */
        color: white;
    }
    tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    tr:hover {
        background-color: #e0e0e0;
    }
    .CardUseNum {
        width: 60px;
    }
</style>
<title>카드</title>
</head>
<body>
<main>
    <h2>카드 사용내역 페이지입니다</h2>
    <hr/>
 <div class="container">
    <form action="cardUseSearch" method="get" class="searchCard">
        <select name="search" id="costsearchCard" class="searchCard">
            <option value="cardNum" <c:if test="${selectedSearch == 'cardNum'}">selected</c:if>>카드번호</option>
            <option value="name" <c:if test="${selectedSearch == 'name'}">selected</c:if>>보유직원</option>
            <option value="deptName" <c:if test="${selectedSearch == 'deptName'}">selected</c:if>>부서이름</option>
            <option value="useDate" <c:if test="${selectedSearch == 'useDate'}">selected</c:if>>사용일</option>
        </select>
        <input type="text" name="keyword" class="searchCardBox" placeholder="검색어를 입력하세요" value="${keyword}">
        <button type="submit" class="searchCard">검색</button>
    </form>
</div>

    <a href="costCardLost">
        <input type="button" class="cardLost" value="분실 신고">
    </a>
    <table>
        <tr>
            <td class="CardUseNum">순서</td>
            <th>카드번호</th>
            <th>사용처</th>
            <th>보유직원/부서이름</th>
            <th>사용일</th>
            <th>금액</th>
        </tr>
	        <c:if test="${not empty cardUseList}">
	    <c:forEach var="cardUse" items="${cardUseList}" varStatus="status">
	        <tr>
	            <td>${status.index + 1}</td>
	            <td>${cardUse.cardNum}</td>
	            <td>${cardUse.place}</td>
				<td>${cardUse.name}/${cardUse.deptName}</td>
	            <td>${cardUse.useDate}</td>
	            <td>${cardUse.cardCost}</td>
	        </tr>
	    </c:forEach>
	</c:if>
<c:if test="${empty cardUseList}">
    <tr>
        <td colspan="6">검색 결과가 없습니다.</td>
    </tr>
</c:if>
</table>
</main>
</body>
</html>
