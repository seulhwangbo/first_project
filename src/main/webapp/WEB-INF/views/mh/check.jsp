<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Enumeration"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<script type="text/javascript">
function checkPasswd() {
    var empno = $('#empno').val();
    var salNum = $('#salNum').val();
    var password = $('#password').val(); 
    console.log("empno:", empno);  
    console.log("salNum:", salNum);
    console.log("password:", password);

    $.ajax({
        type: "POST",
        url: "/mh/processStep1",
        data: { empno: empno, salNum: salNum, password: password },
        success: function(response) {
            console.log("Step 1 성공:", response);
            if (response === "/salJoin") {
                // 비밀번호 성공 시 POST로 salJoin으로 이동
                postToSalJoin(empno, salNum, password);
            } else {
                alert(response);  // 비밀번호가 틀린 경우 메시지
            }
        },
        error: function(error) {
            console.error("오류 발생:", error);
        }
    });
}

function postToSalJoin(empno, salNum, password) {
    // 동적으로 폼 생성
    var form = document.createElement("form");
    form.method = "POST";
    form.action = "/mh/salJoin";  // POST 방식으로 전송할 경로

    // empno, salNum, password 값을 히든 필드로 추가
    var empnoField = document.createElement("input");
    empnoField.type = "hidden";
    empnoField.name = "empno";
    empnoField.value = empno;
    form.appendChild(empnoField);

    var salNumField = document.createElement("input");
    salNumField.type = "hidden";
    salNumField.name = "salNum";
    salNumField.value = salNum;
    form.appendChild(salNumField);
    
    var passwordField = document.createElement("input");
    passwordField.type = "hidden";
    passwordField.name = "password";
    passwordField.value = password;
    form.appendChild(passwordField);

    // 폼을 document에 추가하고 제출
    document.body.appendChild(form);
    form.submit();
}

</script>


<body>
<h2>비밀번호를 확인해 주세요</h2>
비밀번호:<input type="password" id="password" name="password">
<input type="hidden" id="empno" name="empno" value="${emp.empno }">
<input type="hidden" id="salNum" name="salNum" value="${salNum }">
<button onclick="checkPasswd()" >확인</button>
</body>
</html>