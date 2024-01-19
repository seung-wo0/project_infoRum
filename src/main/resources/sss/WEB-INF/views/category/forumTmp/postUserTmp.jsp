<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="writeArea">
	<form id="writeFrm">
		<div id="writeInfo" class="dFlex">
			<div id="userProfile">
				<span class="profile">
					<img src="profileImg/<%=profile_session %>" alt="">
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
			<input type="hidden" id="profile" name="profile" value="<%=profile_session %>">
			<textarea id="content" name="content" placeholder="무슨말을 전달하고 싶으세요 ?"></textarea>
		</div>
		<div id="writeBtnArea" class="dFlex">
			<button type="button" id="uploadImg">사진</button>
			<button type="button" id="writeBtn">게시</button>
		</div>
	</form>
</div>