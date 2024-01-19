
/**
 *  나중에 managerScript.js로 이동 예정
 */
   $(document).ready(function () {
        $('#summernote').summernote({
            codeviewFilter: false, // 코드 보기 필터 비활성화
            codeviewIframeFilter: false, // 코드 보기 iframe 필터 비활성화

            height: 500, // 에디터 높이
            minHeight: null, // 최소 높이
            maxHeight: null, // 최대 높이
            focus: true, // 에디터 로딩 후 포커스 설정
            lang: 'ko-KR', // 언어 설정 (한국어)
            

            toolbar: [
                ['style', ['style']], // 글자 스타일 설정 옵션
                ['fontsize', ['fontsize']], // 글꼴 크기 설정 옵션
                ['font', ['bold', 'underline', 'clear']], // 글자 굵게, 밑줄, 포맷 제거 옵션
                ['color', ['color']], // 글자 색상 설정 옵션
                ['table', ['table']], // 테이블 삽입 옵션
                ['para', ['ul', 'ol', 'paragraph']], // 문단 스타일, 순서 없는 목록, 순서 있는 목록 옵션
                ['height', ['height']], // 에디터 높이 조절 옵션
                ['insert', ['picture', 'link', 'video']], // 이미지 삽입, 링크 삽입, 동영상 삽입 옵션
                ['view', ['codeview', 'fullscreen', 'help']], // 코드 보기, 전체 화면, 도움말 옵션
            ],

            fontSizes: [
                '8', '9', '10', '11', '12', '14', '16', '18',
                '20', '22', '24', '28', '30', '36', '50', '72',
            ], // 글꼴 크기 옵션

            styleTags: [
                'p',  // 일반 문단 스타일 옵션
                {
                    title: 'Blockquote',
                    tag: 'blockquote',
                    className: 'blockquote',
                    value: 'blockquote',
                },  // 인용구 스타일 옵션
                'pre',  // 코드 단락 스타일 옵션
                {
                    title: 'code_light',
                    tag: 'pre',
                    className: 'code_light',
                    value: 'pre',
                },  // 밝은 코드 스타일 옵션
                {
                    title: 'code_dark',
                    tag: 'pre',
                    className: 'code_dark',
                    value: 'pre',
                },  // 어두운 코드 스타일 옵션
                'h1', 'h2', 'h3', 'h4', 'h5', 'h6',  // 제목 스타일 옵션
            ],

            callbacks: {
                onImageUpload: function (files) {
                    // 파일 업로드 (다중 업로드를 위해 반복문 사용)
                     uploadSummernoteImageFile(files[0]);
                },
            },
        })
    })

    // 이미지 업로드 함수 ajax 활용
    function uploadSummernoteImageFile(file) {
        data = new FormData()
        data.append('file', file)
        $.ajax({
            data: data,
            type: 'POST',
            url: 'image/upload',
            contentType: false,
            enctype: 'multipart/form-data',
            processData: false,
            success: function (resp) {
				
				let imgNode = $("<img>");
              	imgNode.attr("src","/image/read?fileName="+resp);
              	imgNode.attr("id","uploadImg");
              	console.log($(".note-editable")); // 선택된 요소가 있는지 콘솔에 출력
              	alert(resp);
				$(".note-editable").append(imgNode); // 이미지를 복사하여 추가
            },
        })
    }
    function boardWrite() {
		
		let data = new FormData();
		let title = $('#titleText').val();
	  	let summernote = $('#summernote').val();
	  	let uid = "dummyId2";
	  	let nickname = "dummyName2";
	  	
	  	let profile = null;
		// String uid = req.getParameter("uid");
		// String nickname = req.getParameter("nickname");
		// String profile = req.getParameter("profile");
        
        // data.append("uid",'1234');
        // data.append("nickname","1234");
       
        data.append('title', title);
        data.append("content",summernote);
        data.append("uid",uid);
        data.append("nickname",nickname);
        data.append("profile",profile);
        data.append('summernote', summernote);
        $.ajax({
            data: data,
            type: 'POST',
            url: '/inquiryWrite/data',
             contentType: false,
  			processData: false,
            success: function (data) {
              	alert("게시글을 작성했습니다");
              	location.href="./inquiry?page=1";
            },
        })
        
	  
	  
	}
	
    function boardUpdate() {
		
		let data = new FormData();
		let title = $('#titleText').val();
	  	let summernote = $('#summernote').val();
	  	let num = $("#num").val();
	  	
		// String uid = req.getParameter("uid");
		// String nickname = req.getParameter("nickname");
		// String profile = req.getParameter("profile");
        
        // data.append("uid",'1234');
        // data.append("nickname","1234");
       
        data.append('title', title);
        data.append("content",summernote);
        data.append("num",num);
        $.ajax({
            data: data,
            type: 'POST',
            url: '/inquiryUpdate/data',
             contentType: false,
  			processData: false,
            success: function (data) {
              	alert("게시글을 작성했습니다");
              	location.href="./inquiryDetail?num="+num;
            },
        })
        
	  
	  
	}
	function boardList() {
		location.href= "/inquiry";
	}