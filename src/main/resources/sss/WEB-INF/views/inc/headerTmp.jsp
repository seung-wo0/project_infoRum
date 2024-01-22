<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String uid_session2 = (String)session.getAttribute("uid_session");
	String nickname_session2 = (String)session.getAttribute("nickname_session");
	int auth_session = 0;
	
	if(uid_session2!=null){
	auth_session = (int)session.getAttribute("auth_session");
	
}
%>
<link rel="stylesheet" href="../style/headerTmpStyle.css?v">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="../script/headerTmpScript.js"></script>


<body>
	<div class="header">
		<div class="header_inner clearfix dFlex">

			<div id="headerMenu">
				<a href="/"> 
					<img src="/images/menu_icon.png" width="45px">
				</a>
			</div>
			<div id="logo">
					<img src="/images/logo.png" width="150px">
			</div>
			<div id="headerIcon">
				
				<%if(uid_session2==null || uid_session2=="") {%>
				<a href="/login"> 
					<img src="/images/Login_icon.png" width="45px">
				</a> 
				<%} else if(auth_session == 2) {%>
				<div id="loginStateMenu" class="dFlex">
				<img src="/images/mypage_icon.png" width="45px" onclick="location.href='/myPage'">
				<img src="/images/logout_icon.png" width="45px" onclick="location.href='/logout'">	
				<span class="notosanskr">관리자님<br>환영합니다</span>			
				</div>
				
			<%} else{%>
				<div id="loginStateMenu" class="dFlex">
				<img src="/images/mypage_icon.png" width="45px" onclick="location.href='/myPage'">
				<img src="/images/logout_icon.png" width="45px" onclick="location.href='/logout'">		
				<span class="notosanskr"><%= nickname_session2 %>님<br>환영합니다</span>
				</div>	
			<%} %>
				<a href="/"> 
					<img src="/images/home_icon.png" width="45px">
				</a>
				
				
			</div>
		</div>
	</div>
</body>