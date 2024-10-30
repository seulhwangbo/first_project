<%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"%> 
     
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>Insert title here</title>
</head>
<script type="text/javascript">
function btn(){
    alert('추가수당이 확정되었습니다.');
}
</script>
<body>
<h2>${salNum } 추가수당 확인</h2>
급여 지급일 : ${salDate}

<table class="table table-hover">
   
    <thead>
        <tr>
            <th>번호</th>
            <th>사원번호</th>
            <th>사원명</th>
            <th>부서</th>
            <th>직급</th>
            <th>초과시간</th>
            <th>추가근무수당</th>
        </tr>
<!--             <form action="updateOvertimeSal" method="POST">	 -->
    </thead>
    <tbody>
        <c:set var="num" value="1"></c:set>
        <c:forEach var="emp" items="${overtimeSalList}">
            <tr>
                <td>${num}</td>
                <td>${emp.empno}</td>
                <td>${emp.name}</td>
                <td>${emp.deptName}</td>
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
                   <td>${emp.totalOvertime  }시간</td>
                   <td><fmt:formatNumber value="${emp.overtimeSal }" type="currency" /></td>
            </tr>
            <c:set var="num" value="${num + 1}"></c:set>
                         <input type="hidden" name="salNum" value="${salNum}" />
        </c:forEach>
</table>
<button class="btn btn btn-outline-secondary" onclick="window.open('/mh/updateOvertimeSal?salNum=${salNum }','width=500,height=500,resizable=no')"> 추가수당 확정 </button>
	<button onclick="window.close()">닫기</button>

<!-- 						<button type="submit"> 추가수당 확정 </button>
					</form>
 -->
</body>
</html>