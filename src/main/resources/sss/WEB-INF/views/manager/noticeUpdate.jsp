<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>


<%
String nickname_session4 = (String)session.getAttribute("nickname_session");
java.sql.Timestamp regTM = new java.sql.Timestamp(java.time.Instant.now().toEpochMilli());
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>infoRum</title>
<link href="images/logo.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="/style/noticeStyle.css?v">

</head>
<body>

<!--  헤더템플릿 시작, iframe으로 변경 -->
   <%@ include file="../inc/headerTmp.jsp"%>
   <!--  헤더템플릿 끝 -->
   
   <%
	if (auth_session == 2) {
	%>

   <div id="wrap2">
      <div id="contents" class="bbsWrite">

         <h2 class="notosanskr">글쓰기</h2>

         <form action="noticeUpdateProc" name="noticeUpdateProcFrm"
            enctype="multipart/form-data" method="post" id="noticeUpdateProcFrm">
            
            <input type="hidden" name="num" value="${update.num}">

            <table>
               <tbody>

                  <tr>
                     <td class="req notosanskr">닉네임</td>
                     <!-- td.req 필수입력 -->
                     <td><%=nickname_session4%> <input type="hidden" name="nickname"
                        value="<%=nickname_session4%>"></td>
                  </tr>
                  <tr>
                     <td class="notosanskr" style="font-weight: bold; color: #555555;">작성시간</td>

                     <td><%= regTM.toString().substring(0, 16) %><input type="hidden" name="regTM">
                  </tr>

                  <tr>
                     <td class="req notosanskr">제목</td>
                     <!-- td.req 필수입력 -->
                     <td><input type="text" name="title" maxlength="50" value="${update.title}"
                        id="stitle" required></td>
                  </tr>
                  
                  
                  <tr>
                     <td class="contentTD notosanskr" style="font-weight: bold; color: #555555;">내용</td>
                     <td><textarea class="notosanskr" name="content" id="content" cols="60" rows="20"
                           wrap="hard" required style="resize: none;">${update.content}</textarea></td>
                  </tr>


               </tbody>
               <tfoot>
                  <tr>
                     <td colspan="2" class="button">
                        <button type="submit" class="notosanskr" id="regBtn">수정</button>
                        <button type="reset" class="notosanskr">다시쓰기</button>
                        <a href="notice"><button type="button" id="listBtn" class="notosanskr">목록보기</button></a>
                     </td>
                  </tr>
               </tfoot>
            </table>
         </form>
      </div>

   </div>
   <%
	}
	%>
   <!-- div#wrap -->
   <script
      src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
   <script src="/script/script.js"></script>
</body>
</html>