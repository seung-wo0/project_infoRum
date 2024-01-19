package com.ezen.infoRum.dto;

import java.sql.Timestamp;

import lombok.Data;
@Data
public class InquiryCmtDto {
	private int num;		 
	private String uId;
	private String nickname;
	private int pos;
	private String profile;
	private String content;
	private Timestamp regTm;
	private String image;
}
// uid,nickname,title,pos,content,profile
