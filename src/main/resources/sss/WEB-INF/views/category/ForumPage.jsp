<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
String uid_session = (String)session.getAttribute("uid_session");
String nickname_session = (String)session.getAttribute("nickname_session");
String category = request.getParameter("category");
String linkUrl = request.getRequestURI();

String profile_session = (String)session.getAttribute("profile_session");

if(profile_session==null){
	profile_session="nullprofile.png";
}

%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title><%= category %> 포럼</title>
	<link rel="stylesheet" href="/style/forumStyle.css?v">
</head>
<body>
	<div id="wrap" class="boardTimeline">
	
		<!--  헤더템플릿 시작, iframe으로 변경 -->
		<%@ include file="../inc/headerTmp.jsp" %>
    	<!--  헤더템플릿 끝 -->   
		
		<main id="main">
			<!-- 각 포럼 타이틀명  -->
			<%@ include file="../category/forumTmp/forumTitle.jsp" %>
			<!-- 각 포럼 타이틀명  -->
		
			<% if(uid_session != null) { %>
				<!-- 로그인시 글쓰기영역 inc 시작 -->
				<%@ include file="../category/forumTmp/postUserTmp.jsp" %>
				<!-- 로그인시 글쓰기영역 inc 끝 -->
			<% } %>
			
			<!-- 게시글출력  -->
			<c:forEach var="list" items="${ list }">
			<div id="rowArea" class="listlowMain">
				<%@ include file="../category/forumTmp/postTmp.jsp" %>
					
				<!-- 댓글 출력 부분 inc 시작 -->
				<%@ include file="../category/forumTmp/commentTmp.jsp" %>
				<!-- 댓글 출력부분 inc 끝 -->
			</div>
				
			</c:forEach>
			<!-- 게시글출력 끝 -->
			
				<div id="userCommentArea" class="listlow">
				
				</div>
		</main>
		
	</div>
	<!-- div#wrap -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="/script/forumScript.js"></script>
</body>
</html>    