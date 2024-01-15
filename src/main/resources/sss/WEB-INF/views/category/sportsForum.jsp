<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String uid_session = (String)session.getAttribute("uid_session");
String nickname_session = (String)session.getAttribute("nickname_session");
String category = request.getParameter("category");
String linkUrl = request.getRequestURI();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>스포츠 포럼</title>
	<link rel="stylesheet" href="/style/forumStyle.css?v">
</head>
<body>
	<div id="wrap" class="boardTimeline">
	
		<!--  헤더템플릿 시작, iframe으로 변경 -->
		<%@ include file="../inc/headerTmp.jsp" %>
    	<!--  헤더템플릿 끝 -->   
		
		
		<main id="main">
		<!-- 각 포럼 타이틀명  -->
		<%@ include file="../category/forumTitle/forumTitle.jsp" %>
		<!-- 각 포럼 타이틀명  -->
		<% if(uid_session != null) { %>
			<div id="writeArea">
				<form id="writeFrm">
					<div id="writeInfo" class="dFlex">
						<div id="userProfile">
							<span class="profile">
								<img src="images/board3.jpg" alt="">
							</span>
						</div>
						<div id="userName">
							<span><%= nickname_session %></span>
						</div>
					</div>
					<div id="contentArea">
						<input type="hidden" id="uid" name="uid" value="<%= uid_session %>">
						<input type="hidden" id="nickname" name="nickname" value="<%= nickname_session %>">
						<input type="hidden" id="category" name="category" value="<%= category %>">
						<textarea id="content" name="content" placeholder="무슨말을 전달하고 싶으세요 ?"></textarea>
					</div>
					<div id="writeBtnArea" class="dFlex">
						<button type="button" id="uploadImg">사진</button>
						<button type="button" id="writeBtn">게시</button>
					</div>
				</form>
			</div>
		<% } %>
			
			
			<!-- 게시글출력  -->
			<c:forEach var="list" items="${ list }">
			<div id="rowArea" class="listlowMain">
				<div id="userInfoArea" class="dFlex">
					<div id="userImgArea">
						<span class="profile">
							<img src="images/board3.jpg" width="32" height="32">
						</span>
					</div>
					<div id="userWirterArea">
						<span onclick="userTimelineHome('${ list.uid }')">${ list.nickname }</span>
						<span><fmt:formatDate value="${ list.regTM }" pattern="MM월dd일 a hh:mm"/></span>
					</div>
					<div id="userMoreArea" class="moreIco${ list.num }" onclick="moreSelect('${ list.num }')">
					<c:if test="${ list.uid == uid_session }">
						<img src="images/free-icon-more-2354557.png" alt="더보기">
						<ul>
							<li>수정</li>
							<li onclick="deletePost('${ list.category }','${ list.num }','${ list.uid }','<%=linkUrl%>')">삭제</li>
						</ul>
					</c:if>
					</div>
				</div>

				<div id="listContentArea" class="listContentArea${ list.num }">
					<span>${ list.content }</span>
				</div>
				
				<form id="upContentFrm" class="upContentFrm${ list.num }" action="updatePost">
					<div id="upcontentArea" class="upcontentArea">
						<input type="hidden" id="num" name="num" value="${ list.num }">
						<input type="hidden" name="uid" value="${ list.uid }">
						<input type="hidden" name="nickname" value="${ list.nickname }">
						<input type="hidden" name="category" value="<%=category%>">
						<input type="hidden" name="image" value="">
						<textarea id="content" name="content">${ list.content } </textarea>
						<input type="hidden" name="profile" value="">
						<input type="hidden" name="linkUrl" value="<%=linkUrl %>">
						<div id="updateBtnArea">
							<button type="submit" >수정</button>
						</div>
					</div>
				</form>
				
				<div id="postFooterArea" class="postFooterArea${ list.num }">
					<div id="likeBtnArea">
						<span>좋아요</span>
					</div>
					<div id="commentArea">
						<div id="commentinputArea">
						<% if(uid_session != null) { %>
							<form id="commentFrm" class="commentFrm" action="/writerComment">
								<textarea id="comment" name="comment"></textarea>
								<img src="images/upPhoto.png" width="45" height="45">
								<input type="hidden" name="uid" value="${ uid_session }">
								<input type="hidden" name="nickname" value="${ nickname_session }">
								<input type="hidden" name="category" value="<%=category%>">
								<input type="hidden" id="ref" name="ref" value="${ list.num }">
								<input type="hidden" name="image" value="">
								<input type="hidden" name="profile" value="">
								
								<input type="hidden" name="linkUrl" value="<%=linkUrl %>">
								<button type="submit" id="commentSendBtn" name="commentSendBtn">등록</button>
							</form>
						<% } %>
						</div>
						<div id="commentListArea">
							<!-- 댓글 출력 부분 추가 -->
							
							<c:set var="listCmt" value="cmtList${ list.num }" />
							<c:forEach var="cmtList" items="${ cmtList }">
								<c:if test="${ cmtList.ref == list.num}">
								<div id="comment" class="comment${cmtList.refCnt } dFlex">
									<div id="comment_left" class="comment_left">
										<div id="user_comment_profileArea">
											<span class="profile">
											<c:choose>
												<c:when test="${ cmtList.uid eq '' || cmtList.uid eq null}">
												</c:when>
												<c:otherwise>
													<img src="images/board3.jpg" alt="테스트">
<%-- 												<img src="${ cmtList.profile }" alt="프로필"> --%>
												</c:otherwise>
											</c:choose>
											</span>
										</div>
									</div>
									<div id="comment_right" class="comment_right" >
										<div id="user_comment_nicknameArea">
											<div id="nicknameArea">
												<span style="font-size: 18px;" ><b>${ cmtList.nickname }</b></span>
											</div>
										</div>
										<div id="user_comment_regTMArea">
										<c:choose>
											<c:when test="${ cmtList.uid eq '' || cmtList.uid eq null}">
											<span style="color: #999; font-size: 12px;"></span>
											</c:when>
											<c:otherwise>
											<span style="color: #999; font-size: 12px;"><fmt:formatDate value="${ cmtList.regTM }" pattern="yyyy. MM. dd a HH:mm"/></span>
											</c:otherwise>
										</c:choose>
										</div>
										<div id="user_comment_commentArea" class="comment${list.num}_${ cmtList.refCnt } user_comment_commentArea">
											<span>${ cmtList.comment }</span>
										
											<c:if test="${ uid_session eq cmtList.uid }">
											<form id="editCommentFrm" action="/updateComment">
												<textarea name="comment">${ cmtList.comment }</textarea>
												<input type="hidden" name="uid" value="${cmtList.uid}">
												<input type="hidden" name="ref" value="${cmtList.ref}">
												<input type="hidden" name="refCnt" value="${ cmtList.refCnt }">
												<input type="hidden" name="category" value="<%=category%>">
												<input type="hidden" name="infouserid" value="${ userInfo.uid }">
												<input type="hidden" name="linkUrl" value="<%=linkUrl %>">
												<button type="submit" id="cmtEditBtn" onclick="cmtEditBtnEvt('${ cmtList.uid}','${ list.num }','${ cmtList.refCnt }')">수정</button>
											</form>
											</c:if>
										
										</div>
									</div>
									<div id="userCmtMoreArea" class="commentMoreIco${list.num}_${ cmtList.refCnt }" onclick="commentSelect('${list.num}_${ cmtList.refCnt }')">
									
									<c:if test="${ cmtList.uid == uid_session }">
										<img src="images/free-icon-more-2354557.png" alt="더보기" width="48" height="48">
										<ul>
											<li onclick="commentEdit('${ list.num }','${ cmtList.refCnt }')" class="cmtEdit${ cmtList.ref }_${ cmtList.refCnt }">수정</li>
											<li onclick="deleteComment('${ list.category }','${ list.num }','${ list.uid }','${ cmtList.refCnt }','<%= linkUrl %>')">삭제</li>
										</ul>
									</c:if>
									</div>
								</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			</c:forEach>
			<!-- 게시글출력 끝 -->
			
			<div id="testarea" class="listlow">
			
			</div>
		</main>
		
	</div>
	<!-- div#wrap -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="/script/forumScript.js"></script>
</body>
</html>    