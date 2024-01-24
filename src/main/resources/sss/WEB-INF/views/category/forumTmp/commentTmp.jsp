<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="postFooterArea" class="postFooterArea${ list.num }">
	<div id="likeBtnArea"></div>
	
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
				<input type="hidden" name="profile" value="${ profile_session }">
				<input type="hidden" name="linkUrl" value="<%=linkUrl %>">
				<button type="submit" id="commentSendBtn" name="commentSendBtn">등록</button>
			</form>
		<% } %>
		</div>

		<div id="commentListArea">
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
						<pre>${ cmtList.comment }</pre>
								
						<c:if test="${ uid_session eq cmtList.uid }">
						<form id="editCommentFrm" action="/updateComment">
							<textarea name="comment">${ cmtList.comment }</textarea>
							<input type="hidden" name="uid" value="${cmtList.uid}">
							<input type="hidden" name="ref" value="${cmtList.ref}">
							<input type="hidden" name="refCnt" value="${ cmtList.refCnt }">
							<input type="hidden" name="category" value="<%=category%>">
							<input type="hidden" name="infouserid" value="${ userInfo.uid }">
							<input type="hidden" name="linkUrl" value="<%=linkUrl %>">
							<input type="hidden" id="profile" name="profile" value="<%=profile_session %>">
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