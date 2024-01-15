package com.ezen.infoRum.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ezen.infoRum.dto.ForumCommentDto;
import com.ezen.infoRum.dto.ForumDto;

@Mapper
public interface ForumDao {
	public List<ForumDto> mtdListView(String category);
	
	public List<ForumDto> mtdListViewPlus(String category, String param1, String param2);
	
	public int mtdWriterPost (Map<String,Object> map);
	
	public int mtdUpdatePost (Map<String,Object> map);
	
	public int mtdDeletePost(String deletePostNum);
	
	public List<ForumDto> mtdUserTimelineList(String uid);
	
	public List<ForumDto> mtdUserTimelineListPlus(String uid, String param1, String param2);

	public int mtdPostCnt(String uid);
	
	// 댓글관련
	public List<ForumCommentDto> mtdCommentList(String category); // 게시판별 댓글출력
	
	public List<ForumCommentDto> mtdTLCommentList(); // 타임라인용 댓글출력  
	
	public int mtdCommentCount (String ref);
	
	public int mtdWriterComment (Map<String,Object> map);
	
	public int mtdUpdateComment (Map<String,Object> map);
	
	public int mtdDeleteComment (String ref, String refCnt);
}
