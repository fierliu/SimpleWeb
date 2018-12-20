package com.allan.dao;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

public class PageDao {
	@SuppressWarnings("unused")
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
			result = "success！";
		} else {
			result = "fail！";
		}
//			conn.close(); // 关闭数据库的连接
		return result; // 返回执行结果
	}	
	
	public Integer require(String sql) {
		Integer count = jdbcTemplateObject.queryForObject(sql, java.lang.Integer.class);
		return count;
	}
}
