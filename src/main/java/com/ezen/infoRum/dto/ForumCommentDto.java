package com.ezen.infoRum.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ForumCommentDto {
	private String num;
	private String uid;
	private String nickname;
	private String category;
	private String ref;
	private String refCnt;
	private String comment;
	private String image;
	private String profile;
	private Timestamp regTM;
}
