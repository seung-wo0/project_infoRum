<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
		<span onclick="userTimelineHome('${ list.uid }')" style="cursor: pointer;">${ list.nickname }</span>
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
	<pre>${ list.content }</pre>
</div>

<form id="upContentFrm" class="upContentFrm${ list.num }" action="updatePost">
	<div id="upcontentArea" class="upcontentArea">
		<input type="hidden" id="num" name="num" value="${ list.num }">
		<input type="hidden" name="uid" value="${ list.uid }">
		<input type="hidden" name="nickname" value="${ list.nickname }">
		<input type="hidden" name="category" value="<%=category%>">
		<input type="hidden" name="image" value="">
		<textarea id="content" name="content">${ list.content } </textarea>
		<input type="hidden" name="profile" value="${ list.profile }">
		<input type="hidden" name="linkUrl" value="<%=linkUrl %>">
		
		<div id="updateBtnArea">
			<button type="submit" >수정</button>
		</div>
	</div>
</form>