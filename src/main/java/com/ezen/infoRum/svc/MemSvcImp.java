package com.ezen.infoRum.svc;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ezen.infoRum.dao.MemDao;
import com.ezen.infoRum.dto.MemDto;

@Service
public class MemSvcImp implements MemSvc {
	
	@Autowired
	MemDao memDao;
	
	@Override
	public void joinProc(Map<String, Object> map) {
		memDao.joinProc(map);
	}
	
	@Override
	public int LoginProc(String uid, String upw) {
	
		return memDao.LoginProc(uid,upw);
	}
	
	@Override
	public MemDto findMemInfo(String uid) {
	
		return memDao.findMemInfo(uid);
	}
	
	@Override
	public int pwdChange(String uid, String uemail, String upw) {
		
		return memDao.pwdChange(uid,uemail,upw);
	}
	
	@Override
	public int chkID(String uid) {
		
		return memDao.chkID(uid);
	}
	
	@Override
	public void myPageProc(Map<String, Object> map) {
		memDao.myPageProc(map);
	}
	
	@Override
	public int mtdProfile(MultipartHttpServletRequest req) {
	
			MultipartFile multipartFile = req.getFile("fName");
			
			String uid = req.getParameter("uid");
			System.out.println("uid	:" + uid);
			
			String upFile = multipartFile.getOriginalFilename();
			String oriName = null;  //원본파일이름
			String sysName = null;	//시스템파일이름
			
//			Map<String, Object> map = new HashMap<String, Object>();
			List<String> list = new ArrayList<>();
			
			try {
				if (!upFile.equals("")) {
					
					String realPath = "D:\\InfoProc_20230807/jsw/Silsp/springBoot/InfoRum/src/main/resources/static/profileImg/";
					// D드라이브 경로에는 백슬래쉬 기호(\\) 및 마지막 슬래쉬(/)기호 필수
					
					File folder = new File(realPath);
					if (folder.isDirectory() == false) {
						folder.mkdirs(); // 폴더가 없을 경우 폴더 생성
					}
					
					
					oriName = multipartFile.getOriginalFilename(); // 원본 파일명 반환
					sysName = System.currentTimeMillis() + oriName.substring(oriName.lastIndexOf("."));
					// 현재 시간을 밀리세컨즈로 변환한 값과 확장자로 시스템에 업로드되는 파일명 설정       
					
					long fSize = multipartFile.getSize(); // 파일 크기 반환
					
					File file = new File(realPath + sysName); // 파일 임의 생성(upload 폴더)
					multipartFile.transferTo(file); // 전송된 파일을 임의 생성된 파일에 복사
					
//					map.put("item1", oriName);
//					map.put("item2", oriName);
//					map.put("item3", oriName);
					list.add(oriName);
					list.add(sysName);
					list.add(uid);
					System.out.println("원본파일명	:	" + oriName);
					System.out.println("업로드파일명	:	" + sysName);
					System.out.println("파일크기	:	" + fSize);
					System.out.println("저장경로	:	" + realPath);
					
					
				}
				
			} catch (Exception e) {
				System.out.println(e.getMessage());
			} // End If
			return memDao.mtdProfile(list);
	}
}
