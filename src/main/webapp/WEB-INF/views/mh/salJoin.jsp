<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<meta charset="UTF-8">
<title>관리자 급여지급 페이지입니다</title>
</head>
<style type="text/css">
.text {
  width: 300px;
  height: 32px;
  font-size: 15px;
  border: 0;
  border-radius: 15px;
  outline: none;
  margin: auto;
  background-color: rgb(233, 233, 233);
  
}

#total{
 background-color: rgb(255, 255, 255);

}
#salFinal{
 background-color: rgb(255, 255, 255);

}
#tax {
 background-color: rgb(255, 255, 255);

}
        #btn1{
            border-radius: 5px;
            border: 1px solid rgb(233, 233, 233);
            background-color: rgba(0,0,0,0);
            color: black;
            padding: 5px;
            float: inherit;
        }
        
                #btn2{
            border-radius: 5px;
            border: 1px solid rgb(233, 233, 233);
            background-color: rgba(0,0,0,0);
            color: black; 
            padding: 5px;
            float: inherit;
        }
        #btn1:hover{
            color:black;
            background-color: rgb(233, 233, 233);
        }
                #btn2:hover{
            color:black;
            background-color: rgb(233, 233, 233);
        }
        
.sertchList {
float: left; width: 33%; padding:10px;   
 font-size: 15px;

}

#key {
float: left; width: 33%; padding:10px;  
 border: 0;
  border-radius: 15px;
  outline: none;
  background-color: rgb(233, 233, 233);
   font-size: 15px;
}
body { text-align: center;	}

table {
margin: auto;

}
tr {
text-align: center;
}

</style>
<body>
	<h2>${joinList.SALNUM } 급여 명세서</h2>
	급여 지급일 : ${joinList.SALDATE}
	<table class="table" style="width:50%">
			<tr>
			</tr>
				<tr>
					<thead><tr><th>지급 항목명</th><th>금액 (${joinList.EMPNO}, ${joinList.NAME })</th></tr></thead><tbody>
<tr><th>기본급</th><th><input type="text" value="${joinList.SALBASE }" class="text" readonly="readonly" id="base">  </th></tr>
<tr><th>식대</th><th><input type="text" value="${joinList.SALFOOD }" class="text" readonly="readonly" id="food"></th></tr>
<tr><th>상여금</th><th><input type="text" value="${joinList.SALBONUS }" class="text" readonly="readonly" id="bonus"></th></tr>
<tr><th>추가수당</th><th><input type="text" value="${joinList.SALNIGHT }" class="text" readonly="readonly" id="night"></th></tr>
<tr><th style="background-color:rgb(233, 233, 233)">지급합계</th><th style="background-color:rgb(233, 233, 233)"><input type="text" readonly="readonly" id="total" value="${joinList.SALTOTAL}" class="text"></th></tr>
<tr><th style="background-color:rgb(233, 233, 233)">소득세</th><th style="background-color:rgb(233, 233, 233)"><input type="text" readonly="readonly" id="tax" value="${joinList.TAX }" class="text"></th></tr>
<tr><th style="background-color:rgb(233, 233, 233)">공제총합</th><th style="background-color:rgb(233, 233, 233)"><input type="text" readonly="readonly" id="tax" value="${joinList.TAX }" class="text"></th></tr>
<tr><th style="background-color:rgb(233, 233, 233)" >차인지급액</th><th style="background-color:rgb(233, 233, 233)"><input type="text" readonly="readonly" id="salFinal" value="${joinList.SALFINAL }" class="text"></th></tr>
	</tbody>
	</table>
				<p>
				<p>
				<p>
				<p>
				
	<button onclick="window.close()">닫기</button>
</body>
</html>