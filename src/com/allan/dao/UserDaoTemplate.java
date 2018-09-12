package com.allan.dao;
import java.util.List;

import javax.sql.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import com.allan.model.User;

public class UserDaoTemplate implements UserDao {
	private DataSource dataSource; //连接数据库的bean
	private JdbcTemplate jdbcTemplateObject; 
	
	public void setDataSource(DataSource dataSource) {
	      this.dataSource = dataSource;
	      this.jdbcTemplateObject = new JdbcTemplate(dataSource);
//	      System.out.println("dusedaotmp初始化了");
	   }

	@Override
	public int login(User user) {
		int flag = 0;
		String sql = "SELECT * FROM tb_user where username='"+ user.getUsername() + "';";
		List<User> userList = jdbcTemplateObject.query(sql, new UserMapper());// 执行SQL语句
		for(User member: userList) {
			if(member.getPwd().equals(user.getPwd()))  flag=member.getId();
			else flag=0;
		}	
		return flag;

	}

//	检测用户名是否被注册
	public String checkUser(String sql) {
		List<User> userList = jdbcTemplateObject.query(sql, new UserMapper()); // 执行查询语句
		String result = "";
		if(!userList.isEmpty()) {
			for(User duplicate: userList)
				result = "很抱歉，[" + duplicate.getUsername()+ "]已经被注册！";
		} else {
			result = "1"; // 表示用户没有被注册
		} 
		return result; // 返回判断结果
	}

	//保存用户注册信息
	public String save(String sql) {
		int rtn = jdbcTemplateObject.update(sql); // 执行更新语句
		String result = "";
		if (rtn > 0) {
			result = "userdao用户注册成功！";
		} else {
			result = "userdao2用户注册失败！";
		}
//		conn.close(); // 关闭数据库的连接
		return result; // 返回执行结果
	}
	
	public List<User> listUsers(String SQL) {
	      List <User> userList = jdbcTemplateObject.query(SQL, new UserMapper());
	//new StudentMapper()为查询结果期望匹配的类型
	      return userList;
	   }


}
