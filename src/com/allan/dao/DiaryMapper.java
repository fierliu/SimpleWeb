package com.allan.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.util.Date;

import org.apache.taglibs.standard.lang.jstl.parser.ParseException;
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
		try {
			date= DateFormat.getDateTimeInstance().parse(rs.getString("writeTime"));
//			diary.setWriteTime(rs.getDate("writeTime"));
			diary.setWriteTime(date);
		} catch (java.text.ParseException e) {
			e.printStackTrace();
		}
		diary.setContent(rs.getString("content"));
		return diary;
	}

}
