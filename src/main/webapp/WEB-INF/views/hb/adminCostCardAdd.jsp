<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../1.main/admin_header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카드 추가</title>
<style type="text/css">
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 20px;
    }
    h1 {
        color: #333;
        border-bottom: 2px solid #8C8C8C; /* 제목 밑줄 색상 */
        padding-bottom: 10px;
        margin-bottom: 20px;
        text-align: center;
    }
    form {
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        max-width: 600px;
        margin: 0 auto;
    }
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        padding: 12px;
        border: 2px solid #ddd;
        text-align: center;
    }
    th {
        background-color: #8C8C8C; /* 테이블 헤더 배경색 */
        color: white;
        font-size: 16px;
    }
    input[type="text"] {
        width: 100%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
    }
    input[type="submit"], input[type="button"] {
        background-color: #8C8C8C; /* 버튼 배경색 */
        color: white;
        border: none;
        padding: 10px 20px;
        margin: 10px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s ease;
    }
    input[type="submit"]:hover, input[type="button"]:hover {
        background-color: #7A7A7A; /* 마우스 오버 시 색상 */
    }
    a {
        text-decoration: none;
    }
</style>
</head>
<body>
    <h1>카드 추가</h1>
    <form action="adminCostCardAdd" method="post">
        <table>
            <tr>
                <th>카드번호</th>
                <td><input type="text" name="cardNum" required></td>
            </tr>
            <tr>
                <th>카드사</th>
                <td><input type="text" name="cardBank" required></td>
            </tr>
            <tr>
                <th>보유직원</th>
                <td><select name="empno" required>
                    <option value="">직원을 선택하세요</option>
                	<c:forEach var="emp" items="${empList}">
            			<option value="${emp.empno}">${emp.name}/${emp.empno}</option> 
            		</c:forEach>
				</td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <input  type="submit" value="제출">
                    <a href="adminCostCard"><input type="button" value="돌아가기"></a>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
