package com.ezen.infoRum.svc;

import java.util.List;
import java.util.Map;

import com.ezen.infoRum.dto.ForumCommentDto;
import com.ezen.infoRum.dto.ForumDto;

public interface ForumSvc {
	public List<ForumDto> mtdListView(String category);
	
	public int mtdListViewCnt(String category);
	
	public List<ForumDto> mtdListViewPlus(int param1, int param2, String category);
	
	public int mtdWriterPost (Map<String,Object> map);
	
	public int mtdUpdatePost (Map<String,Object> map);
	
	public int mtdDeletePost(String deletePostNum);
	
	public List<ForumDto> mtdUserTimelineList(String uid);
	
	public List<ForumDto> mtdUserTimelineListPlus(int param1, int param2, String userid);

	public int mtdPostCnt(String uid);
	
	public List<ForumCommentDto> mtdCommentList(String category);
	
	public List<ForumCommentDto> mtdTLCommentList();
	
	public int mtdCommentCount (String ref);
	
	public int mtdWriterComment (Map<String,Object> map);
	
	public int mtdUpdateComment (Map<String,Object> map);
	
	public int mtdDeleteComment (String ref, String refCnt);
}
