<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../1.main/admin_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<meta charset="UTF-8">
<title>관리자 급여대장 페이지입니다</title>
<style type="text/css">
table, th, tr, td {
	border: solid 1px;
	border-collapse : collapse; 
}

body  { text-align: center;	}

table {
margin: auto;

}

</style>
</head>
<body>
	<h2>${salNum } 급여대장</h2>
	<table class='table'><thead>
  <tr class="table-primary">
    <th colspan="10">${salDate}
  </tr></thead>
<tbody>
  <tr  class="table-info">
    <td rowspan="2">체크박스</td>
    
    <td >사원번호</td>
    <td>성명</td>
    <td>기본급</td>
    <td>상여</td>
    <td>야간근로</td>
    <td>식대</td>
    <td>지급합계</td>
    <td>지급총액</td>
    <td>지급일</td>
  </tr>
  <tr class="table-info">
    <td>부서</td>
    <td>직책</td>
    <td>소득세</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>공제총액</td>
    <td>-</td>
  </tr>
  <tr class="table-info">
  <td colspan="10">
    		<form action="listSearchList">
			<select class ="sertchList" name="search">
				<option class ="sertchList" value="seartchEmpno">사원번호</option>
				<option class ="sertchList"  value="seartchName">사원명</option>
				<option class ="sertchList" value = "seartchDet">부서</option>
<!-- 				<option class ="sertchList" value = "seartGrade">직급</option> -->
				<option class ="sertchList" value = "seartchsalnum">근로월</option>
			</select> 
			<input type="text" name="keyword" id="key">
			<button type="submit" id="btn2">검색</button>
		</form>
  </tr>

 <c:forEach var="emp" items="${listEmp }">
    <tr>
    <td rowspan="2"><button id="btnEmp_${emp.empno}" onclick="window.open('/mh/salJoin?empno=${emp.empno}&salNum=${emp.salNum}','_blank', 'width=1000,height=700')" value="${emp.empno }" >명세서 보기</button> </td>
    <td>${emp.empno }</td>
    <td>${emp.name}</td>
    <td><fmt:formatNumber value="${emp.salBase }" type="currency" /></td>
    <td><fmt:formatNumber value="${emp.salBonus }" type="currency" /></td>
    <td><fmt:formatNumber value="${emp.salNight }" type="currency" /></td>
    <td><fmt:formatNumber value="${emp.salFood }" type="currency" /></td>
    <td><fmt:formatNumber value="${emp.salTotal }" type="currency" /></td>
    <td><fmt:formatNumber value="${emp.salFinal }" type="currency" /></td>
    <td>${emp.salDate }</td>
  </tr>
  <tr>
    <td>${emp.deptName }</td>
   <td>
            <c:choose>
                <c:when test="${emp.grade == 100}">사원</c:when>
                <c:when test="${emp.grade == 110}">주임</c:when>
                <c:when test="${emp.grade == 120}">대리</c:when>
                <c:when test="${emp.grade == 130}">과장</c:when>
                <c:when test="${emp.grade == 140}">차장</c:when>
                <c:when test="${emp.grade == 150}">부장</c:when>
                <c:when test="${emp.grade == 160}">사장</c:when>
                <c:otherwise>직급 정보 없음</c:otherwise>
            </c:choose>
        </td>
    <td><fmt:formatNumber value="${emp.tax }" type="currency"/></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td><fmt:formatNumber value="${emp.tax }" type="currency"/></td>
    <td>-</td>
    <td>-</td>

  </tr>
 </c:forEach>
  

</tbody>
</table>

</body>
</html>