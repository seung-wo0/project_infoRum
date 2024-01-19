
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="./style/inquiryStyle.css">
<title>Insert title here</title>
</head>
<body>
    <div id="wrap">
        <div id="headerDetail">
            <span class="notosanskr">1:1 문의 게시판</span>
        </div>
        <div id="imgContainer">
            <img src="./images/prev.png" alt="" id="a" class="noticeImg" onclick="location.href='./inquiryDetail?num=${prevPage}'">
            <img src="./images/next.png" alt="" id="b" class="noticeImg" onclick="location.href='./inquiryDetail?num=${nextPage}'">
            <img src="./images/list.png" alt="" id="c" class="noticeImg" onclick="location.href='./inquiry?page=1'">
        </div>
        <div id="board">
            <div id="titleDetail">${inquiry.title}</div>
            <div id="boardHeader">
                <div id="circle"> <img id="profile" src="./images/profile.png"></div>
                <div id="container">
                        <div id="username">${inquiry.nickname}</div>
                    <div  id="text">
                        <div class="text">
                        	<fmt:formatDate value="${inquiry.regTm}" pattern="yyyy-MM-dd HH:mm:ss" />
                        </div>
                        <div class="text">조회</div>
                        <div class="text">${inquiry.readCnt}</div>
                    </div>
                </div>
                <div id="setting">
                    <img id="setting0" class="text" src="./images/comment.png">
                    <div id="setting1">댓글</div>
                    <span id="setting2">${inquiryDetail.size()}</span>
                    <img id="setting3" src="./images/setting.png" onmouseover="showBoard()" onmouseout="hiddenBoard()">
                </div>
            </div>
            <div id="boardAdditional"  onmouseover="showBoard()" onmouseout="hiddenBoard()" >
					<div class="editButton" id="editBtn0" onclick="editBoard(${num})" >수정</div>
					<div class="deleteButton" id="deleteBtn0" onclick="deleteBoard(${num})">삭제</div>
			</div>
            <div id="textArea">                
                <pre id="textContent" >
                    ${inquiry.content}
                </pre>
            </div>
            <img id="comment" src="./images/commentChat.png">
            <div id="commentText0">댓글</div>
            <div id="commentText1">${inquiryDetail.size()}</div>
            <div id="boardBottom">
                <div id="commentNotice">댓글</div>
                  <c:if test="${inquiryDetail.size() ne 0}"> 
					
	                	<c:forEach var="item" items="${inquiryDetail}" varStatus="status">
		                	<c:choose>       	
			                	<c:when test="${status.count == commentNum}">
				                	<div class="commentDiv">
				                		<div class="updateCommentBorder">
						                    <div id="commentUserName">${item.nickname}</div>
						                    <textarea id="commentUpdateText" placeholder="댓글을 남겨보세요">${item.content}</textarea>
						                    <div id="commentSubmitArea">
											 	 <form method="post" enctype="multipart/form-data" action="./data">
										            <input type="file" name="uploadSelector" id="uploadSelector0" accept="image/*" >
										            <c:if test="${item.image eq null}"> 
												        <div class="imageSection0" >
												            <img class="uploadedImage0" height="350px" src="./images/camera.png" />
												            <img type="button" class="imageRemover0" src="./images/exit.png" >
												        </div>
											        </c:if>
										            <c:if test="${item.image ne null}"> 
												        <div class="imageSection0" style="display:block">
												            <img class="uploadedImage0" height="350px" src="${item.image }" />
												            <img type="button" class="imageRemover0" src="./images/exit.png" style="display:inline-block">
												        </div>
											        </c:if>
											        <label id="camera0" for="uploadSelector0">
										                <img id="camera" src="./images/camera.png">
										            </label>
											        <input type="hidden" name="content" id="updatedTextcontent">
											        <input type="hidden" name="num" value="${num}">
											        <input type="hidden" name="commentNum" value="${item.num}">
											        <button type= "submit" onclick="submitComment0()" id="uploadData"> 등록 </button>
											        <input type="submit" id="updateSubmit" >
											    </form>
						                    </div>
					                    </div>
					                </div>
			                    </c:when>
			                    <c:otherwise> 
			                    	<div id="parentCommentArea">
					                    <div id="circle2"> 
					                        <img id="profile2" src="./images/profile.png">
					                    </div>
					                    <div id="parentCommentNickname">${item.nickname}</div>
					                    <img class="parentCommentTool" id="parentCommentTool${status.count}" onmouseover="showData(${status.count})" onmouseout="hiddenData(${status.count})" src="./images/commentSetting.png">
										<div class="additional" id="additional${status.count }"  onmouseover="showData(${status.count})" >
											<div class="editButton" id="editBtn${status.count}" onclick="editComment(${num},${status.count})" >수정</div>
											<div class="deleteButton" id="deleteBtn${status.count}" onclick="deleteComment(${num},${item.num})">삭제</div>
										</div>	
					                    <pre id="parentCommentContent">${item.content}</pre>
					                    <c:if test="${item.image ne null}">
					                    	<img id="parnetCommentImg" src="${item.image}">
					                    </c:if> 
					                    <div id="parentCommentDate">
					                    	<fmt:formatDate value="${item.regTm}" pattern="yyyy-MM-dd HH:mm:ss" />
					                    </div>
					                    <div id="parentCommentEnd"></div>
				                	</div>
								</c:otherwise> 
			                </c:choose>  
		                    
	                    </c:forEach>
	                
				</c:if>
                    
                <div id="commentArea">
                    <div id="commentUserName">윤준성</div>
                    <textarea id="commentText" placeholder="댓글을 남겨보세요"></textarea>
                    <div id="commentSubmitArea">
					 	 <form method="post" enctype="multipart/form-data" action="./inquiryCommentWriteProc">
				            <input type="file" name="uploadSelector" id="uploadSelector1" accept="image/*" >
					        <div class="imageSection1" >
					            <img class="uploadedImage1" height="350px" src="./images/camera.png" />
					            <img type="button" class="imageRemover1" src="./images/exit.png">
					        </div>
					        <label id="camera1" for="uploadSelector1">
				                <img id="camera" src="./images/camera.png">
				            </label>
				            <input type="hidden" name="uid" value="1234">
				            <input type="hidden" name="nickname" value="1234">
				            <input type="hidden" name="profile" value="null">
				            <input type="hidden"  name="content" id="writedTextcontent">
				            <input type="hidden" name="pos" value="${num}">
				            <button type= "submit" onclick="submitComment1()" id="uploadData2"> 등록 </button>
				            <input type="submit" id="commentSubmit" >
					    </form>
                    </div>
                </div>
            </div>

        </div>
    </div>
</body>

<script>
	function showData(num) {
		document.getElementById("additional"+num).style.display="block";
	}
	function hiddenData(num) {
		document.getElementById("additional"+num).style.display="none";
	}
	function showBoard() {
		document.getElementById("boardAdditional").style.display="block";
	}
	function hiddenBoard() {
		document.getElementById("boardAdditional").style.display="none";
	}
    // 이미지 미리보기 및 삭제
    document.getElementById('uploadSelector0').addEventListener('change', function(e) {
        const file = e.target.files[0];
        const imgPreview = document.querySelector('.uploadedImage0');
        const imgSection = document.querySelector('.imageSection0');
        const imgRemoveBtn = document.querySelector('.imageRemover0');
		const camera = document.querySelector('#camera0');
        if (file) {
            imgPreview.src = URL.createObjectURL(file);
            imgSection.style.display = 'block';
            imgRemoveBtn.style.display = 'inline-block';
            camera.style.marginLeft = "-4px";
        }
    });

    // 이미지 삭제 버튼 클릭 시
    document.querySelector('.imageRemover0').addEventListener('click', function() {
        const fileInput = document.getElementById('uploadSelector0');
        fileInput.value = '';
        const imgPreview = document.querySelector('.uploadedImage0');
        const imgSection = document.querySelector('.imageSection0');
        const imgRemoveBtn = document.querySelector('.imageRemover0');
        const camera = document.querySelector('#camera0');
        imgPreview.src = '';
        imgSection.style.display = 'none';
        imgRemoveBtn.style.display = 'none';
        camera.style.marginLeft = "-6px";
    });
    document.getElementById('uploadSelector1').addEventListener('change', function(e) {
        const file = e.target.files[0];
        const imgPreview = document.querySelector('.uploadedImage1');
        const imgSection = document.querySelector('.imageSection1');
        const imgRemoveBtn = document.querySelector('.imageRemover1');
		const camera = document.querySelector('#camera1');
        if (file) {
            imgPreview.src = URL.createObjectURL(file);
            imgSection.style.display = 'block';
            imgRemoveBtn.style.display = 'inline-block';
            camera.style.marginLeft = "-4px";
        }
    });

    // 이미지 삭제 버튼 클릭 시
    document.querySelector('.imageRemover1').addEventListener('click', function() {
        const fileInput = document.getElementById('uploadSelector1');
        fileInput.value = '';
        const imgPreview = document.querySelector('.uploadedImage1');
        const imgSection = document.querySelector('.imageSection1');
        const imgRemoveBtn = document.querySelector('.imageRemover1');
        const camera = document.querySelector('#camera1');
        imgPreview.src = '';
        imgSection.style.display = 'none';
        imgRemoveBtn.style.display = 'none';
        camera.style.marginLeft = "-6px";
    });
    function x() {
    	let text = document.getElementById("commentText").value;
    	alert(text);
    }
    function submitComment0() {
    	let value = document.getElementById("commentUpdateText").value;
    	document.getElementById("updatedTextcontent").value = value;	
    }
    function submitComment1() {
    	
    	let value = document.getElementById("commentText").value;
    	document.getElementById("writedTextcontent").value = value;	
    	
    }


    
    function editComment(num, commentNum) {
    	location.href ="/inquiryCommentUpdate?num="+num+"&commentNum="+commentNum;
    }
    function deleteComment(num, commentNum) {
    	location.href ="/inquiryCommentDelete?num="+num+"&commentNum="+commentNum;
    }
    function editBoard(num) {
    	location.href ="/inquiryUpdate?num="+num;
    }
    function deleteBoard(num) {
    	location.href ="/inquiryDelete?num="+num;
    }
    
    
	
</script>
</html>