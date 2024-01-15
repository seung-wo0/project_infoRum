<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String uid_session = (String)session.getAttribute("uid_session");
String profile_session = (String)session.getAttribute("profile_session");

if(profile_session==null){
	profile_session="nullprofile.png";
}

out.print(profile_session);
%>    
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<link rel="stylesheet" href="/style/memStyle.css?v">
</head>
<body>
	<div id="wrap" class="memberWrap"> 
		<h1>회원 정보 수정</h1>
		
		<form action="/profileProc" method="post" enctype="multipart/form-data">
			<div id="profileArea">
				<img src="../profileImg/<%=profile_session%>" alt="프로필 이미지" >
				<input type="file" name="fName" required>
				<button id="profileUpdateBtn">사진<br>변경</button>
				<input type="hidden" name="uid" value="<%=uid_session%>" >
				<input type="hidden" name="delfName" value="<%=profile_session%>" >
			</div>
		</form>
		
		
		
		
		<form action="myPageProc">
		<div id="inputArea">
			<span>회원 아이디 : <%=uid_session%></span>  
			<input type="text" placeholder="비밀번호" name="upw" id="upw" required maxlength="20">
			<input type="password" placeholder="비밀번호 재확인" name="reupw" id="reupw" required maxlength="20">
			<input type="text" placeholder="닉네임" name="nickname" required maxlength="20">
			<input type="text" placeholder="이메일" name="uemail" required maxlength="20">
			<input type="hidden" name="uid" id="uid" value="<%=uid_session%>" >
		</div>

		<div id="btnArea" class="dFlex">
			<button id="joinBtn">수정하기</button>
			<button type="button" onclick="location.href='/'">돌아가기</button>
		</div>
		
		</form>
		
	</div>
	<!-- div#wrap -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="/script/memScript.js"></script>
</body>
</html>    