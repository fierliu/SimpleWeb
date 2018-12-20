package com.allan.model;

import java.util.Date;

public class Diary {
	private int id = 0;// 日记ID号
	private String title = "";// 日记标题
	private int uid = 0;// 用户ID
	private Date writeTime = null;// 写日记的时间
	private String username = "";// 用户名
	private String content="";

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getWriteTime() {
		return writeTime;
	}

	public void setWriteTime(Date writeTime) {
		this.writeTime = writeTime;
	}

	public int getUserid() {
		return uid;
	}

	public void setUserid(int userid) {
		this.uid = userid;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
//	public String toString() {
//		return"Diary[id="+id+"title="+title+"uid="+uid+"writeTime="+writeTime+"username="+username+"]";
//	}
}
