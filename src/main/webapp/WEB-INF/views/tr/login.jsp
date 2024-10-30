<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

<style>
.gradient-custom {
	background: linear-gradient(to right, rgba(106, 17, 203, 1),
		rgba(37, 117, 252, 1));
}

footer {
	position: absolute;
	bottom: 0;
	width: 100%;
	text-align: center;
	color: white;
	padding: 10px 0;
	background-color: rgba(0, 0, 0, 0.5);
}
</style>
</head>
<body class="gradient-custom">
	<section class="d-flex vh-100">
		<div
			class="container-fluid row justify-content-center align-content-center">
			<div class="card bg-dark" style="border-radius: 1rem;">
				<div class="card-body p-5 text-center">
					<h2 class="text-white">LOGIN</h2>
					<p class="text-white-50 mt-2 mb-5">로그인 안하냐?</p>

					<div class="mb-2">
						<form action="user_main" method="POST">

							<div class="mb-3">
								<label class="form-label text-white">사번</label> <input
									type="text" class="form-control" name="empno" required>
							</div>
							<div class="mb-3">
								<label class="form-label text-white">비밀번호</label> <input
									type="password" class="form-control" name="password" required>
							</div>
							<button type="submit" class="btn btn-primary">확인</button>
						</form>

						<button type="button" class="btn btn-secondary mt-3"
							onclick="location.href='/tr/findPassword'">비밀번호
							찾기</button>
					</div>
				</div>
			</div>
		</div>
	</section>

	<footer>
	오늘의 추천 메뉴 : ${menu}
		<p id="current-time"></p>
	</footer>

	<script>
		function updateTime() {
			const now = new Date();
			const hours = String(now.getHours()).padStart(2, '0');
			const minutes = String(now.getMinutes()).padStart(2, '0');
			const seconds = String(now.getSeconds()).padStart(2, '0');
			const formattedTime = hours + ' : ' + minutes + ' : ' + seconds;

			document.getElementById('current-time').textContent ='현재 시간 '
					+ formattedTime;
		}

		// Update time every second
		setInterval(updateTime, 1000);

		// Initial call to display time immediately on page load
		updateTime();
	</script>
</body>
</html>