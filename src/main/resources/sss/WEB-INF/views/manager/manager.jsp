<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>매니저</title>
	<link rel="stylesheet" href="/style/managerStyle.css?v">
	<link rel="stylesheet" href="../style/headerTmpStyle.css?v">

</head>
<body>

		<!--  헤더템플릿 시작, iframe으로 변경 -->
		<%@ include file="../inc/headerTmp.jsp" %>
    	<!--  헤더템플릿 끝 -->   

	<div id="wrap" class="listWrap">
		<header id="header" class="dFlex">
			<h1>회원 목록</h1>
		</header>
		
		
		<main id="main" class="listArea">

			<div id="listHeader" class="listCol dFlex">
				<span>번호</span>
				<span>아이디</span>
				<span>닉네임</span>
				<span>이메일</span>
				<span>가입시간</span>
				<span>회원분류</span>
				<span>권한 변경</span>
			</div>
			
			<c:forEach var="userList" items="${userList}" varStatus="status">
			<div class="listCol listRow dFlex">
				<span>${status.count}</span>
				<span>${userList.uid}</span>
				<span>${userList.nickname}</span>
				<span>${userList.uemail}</span>
				<span><fmt:formatDate value="${userList.regTM}" pattern="yyyy.MM.dd a HH:mm:ss" /></span>
				 <c:choose>
                        <c:when test="${userList.auth eq 2}">
                            <span id="authLevel">슈퍼관리자</span>
                            <span>&nbsp;&nbsp;</span>
                        </c:when>
                        <c:when test="${userList.auth eq 1}">
                            <span id="authLevel">서브관리자</span>
                        </c:when>
                        <c:when test="${userList.auth eq 0}">
                            <span id="authLevel">일반회원</span>
                            <!-- Hidden Select Dropdown for demonstration purposes -->
                            <span>
                                <select class="authoritySelect" id="authoritySelect_${userList.uid}">
                                    <option value="0">일반회원</option>
                                    <option value="1">서브관리자</option>
                                </select>
                                <button class="authChangeBtn" id="authChange_${userList.uid}">권한 변경</button>
                            </span>
                        </c:when>
                    </c:choose>
			</div>			
			</c:forEach>
		</main>
	</div>
	<!-- div#wrap -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="/script/managerScript.js"></script>
</body>
</html>    