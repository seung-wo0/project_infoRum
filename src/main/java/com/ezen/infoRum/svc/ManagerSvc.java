package com.ezen.infoRum.svc;

import java.util.List;
import java.util.Map;

import com.ezen.infoRum.dto.InquiryCmtDto;
import com.ezen.infoRum.dto.InquiryDto;
import com.ezen.infoRum.dto.MemDto;
import com.ezen.infoRum.dto.NoticeDto;



public interface ManagerSvc {
//	재광이 파트
	public List<InquiryDto> mtdListView(int page);
	public InquiryDto mtdInquiry(int reply);
	public int getInquiryCount();
	public int getInquiryMax();
	public void inquiryWriteProc(Map<String, Object> map);
	public void inquiryUpdateReadCnt(int param1);
	public List<InquiryCmtDto> mtdInquiryComment(int num);
	public void inquiryUpdateComment(String content, String image,int num);
	public void mtdInquiryDel(int num);
	public void mtdInquiryCommentDel(int commentNum);
	public void inquiryUpdateProc(Map<String, Object> map);
	public void inquiryCommentWriteProc(Map<String, Object> map);
//	재성이 파트
	public void noticeWriteProc(Map<String, Object> map);
	public List<NoticeDto> mtdList(int index_no);
	public NoticeDto mtdNoticeDetail(String num);
	public void mtdNoticeDelete(int num);
	public NoticeDto mtdNoticeUpdate(String num);
	void mtdNoticeUpdateProc(Map<String, Object> updataData);
	int totalChk();

//  준성이 파트
	public List<MemDto> mtdManagerList();
	public void updateUserAuthority(String userId, int newAuthority);
	public int deleteUser(String del_uid);

}
