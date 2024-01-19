<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="java.sql.Timestamp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>infoRum</title>
<link href="images/logo.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="/style/inquiryStyle.css?v">
<script>
		function moveDetail(num) {
			location.href="./inquiryDetail?num="+num;
		}
	</script>
</head>
<body>

	<!--  헤더템플릿 시작, iframe으로 변경 -->
	<%@ include file="../inc/headerTmp.jsp"%>
	<!--  헤더템플릿 끝 -->


	<div id="wrap">

		<div id="header">
			<span class="notosanskr">1:1문의 게시판</span>
		</div>
		<div id="page">페이지:${page}/${allPage}</div>
		
		<table id="inquiryTbl">
			<thead>
				<tr id="theadTr">
					<td class="num theadNum">문의번호</td>
					<td class="title">제목</td>
					<td class="name">이름</td>
					<td class="regTm">날짜</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="list" items="${list}">
					<tr class="tbdyTr" onclick="moveDetail(${list.num})">
						<td class="num">${list.num}</td>
						<td class="title tbdyTitle">${list.title}</td>
						<td class="name">${list.nickname}</td>
						<td class="regTm">
						            <fmt:formatDate value="${list.regTm}" pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="inquiryBtn" onclick="writeInquiry()">글쓰기</div>
		<div style="display:flex;justify-content: left; width: 500px;">
			<img src="./images/right.png" id="leftPageText" style="width:20px;height:20px;margin-top: 7px; cursor: pointer" onclick=movePage(${startPage-1},${allPage})>
			<div class="pageText" id="pageText0" onclick=movePage(${startPage},${allPage})>${startPage}</div>
			<div class="pageText" id="pageText1" onclick=movePage(${startPage+1},${allPage})>${startPage+1}</div>
			<div class="pageText" id="pageText2" onclick=movePage(${startPage+2},${allPage})>${startPage+2}</div>
			<div class="pageText" id="pageText3" onclick=movePage(${startPage+3},${allPage})>${startPage+3}</div>
			<div class="pageText" id="pageText4" onclick=movePage(${startPage+4},${allPage})>${startPage+4}</div>
			<img src="./images/left.png" id="pageText5" style="width:20px;height:20px;    margin-top: 7px;cursor: pointer" onclick=movePage(${startPage+5},${allPage})>
		</div>
	</div>
	
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="/script/noticeScript.js"></script>
	<script>
		function movePage(page,finalPage) {
			if(page<1) {
				location.href = "http://localhost:82/inquiry?page="+1;
				return;
			}
			if(page<finalPage) {
				location.href = "/inquiry?page="+page;
			} else {
				location.href = "/inquiry?page="+finalPage;
			}
			
		}
		function writeInquiry() {
			location.href = "/inquiryWrite";
		}
		if(${startPage}==1) {
			document.getElementById("leftPageText").style.display="none";
		}
		for(let i=0;i<=5;i++) {
			if(${startPage}+i>${allPage}) {
				document.getElementById("pageText"+i).style.display="none";
			}
		}
		if(${page}%5==0) {
			document.getElementById("pageText"+4).style.fontWeight="bold";
		}
		else {
			document.getElementById("pageText"+Number(${page}%5-1)).style.fontWeight="bold";
		}
	</script>
</body>

</html>
