package com.allan.dao;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

import com.allan.model.Diary;

public class DiaryDao {
	private DataSource dataSource; //连接数据库的bean
	private JdbcTemplate jdbcTemplateObject; 
	
	public void setDataSource(DataSource dataSource) {
	      this.dataSource = dataSource;
	      this.jdbcTemplateObject = new JdbcTemplate(dataSource);
//	      System.out.println("初始化了");
	   }

	public String save(String sql) {
		int rtn = jdbcTemplateObject.update(sql); // 执行更新语句,返回the number of rows affected
		String result = "";
		if (rtn > 0) {
			result = "发表成功！";
		} else {
			result = "发表失败！";
		}
//			conn.close(); // 关闭数据库的连接
		return result; // 返回执行结果
	}	
	
	public List require(String sql) {
		List<Diary> diaryList = jdbcTemplateObject.query(sql, new DiaryMapper());//查询到的是多个diary对象组成的列表

		
//		for(Diary diary: diaryList) {
//			System.out.println("daodiaryTime="+diary.getWriteTime().toString());
//		}
		
		return diaryList;
	}
	
	public int delDiary(int id) {
		String sql = "DELETE FROM tb_diary WHERE id=" + id;
		int ret = 0;
		try {
			ret = jdbcTemplateObject.update(sql);// 执行更新语句
		} catch (Exception e) {
			e.printStackTrace();// 输出异常信息
		} 
		return ret;
	}
}
