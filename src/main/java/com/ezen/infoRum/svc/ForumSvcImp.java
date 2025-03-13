package com.ezen.infoRum.svc;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.infoRum.dao.ForumDao;
import com.ezen.infoRum.dto.ForumCommentDto;
import com.ezen.infoRum.dto.ForumDto;

@Service
public class ForumSvcImp implements ForumSvc {
	
	@Autowired
	private ForumDao forumDao;
	
	public List<ForumDto> mtdListView(String category) {
		return forumDao.mtdListView(category);
	};
	
	@Override
	public int mtdListViewCnt(String category) {
		return forumDao.mtdListViewCnt(category);
	}
	
	@Override
	public List<ForumDto> mtdListViewPlus(int param1, int param2, String category) {
		return forumDao.mtdListViewPlus(param1, param2, category);
	}
	
	@Override
	public int mtdWriterPost(Map<String, Object> map) {
		return forumDao.mtdWriterPost(map);
	}
	
	@Override
	public int mtdUpdatePost(Map<String, Object> map) {
		return forumDao.mtdUpdatePost(map);
	}
	
	@Override
	public int mtdDeletePost(String deletePostNum) {
		return forumDao.mtdDeletePost(deletePostNum);
	}
	
	@Override
	public List<ForumDto> mtdUserTimelineList(String uid) {
		return forumDao.mtdUserTimelineList(uid);
	}
	
	@Override
	public List<ForumDto> mtdUserTimelineListPlus(int param1, int param2, String uid) {
		return forumDao.mtdUserTimelineListPlus(param1, param2, uid);
	}
	
	@Override
	public int mtdPostCnt(String uid) {
		return forumDao.mtdPostCnt(uid);
	}
	
	@Override
	public List<ForumCommentDto> mtdCommentList(String category){
		return forumDao.mtdCommentList(category);
	}
	
	@Override
	public List<ForumCommentDto> mtdTLCommentList() {
		return forumDao.mtdTLCommentList();
	}
	
	@Override
	public int mtdCommentCount(String ref) {
		return forumDao.mtdCommentCount(ref);
	}
	
	@Override
	public int mtdWriterComment(Map<String, Object> map) {
		return forumDao.mtdWriterComment(map);
	}
	
	@Override
	public int mtdUpdateComment(Map<String, Object> map) {
		return forumDao.mtdUpdateComment(map);
	}
	
	@Override
	public int mtdDeleteComment (String ref, String refCnt) {
		return forumDao.mtdDeleteComment(ref,refCnt);
	}
}
