<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../1.main/user_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일보냄</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>

<script type="text/javascript">
	function SearchEmpMail() {
		var keyword = $('#empno').val();
		$.ajax({
			url : "/tr/SearchEmpMail",
			type : "GET",
			data : {
				keyword : keyword
			},
			dataType : "json",
			success : function(response) {
				// alert(listEmpDept);
				var str1 = "";
				var str2 = "";
				console.log(response.listEmpDept);
				$(response.listEmpDept).each(function() {
					str1 = this.name;
					str2 = this.empno + " " + this.name;
					//		console.log("str1->"+str1);
					console.log("str2->" + str2);
					alert("str1->" + str1);
					// alert("str2->"+str2);
				})
			}
		});

	}
</script>
</head>
<body>
	<form action="sendMailTo" method="post">
	<input type="text"  name="Myempno"  value="${emp.empno}"  hidden="hidden">
	${emp.empno}
		보내는 사람 사번
		<p>
			<input type="text" id="empno" name="sendAddress" onchange="SearchEmpMail()">
		<p>제목
		<p>
			<input type="text" name="title">
		<p>내용
		<p>
			<textarea  name="content"  cols="50" rows="30">			
			</textarea>
			<input type="submit" value="작성">
	</form>

</body>
</html>