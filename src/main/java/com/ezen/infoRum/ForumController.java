package com.ezen.infoRum;


import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ezen.infoRum.dto.ForumCommentDto;
import com.ezen.infoRum.dto.ForumDto;
import com.ezen.infoRum.dto.MemDto;
import com.ezen.infoRum.svc.ForumSvcImp;
import com.ezen.infoRum.svc.MemSvc;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class ForumController {
	
	@Autowired
	private ForumSvcImp forumSvcImp;
	
	@Autowired
	private MemSvc memSvc;
	
	// 메인페이지
	@RequestMapping("/")
	public String mtdIndex() {
		return "index";
	}
	
	// 게시판페이지
	@RequestMapping("/forum")
	public String mtdForum(
			HttpServletRequest req,
			Model model,
			@RequestParam("category") String category
//			@RequestParam("uid_session") String uid_session
			) {
//		MemDto userInfo = memSvc.findMemInfo(uid_session);
		
//		model.addAttribute("userInfo",userInfo);
		model.addAttribute("cmtList",forumSvcImp.mtdCommentList(category));
		model.addAttribute("list", forumSvcImp.mtdListView(category));
		
		return "category/"+ category +"Forum";
	}
	
	// 게시글작성
	@RequestMapping("/writerProc")
	public String mtdWriterProc(
			ForumDto forumDto,
			@RequestParam("category") String category
			) {
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("item1", forumDto.getUid());
		map.put("item2", forumDto.getNickname());
		map.put("item3", category);
		map.put("item4", forumDto.getImage());
		map.put("item5", forumDto.getContent());
		map.put("item6", forumDto.getProfile());
		
		forumSvcImp.mtdWriterPost(map);
		
		return "redirect:/forum?category="+category;
	}
	
	// 게시글 수정
	@RequestMapping("/updatePost")
	public String updatePost(
			ForumDto forumDto,
			@RequestParam("linkUrl") String linkUrl
			) {
		String category = forumDto.getCategory();
//		System.out.println("원본 url : " + linkUrl);
		Map<String, Object> map = new HashMap<>();
		map.put("item1", forumDto.getNum());
		map.put("item2", forumDto.getUid());
		map.put("item3", forumDto.getNickname());
		map.put("item4", category);
		map.put("item5", forumDto.getImage());
		map.put("item6", forumDto.getContent());
		map.put("item7", forumDto.getProfile());
		
		forumSvcImp.mtdUpdatePost(map);
		
		//게시판수정인지,타임라인 수정인지 걸러주는 작업
		if (linkUrl.contains("userTimeline")) {
//				System.out.println("타임라인 에서 수정작업 요청");
			return "redirect:/userTimeline?userid="+forumDto.getUid();
		} else {
//				System.out.println("게시판 에서 수정작업 요청");
			return "redirect:/forum?category="+category;
		}
		
	}
		
	// 포럼공통적으로쓰이는 게시글 삭제
	@RequestMapping("/deletePost")
	public String deletePost(
			@RequestParam("category") String category,
			@RequestParam("num") String deletePostNum,
			@RequestParam("userid") String userid,
			@RequestParam("linkUrl") String linkUrl
			) {
		
		forumSvcImp.mtdDeletePost(deletePostNum);
		
		//게시판,타임라인 작업 위치 구별
		if (linkUrl.contains("userTimeline")) {
//			System.out.println("타임라인 에서 게시글삭제 요청");
			return "redirect:/userTimeline?userid="+userid;
		} else {
//			System.out.println("게시판 에서 게시글삭제 요청");
			return "redirect:/forum?category="+category;
		}
	}
		
		
//		댓 글 관 련 시 작
		
	// 게시판 댓글 작성
	@RequestMapping("/writerComment")
	public String mtdWriterComment(ForumCommentDto forumCDto, HttpServletRequest req) {
		
		String category = req.getParameter("category");
		String infouserid = req.getParameter("infouserid");
		String linkUrl = req.getParameter("linkUrl");
		
		Map<String, Object> map = new HashMap<>();
		int RefCnt = forumSvcImp.mtdCommentCount(forumCDto.getRef());
		
		map.put("item1", forumCDto.getUid());
		map.put("item2", forumCDto.getNickname());
		map.put("item3", category);
		map.put("item4", forumCDto.getRef());
		map.put("item5", (RefCnt+1));
		map.put("item6", forumCDto.getComment());
		map.put("item7", forumCDto.getImage());
		map.put("item8", forumCDto.getProfile());
		
		forumSvcImp.mtdWriterComment(map);
		
		//게시판,타임라인 작업 위치 구별
		if (linkUrl.contains("userTimeline")) {
//			System.out.println("타임라인 에서 댓글작성 요청");
			return "redirect:/userTimeline?userid="+infouserid;
		} else {
//			System.out.println("게시판 에서 댓글작성 요청");
			return "redirect:/forum?category="+category;
		}

	}
		
	// 게시판 댓글 수정
	@RequestMapping("/updateComment")
	public String updateComment(
			ForumCommentDto forumCDto,
			HttpServletRequest req
			) {
		String linkUrl = req.getParameter("linkUrl");
		String infouserid = req.getParameter("infouserid");
		String category = forumCDto.getCategory();
		Map<String, Object> map = new HashMap<>();
		map.put("item1", forumCDto.getRef());
		map.put("item2", forumCDto.getRefCnt());
		map.put("item3", forumCDto.getImage());
		map.put("item4", forumCDto.getComment());
		map.put("item5", forumCDto.getProfile());
		
		forumSvcImp.mtdUpdateComment(map);
		
		//게시판,타임라인 작업 위치 구별
		if (linkUrl.contains("userTimeline")) {
//					System.out.println("타임라인 에서 댓글수정작업 요청");
			return "redirect:/userTimeline?userid="+infouserid;
		} else {
//					System.out.println("게시판 에서 수정작업 요청");
			return "redirect:/forum?category="+category;
		}

	}
	
	// 게시판 댓글 삭제
	@RequestMapping("/deleteComment")
	public String deleteComment(
			HttpServletRequest req
			) {
		String category = req.getParameter("category");
		String ref = req.getParameter("ref");
		String uid = req.getParameter("uid");
		String refCnt = req.getParameter("refCnt");
		String linkUrl = req.getParameter("linkUrl");
		
		forumSvcImp.mtdDeleteComment(ref,refCnt);
		
		//게시판,타임라인 작업 위치 구별
		if (linkUrl.contains("userTimeline")) {
//					System.out.println("타임라인 에서 댓글삭제작업 요청");
			return "redirect:/userTimeline?userid="+uid;
		} else {
//					System.out.println("게시판 에서 삭제작업 요청");
			return "redirect:/forum?category="+category;
		}
	}
		
//		댓 글 관 련 끝
		
		
	// 유저 타임라인 무한 스크롤 비동기 식 리스트 
	@RequestMapping("/userTimeline")
	public String userTimeline(Model model,
			@RequestParam("userid") String userid
			) {
		MemDto userInfo = memSvc.findMemInfo(userid);
		
		model.addAttribute("userInfo",userInfo);
		model.addAttribute("list", forumSvcImp.mtdUserTimelineList(userid)); // 게시글리스트
		model.addAttribute("cmtList", forumSvcImp.mtdTLCommentList()); // 게시글 코멘트리스트
		model.addAttribute("postCnt", forumSvcImp.mtdPostCnt(userid)); //해당유저의 총게시물
		
		return "category/userTimeline";
	}
		
	// 게시판 무한 스크롤 비동기 식 리스트 
	@RequestMapping("/list")
	public String list(
			Model model , 
			@RequestParam("param1") String param1,
			@RequestParam("param2") String param2,
			@RequestParam("category") String category,
			@RequestParam("userid") String userid
			) {

		if (! category.equals("")) {
			model.addAttribute("cmtList",forumSvcImp.mtdCommentList(category));
			model.addAttribute("list", forumSvcImp.mtdListViewPlus(param1, param2, category));
		} else if (! userid.equals("")){
			model.addAttribute("list", forumSvcImp.mtdUserTimelineListPlus(param1, param2, userid));
			model.addAttribute("cmtList", forumSvcImp.mtdTLCommentList());
		}
		return "category/list";
	}
	
	
}