package com.allan.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;

import com.allan.model.Diary;

public class DiaryMapper implements RowMapper<Diary>{

	@Override
	public Diary mapRow(ResultSet rs, int rowNum) throws SQLException {
		Diary diary = new Diary();
		diary.setId(rs.getInt("id"));
		diary.setTitle(rs.getString("title"));
		diary.setUserid(rs.getInt("uid"));
		diary.setUsername(rs.getString("username"));
		Date date;		
		date= rs.getTimestamp("writeTime");
		diary.setWriteTime(date);
//			diary.setWriteTime((rs.getDate("writeTime")).toString());
		diary.setContent(rs.getString("content"));
		return diary;
	}

}
