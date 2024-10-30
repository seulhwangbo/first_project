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
	<h2>관리자 급여지급 페이지입니다</h2>
	급여 지급일 : ${salDate}
	<table class="table" style="width:50%">
			<tr>
			</tr>
				<tr>
					<thead><tr><th>지급 항목명</th><th>금액 (${shemp.empno}, ${shemp.name })</th></tr></thead><tbody>
<tr><th>기본급</th><th><input type="number" value="${shemp.salBase }" class="text" id="base">  </th></tr>
<tr><th>식대</th><th><input type="number" value="${shemp.salFood }" class="text" id="food"></th></tr>
<tr><th>상여금</th><th><input type="number" value="${shemp.salBonus }" class="text" id="bonus"></th></tr>
<tr><th>추가수당</th><th><input type="number" value="${shemp.salNight }" class="text" id="night"></th></tr>
<tr><th style="background-color:rgb(233, 233, 233)">지급합계</th><th style="background-color:rgb(233, 233, 233)"><input type="text" readonly="readonly" id="total" value="${shemp.salTotal }" class="text"></th></tr>
<tr><th style="background-color:rgb(233, 233, 233)">소득세</th><th style="background-color:rgb(233, 233, 233)"><input type="text" readonly="readonly" id="tax" value="${shemp.tax }" class="text"></th></tr>
<tr><th style="background-color:rgb(233, 233, 233)">차인지급액</th><th style="background-color:rgb(233, 233, 233)"><input type="text" readonly="readonly" id="salFinal" value="${shemp.salFinal }" class="text"></th></tr>
				
				
				
				</tbody>
			</table>
			<button id="btn1"  onclick="location.href='/mh/adminSalGive?currentPage=1'">취소</button>
							<button id="btn2" onclick="salDList(${empno})">저장</button>

<script type="text/javascript">
const num1 = document.getElementById('base');
const num2 = document.getElementById('food');
const num3 = document.getElementById('bonus');
const num4 = document.getElementById('night');
const total = document.getElementById('total');
const tax = document.getElementById('tax');
const salFinal = document.getElementById('salFinal');

function calculateSum() {
    // 각 급여 항목의 합계를 계산
    const sum = Number(num1.value) + Number(num2.value) + Number(num3.value) + Number(num4.value);
    total.value = sum;  // 합계를 업데이트

    // 세금 계산 (1%)
    const taxAmount = Number(total.value) * 0.1;
    tax.value = taxAmount.toFixed(0);  // 세금 값을 업데이트 (소수점 2자리까지)

    // 실수령액 계산 (합계에서 세금을 뺀 값)
    const finalSalary = Number(total.value) - Number(tax.value);
    salFinal.value = finalSalary.toFixed(0);  // 실수령액 업데이트 (소수점 2자리까지)
    
    // 디버깅용 콘솔 출력
    console.log("총 합계: ", sum);
    console.log("세금: ", taxAmount);
    console.log("실수령액: ", finalSalary);
}

// 각 입력 필드에서 값이 변경될 때마다 합계를 계산
num1.addEventListener('input', calculateSum);
num2.addEventListener('input', calculateSum);
num3.addEventListener('input', calculateSum);
num4.addEventListener('input', calculateSum);


function salDList(empno) {
    console.log("start");
    // 입력 필드 값 가져오기
   // var empno = '${shemp.empno}';
    var salBase = $('#base').val();
    var salFood = $('#food').val();
    var salBonus = $('#bonus').val();
    var salNight = $('#night').val();
    var saltotal = $('#total').val();
    var saltax = $('#tax').val();
    var salfinal = $('#salFinal').val();
    console.log(empno);
    
    $.ajax({

        url: '/mh/updateSal', 
        type: 'POST',
        data: {
            empno: empno,
            salBase: salBase,
            salFood: salFood,
            salBonus: salBonus,
            salNight: salNight,
            saltotal: saltotal,
            saltax: saltax,
            salfinal: salfinal,
        },
        success: function(response) {
            alert('급여 정보가 성공적으로 업데이트되었습니다.');
           
        },
        error: function(xhr, status, error) {
            console.error('오류 발생: ' + error);
            alert('급여 정보 업데이트 중 오류가 발생했습니다.');
        }
    });
}
</script>

</body>
</html>