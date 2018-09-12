package com.allan.dao;
import com.allan.model.User;
public interface UserDao {

	public int login(User user);
	public String checkUser(String sql);
	public String save(String sql);
}
