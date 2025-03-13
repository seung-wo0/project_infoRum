<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% 
String category = request.getParameter("category"); 
String linkUrl = request.getHeader("referer"); 
String uid_session = (String)session.getAttribute("uid_session");
String nickname_session = (String)session.getAttribute("nickname_session");
String profile_session = (String)session.getAttribute("profile_session");
int auth_session = 0;

if(profile_session==null){
	profile_session="nullprofile.png";
}

if(uid_session!=null){
	auth_session = (int)session.getAttribute("auth_session");
}

%>
<c:forEach var="list" items="${ list }">
<div id="rowArea" class="listrow" >
	<div id="userInfoArea" class="dFlex">
		<div id="userImgArea">
			<span class="profile">
			<c:choose>
				<c:when test="${ list.profile == '' || list.profile eq null}">
				<img src="profileImg/nullprofile.png" width="32" height="32">
				</c:when>
				<c:otherwise>
				<img src="profileImg/${ list.profile }" width="32" height="32">
				</c:otherwise>
			</c:choose>
			</span>
		</div>
		<div id="userWirterArea">
			<span onclick="userTimelineHome('${ list.uid }')" style="cursor: pointer;" >${ list.nickname }</span>
			<span><fmt:formatDate value="${ list.regTM }" pattern="MM월dd일 a hh:mm"/></span>
		</div>
		<div id="userMoreArea" class="moreIco${ list.num }" onclick="moreSelect('${ list.num }')">
		<c:set var="auth_session" value="<%=auth_session %>" />
		<c:if test="${ list.uid == uid_session || auth_session > 0 }">
			<img src="images/free-icon-more-2354557.png" alt="더보기">
			<ul>
			<c:if test="${ list.uid == uid_session }">
				<li>수정</li>
			</c:if>
			<c:if test="${ list.uid == uid_session || auth_session > 0 }">
				<li onclick="deletePost('${ list.category }','${ list.num }','${ list.uid }','<%=linkUrl%>')">삭제</li>
			</c:if>
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
			<input type="hidden" name="profile" value="<%=profile_session %>">
			<input type="hidden" name="linkUrl" value="<%=linkUrl %>">
			<div id="updateBtnArea">
				<button type="submit" >수정</button>
			</div>
		</div>
	</form>
				
	<div id="postFooterArea" class="postFooterArea${ list.num }">
		<div id="likeBtnArea">

		</div>
		<div id="commentArea">
			<div id="commentinputArea">
			
				<form id="commentFrm" class="commentFrm" action="/writerComment">
					<textarea id="comment" name="comment"></textarea>
					<img src="images/upPhoto.png" width="45" height="45">
					<input type="hidden" name="uid" value="${ uid_session }">
					<input type="hidden" name="nickname" value="${ nickname_session }">
					<input type="hidden" name="category" value="${ list.category }">
					<input type="hidden" id="ref" name="ref" value="${ list.num }">
					<input type="hidden" name="image" value="">
					<input type="hidden" name="profile" value="<%= profile_session %>">
					<input type="hidden" name="infouserid" value="${ list.uid }">
					<input type="hidden" name="linkUrl" value="<%=linkUrl %>">
					<button type="submit" id="commentSendBtn" name="commentSendBtn">등록</button>
				</form>
	
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
									<c:when test="${ cmtList.uid eq '' || cmtList.uid eq null }">
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${ cmtList.profile == '' || cmtList.profile eq null }">
											<img src="profileImg/nullprofile.png" width="32" height="32">
											</c:when>
											<c:otherwise>
											<img src="profileImg/${ cmtList.profile }" width="32" height="32">
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
								</span>
							</div>
						</div>
						<div id="comment_right" class="comment_right" >
							<div id="user_comment_nicknameArea" style="cursor: pointer;">
								<div id="nicknameArea" onclick="userTimelineHome('${ cmtList.uid }')">
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
						
						<c:if test="${ cmtList.uid == uid_session || auth_session >= 0}">
							<img src="images/free-icon-more-2354557.png" alt="더보기" width="48" height="48">
							<ul>
							<c:if test="${ cmtList.uid == uid_session}">
								<li onclick="commentEdit('${ list.num }','${ cmtList.refCnt }')" class="cmtEdit${ cmtList.ref }_${ cmtList.refCnt }">수정</li>
							</c:if>
							<c:if test="${ cmtList.uid == uid_session || auth_session > 0}">
								<li onclick="deleteComment('${ list.category }','${ list.num }','${ list.uid }','${ cmtList.refCnt }','<%= linkUrl %>')">삭제</li>
							</c:if>
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

