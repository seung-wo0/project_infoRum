package com.ezen.infoRum.svc;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.infoRum.dao.ManagerDao;
import com.ezen.infoRum.dto.InquiryCmtDto;
import com.ezen.infoRum.dto.InquiryDto;
import com.ezen.infoRum.dto.MemDto;
import com.ezen.infoRum.dto.NoticeDto;

@Service
public class ManagerSvcImp implements ManagerSvc {
	
	@Autowired
	ManagerDao managerDao;
	

// 재성이 파트
	@Override
	public void noticeWriteProc(Map<String, Object> map) {
		managerDao.noticeWriteProc(map);
	}
	@Override
	public List<NoticeDto> mtdList(int index_no) {
		return managerDao.mtdList(index_no);

	}

	@Override
	public NoticeDto mtdNoticeDetail(String num) {
		return managerDao.mtdNoticeDetail(num);
	}

	@Override
	public void mtdNoticeDelete(int num) {
		managerDao.mtdNoticeDelete(num);
	}
	
	@Override
	public void mtdNoticeUpdateProc(Map<String, Object> updateData) {
		managerDao.mtdNoticeUpdateProc(updateData);
	}
	
	@Override
	public NoticeDto mtdNoticeUpdate(String num) {
		return managerDao.mtdNoticeUpdate(num);
	}
	
	@Override
	public int totalChk() {
		return managerDao.totalChk();
	}


//	재광이 파트
	
	public InquiryDto mtdInquiry(int reply) {
		return managerDao.mtdInquiry(reply);
	}
	public int getInquiryCount() {
		return managerDao.getInquiryCount();
	}
	@Override
	public List<InquiryDto> mtdListView(int page) {
		return managerDao.mtdListInquiry((page-1)*5);
	}
	
	public void inquiryWriteProc(Map<String, Object> map) {
		managerDao.inquiryWriteProc(map);
	}
	public List<InquiryCmtDto> mtdInquiryComment(int num) {
		return managerDao.mtdInquiryComment(num);
	}
	public int getInquiryMax() {
		return managerDao.getInquiryMax(); 
	}
	public void inquiryUpdateReadCnt(int param1) {
		managerDao.inquiryUpdateReadCnt(param1);
	}
	
	@Override
	public void inquiryUpdateComment(String content, String image,int num) {
		managerDao.inquiryUpdateComment(content, image, num);
	}
	public void inquiryUpdateProc(Map<String, Object> map) {
		managerDao.inquiryUpdateProc(map);
	}
	
	public void inquiryCommentWriteProc(Map<String, Object> map) {
		System.out.println("확인: "+map);
		managerDao.inquiryCommentWriteProc(map);
	}
	public void mtdInquiryDel(int num) {
		managerDao.mtdInquiryDel(num);
	}
	public void mtdInquiryCommentDel(int commentNum) {
		managerDao.mtdInquiryCommentDel(commentNum);
	}

	// 준성이 파트
	@Override
	public List<MemDto> mtdManagerList() {
		return managerDao.mtdManagerList();
	}
	@Override
	public void updateUserAuthority(String userId, int newAuthority) {
	managerDao.updateUserAuthority(userId, newAuthority);
    }
	
	@Override
	public int deleteUser(String del_uid) {
		return managerDao.deleteUser(del_uid);
	}

}
