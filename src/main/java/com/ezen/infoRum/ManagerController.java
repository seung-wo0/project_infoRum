package com.ezen.infoRum;


import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ezen.infoRum.dto.InquiryCmtDto;
import com.ezen.infoRum.dto.InquiryDto;
import com.ezen.infoRum.svc.ManagerSvc;
import com.ezen.infoRum.svc.MemSvc;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class ManagerController {

	@Autowired
	MemSvc memSvc;
	@Autowired
	ManagerSvc managerSvc;

	// 공지사항 리스트 페이지
	@RequestMapping("/notice")
	public String mtdNotice(HttpServletRequest req, Model model){
		int chk = managerSvc.totalChk();
		int lastpage = (int) Math.ceil(chk / 10.0);
		model.addAttribute("lastpage", lastpage);
		
		String pageNumber = req.getParameter("pageNumber");
		if(pageNumber == null){
			pageNumber = "1";
		}
		int vpage = Integer.parseInt(pageNumber);

		int index_no = (vpage-1)*10;
		
		model.addAttribute("list", managerSvc.mtdList(index_no));
		
		
		return "/manager/notice";
	}

	// 공지사항 글 페이지(재성이꺼 추가)
	@RequestMapping("/noticeDetail")
	public String mtdNoticeDetail(HttpServletRequest req, Model model) {
		String num = req.getParameter("num");

		System.out.println(num);

		model.addAttribute("detail", managerSvc.mtdNoticeDetail(num));
//		System.out.println(managerSvc.mtdNoticeDetail(num));

		return "/manager/noticeDetail";

	}

	
	// 공지사항 글 삭제 (재성이꺼 추가)
	@RequestMapping("/noticeDelete")
	public String mtdNoticeDelete(HttpServletRequest req, Model model) {

		String num = req.getParameter("num");

		System.out.println(num);

		managerSvc.mtdNoticeDelete(Integer.parseInt(num));

		return "redirect:/notice";

	}

	// 공지사항 글쓰기 페이지
	@RequestMapping("/noticeWrite")
	public String mtdNoticeWrite() {
		return "manager/noticeWrite";
	}

	// 공지사항 글쓰기 처리

	@RequestMapping("/noticeWriteProc")
	public String mtdNoticeWriteProc(MultipartHttpServletRequest mreq, HttpServletRequest req) {

		// 파일 업로드 가능하지만 view에서 출력하는 구조상 문제 때문에 작업 중단
//		MultipartFile multipartFile = mreq.getFile("fileUpload");
//		String upFile = multipartFile.getOriginalFilename();
//		
//		try {
//			if(!upFile.equals("")) {
//				String oriName = null;
//				String sysName = null;
//				
//				String realPath = "C:\\Users/EZEN201/git/infoRum/InfoRum/src/main/resources/static/upload/";
//			
//		
//			
//			oriName = multipartFile.getOriginalFilename();
//			sysName = System.currentTimeMillis() + oriName.substring(oriName.lastIndexOf("."));
//			
//	
//			
//			File file = new File(realPath + sysName);
//			
//			multipartFile.transferTo(file);
//			}
//		} catch (Exception e) {
//			System.out.println(e.getMessage());
//		}
		
		String title = req.getParameter("title");
		String content = req.getParameter("content");

//		System.out.println(title);
//		System.out.println(content);

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("item1", title);
		map.put("item2", content);
		System.out.println();
		managerSvc.noticeWriteProc(map);
	

		return "redirect:/notice";
	}
	
	
	// 공지사항 글 수정 페이지
		@RequestMapping("/noticeUpdate")
		public String mtdNoticeUpdate(HttpServletRequest req, Model model) {
			String num = req.getParameter("num");
			model.addAttribute("update", managerSvc.mtdNoticeUpdate(num));
//			System.out.println(managerSvc.mtdNoticeUpdate(num));
			return "manager/noticeUpdate";
		}
		
		// 공지사항 글 수정 작업
		@RequestMapping("/noticeUpdateProc")
		public String mtdNoticeUpdateProc(HttpServletRequest req) {
			String num = req.getParameter("num");
			String title = req.getParameter("title");
			String content = req.getParameter("content");
			
			System.out.println(num);
			System.out.println(title);
			System.out.println(content);
			
			Map<String, Object> updateData = new HashMap<>();
			updateData.put("num", num);
			updateData.put("title", title);
			updateData.put("content", content);
			managerSvc.mtdNoticeUpdateProc(updateData);
			
			return "redirect:/noticeDetail?num=" + num;
			
		}


	// 1대1 문의 글쓰기 페이지(재광이 파트)// 공지사항 글쓰기 페이지
		@RequestMapping("/inquiry")
		public String mtdInquiry(Model model,HttpServletRequest req) {
			
			int page = 1;
			if(req.getParameter("page") != null) {
				 page = Integer.parseInt(req.getParameter("page"));
			}
			int count = managerSvc.getInquiryCount();
			int allPage = count / 5;
			int namujiPage = count % 5;
			if(namujiPage!=0) {
				allPage = allPage + 1;
			}
			int startPage = 0;
			if(page%5!=0) {
				startPage = ((page / 5)*5) +1;
			} else {
				startPage = page-4;
			}
			model.addAttribute("list", managerSvc.mtdListView(page));
			model.addAttribute("page", page);
			model.addAttribute("startPage", startPage);
			model.addAttribute("allPage", allPage);
			return "manager/inquiry";
		}
		@RequestMapping("/inquiryDelete")
		public String mtdInquiryDel(Model model,HttpServletRequest req) {
			int num = Integer.parseInt(req.getParameter("num"));
			managerSvc.mtdInquiryDel(num);
			System.out.println("???bug");
			return "redirect:/inquiry";
		}
		@RequestMapping("/inquiryWrite")
		public String mtdInquiryWrite(Model model,HttpServletRequest req) {
			
			return "manager/inquiryWrite";
		}
		@RequestMapping("/inquiryWrite/pos")
		@ResponseBody
		public int getPos() {
			return managerSvc.getInquiryMax();
		}
		@RequestMapping("/image/upload")
		@ResponseBody
		public String mtdUploadImage(MultipartHttpServletRequest req) {
			MultipartFile multipartFile = req.getFile("file");
			String upFile = multipartFile.getOriginalFilename();
			
			try {
	               if(!upFile.equals("")) {
	                 String oriName = null;
	                 String sysName = null;
	                 String realPath = "D:\\SeungWoo/Silsp/springBoot/InfoRum/src/main/resources/static/uploadDir/";
	                 // D드라이브 경로에는 백슬래쉬 기호(\\) 및 마지막 슬래쉬(/)기호 필수
	                 File folder = new File(realPath); 
	                 if(folder.isDirectory() == false) {
	                	 	folder.mkdirs(); //폴더가 없을 경우 폴더 생성 
	                	 }
	                	 oriName = multipartFile.getOriginalFilename(); // 원본 파일명 반환
	                	 sysName = System.currentTimeMillis() + oriName.substring(oriName.lastIndexOf("."));
	                	 long fSize = multipartFile.getSize(); // 파일 크기 반환
	                	 File file = new File(realPath + sysName); // 파일 임의 생성(upload 폴더) multipartFile.transferTo(file); // 전송된 파일을 임의 생성된 파일에 복사
	                	 multipartFile.transferTo(file);
	                	 System.out.println("원본파일명 : " + oriName); 
	                	 System.out.println("업로드파일명 : " + sysName); 
	                	 System.out.println("파일크기 : " + fSize); 
	                	 System.out.println("저장경로 : " + realPath);
	                	 return sysName; 	 
	               }
	               	   
			} catch (Exception e){
				System.out.println(e.getMessage());
			} // End If
			return null;
		}

		@RequestMapping("/image/read")
		@ResponseBody
		public ResponseEntity<byte[]> getFile(HttpServletRequest request){
			String fileName = request.getParameter("fileName");
			System.out.println(fileName);
			String realPath = "D:\\SeungWoo/Silsp/springBoot/InfoRum/src/main/resources/static/uploadDir/";
		    File file=new File(realPath,fileName);
		    ResponseEntity<byte[]> result=null;
		    try {
		        HttpHeaders headers=new HttpHeaders();
		        headers.add("Content-Type", Files.probeContentType(file.toPath()));
		        result=new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),headers,HttpStatus.OK );
		    }catch (IOException e) {
		        e.printStackTrace();
		    }
		    return result;
		}

		@RequestMapping("/inquiryWrite/data")
		@ResponseBody
		public void mtdInquiryWriteData(Model model,HttpServletRequest req) {
			Map<String, Object> map = new HashMap<String, Object>();
			String uid = req.getParameter("uid");
			String nickname = req.getParameter("nickname");
			String title = req.getParameter("title");
			String content = req.getParameter("content");
			String profile = req.getParameter("profile");
			map.put("item1", uid);
			map.put("item2", nickname);
			map.put("item3", title);
			map.put("item4", content);
			map.put("item5", profile);			
			managerSvc.inquiryWriteProc(map);
		}
		
		@RequestMapping("/inquiryDetail")
		public String mtdInquiryDetail(Model model,HttpServletRequest req) {
			int num;
			if(req.getParameter("num")==null) {
				num = 1;
			}
			else {
				num = Integer.parseInt(req.getParameter("num"));	
			}
			
			managerSvc.inquiryUpdateReadCnt(num);
			InquiryDto inquiryDto = managerSvc.mtdInquiry(num);
			List<InquiryCmtDto> inquiryCmtDtos = managerSvc.mtdInquiryComment(num);
			System.out.println(inquiryDto.getTitle());
			model.addAttribute("num",num);
			model.addAttribute("inquiry", inquiryDto);
			model.addAttribute("inquiryDetail",inquiryCmtDtos);
			int prevPage = num - 1;
			int nextPage = num + 1;
			model.addAttribute("prevPage",prevPage);
			model.addAttribute("nextPage",nextPage);
			System.out.println("size "+inquiryCmtDtos.size());
			return "manager/inquiryDetail";
		}

		@RequestMapping("/inquiryCommentWriteProc")
		public String mtdInquiryWriteProc(Model model,HttpServletRequest req) {
			Map<String, Object> map = new HashMap<String, Object>();
			String uId = req.getParameter("uid");
			System.out.println("uId"+uId);
			String nickname = req.getParameter("nickname");
			System.out.println("nickname"+nickname);
			String pos = req.getParameter("pos");
			System.out.println("pos"+pos);
			String content = req.getParameter("content");
			System.out.println("content"+content);
			String profile = req.getParameter("profile");
			System.out.println("profile"+profile);
			String image = req.getParameter("uploadSelector");
			System.out.println("image"+image);
			
			map.put("uid",uId);
			map.put("nickname",nickname);
			map.put("pos",pos);
			map.put("content",content);
			map.put("profile",profile);
			map.put("image",image);
			
			managerSvc.inquiryCommentWriteProc(map);
			
			return "redirect:/inquiryDetail?num="+pos;
		}
		@RequestMapping("/inquiryCommentDelete")
		public String mtdInquiryCommentDel(Model model,HttpServletRequest req) {
			int num = Integer.parseInt(req.getParameter("num"));
			int commentNum = Integer.parseInt(req.getParameter("commentNum"));
			managerSvc.mtdInquiryCommentDel(commentNum);
			System.out.println("???bug");
			return "redirect:/inquiryDetail?num="+num;
		}
		@RequestMapping("/inquiryCommentUpdate")
		public String mtdInquiryUpdate(Model model,HttpServletRequest req) {
			int num = Integer.parseInt(req.getParameter("num"));
			int commentNum = Integer.parseInt(req.getParameter("commentNum"));
			managerSvc.inquiryUpdateReadCnt(num);
			InquiryDto inquiryDto = managerSvc.mtdInquiry(num);
			List<InquiryCmtDto> inquiryCmtDtos = managerSvc.mtdInquiryComment(num);
			System.out.println(inquiryDto.getTitle());
			model.addAttribute("num",num);
			model.addAttribute("commentNum", commentNum);
			model.addAttribute("inquiry", inquiryDto);
			model.addAttribute("inquiryDetail",inquiryCmtDtos);
			int prevPage = num - 1;
			int nextPage = num + 1;
			model.addAttribute("prevPage",prevPage);
			model.addAttribute("nextPage",nextPage);
			System.out.println("size "+inquiryCmtDtos.size());
			return "manager/inquiryCommentUpdate";
		}

		@RequestMapping("/inquiryUpdate")
		public String mtdinquiryUpdate(Model model,HttpServletRequest req) {
			int num = Integer.parseInt(req.getParameter("num"));
			InquiryDto inquiryDto = managerSvc.mtdInquiry(num);
			model.addAttribute("num",num);
			model.addAttribute("inquiry", inquiryDto);
			
			return "manager/inquiryUpdate";
		}
		
		@RequestMapping("/inquiryUpdate/data")
		@ResponseBody
		public void mtdInquiryinquiryUpdateData(Model model,HttpServletRequest req) {
			Map<String, Object> map = new HashMap<String, Object>();
			String title = req.getParameter("title");
			String content = req.getParameter("content");
			String num = req.getParameter("num");
			model.addAttribute("num",num);
			map.put("item1", title);
			map.put("item2", content);
			map.put("item3", num);
			managerSvc.inquiryUpdateProc(map);
		}
	
		@RequestMapping("/data")
		public String mtdInquiryData(MultipartHttpServletRequest req,Model model) {
			MultipartFile multipartFile = req.getFile("uploadSelector");
			
			String content = req.getParameter("content");
			int num = Integer.parseInt(req.getParameter("num"));
			int commentNum = Integer.parseInt(req.getParameter("commentNum"));
			String upFile = multipartFile.getOriginalFilename();
			
			try {
	               if(!upFile.equals("")) {
	                 String oriName = null;
	                 String sysName = null;
	                 String realPath = "D:\\SeungWoo/Silsp/springBoot/InfoRum/src/main/resources/static/uploadDir/";
	                 // D드라이브 경로에는 백슬래쉬 기호(\\) 및 마지막 슬래쉬(/)기호 필수
	                 File folder = new File(realPath); 
	                 if(folder.isDirectory() == false) {
	                	 	folder.mkdirs(); //폴더가 없을 경우 폴더 생성 
	                	 }
	                	 oriName = multipartFile.getOriginalFilename(); // 원본 파일명 반환
	                	 sysName = System.currentTimeMillis() + oriName.substring(oriName.lastIndexOf("."));
	                	 long fSize = multipartFile.getSize(); // 파일 크기 반환
	                	 File file = new File(realPath + sysName); // 파일 임의 생성(upload 폴더) multipartFile.transferTo(file); // 전송된 파일을 임의 생성된 파일에 복사
	                	 multipartFile.transferTo(file);
	
	                	 managerSvc.inquiryUpdateComment(content, "./uploadDir/"+sysName,commentNum);
	                	 
	                	 System.out.println("원본파일명 : " + oriName); 
	                	 System.out.println("업로드파일명 : " + sysName); 
	                	 System.out.println("파일크기 : " + fSize); 
	                	 System.out.println("저장경로 : " + realPath);
	                	 
	               } else {
	            	   managerSvc.inquiryUpdateComment(content, null,commentNum);
	               }
	   
			} catch (Exception e){
				System.out.println(e.getMessage());
			} // End If
			System.out.println("????");
			return "redirect:/inquiryDetail?num="+num;
		}


// 관리자 권한 및 회원관리 파트(준성이 파트)
		@RequestMapping("/manager")
		public String mtdManager(Model model) {
			model.addAttribute("userList", managerSvc.mtdManagerList());
			return "manager/manager";
		}
		
		@RequestMapping("/updateAuthority")
		public String updateAuthority(HttpServletRequest req, Model model) {
	        String userId = req.getParameter("userId");
	        int newAuthority = Integer.parseInt(req.getParameter("newAuthority"));
	        managerSvc.updateUserAuthority(userId, newAuthority);
	        return "redirect:/manager";
	    }

		//회원 강제탈퇴 추가
		@RequestMapping("/deleteUser") 
		public String deleteUser(@RequestParam("del_uid") String del_uid) {
			managerSvc.deleteUser(del_uid);
			return "redirect:/manager";
		}
		
}