package com.allan.dao;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;
import com.allan.model.User;

public class UserMapper implements RowMapper<User>{

	@Override
	public User mapRow(ResultSet rs, int rowNum) throws SQLException {
		User user = new User();
		user.setEmail(rs.getString("email"));
		user.setId(rs.getInt("id"));
		user.setPwd(rs.getString("pwd"));
		user.setUsername(rs.getString("username"));
		return user;
	}
	
}
