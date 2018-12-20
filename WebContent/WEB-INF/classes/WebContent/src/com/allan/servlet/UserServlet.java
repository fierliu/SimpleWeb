package com.allan.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import com.allan.dao.UserDaoTemplate;
import com.allan.model.User;

public class UserServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private UserDaoTemplate userDao = null;
	
	public UserServlet() {
		@SuppressWarnings("resource")
		ApplicationContext context = new FileSystemXmlApplicationContext(
				"D:\\IT\\WEB\\SimpleWeb-master\\WebContent\\WEB-INF\\Beans.xml");
		userDao = (UserDaoTemplate)context.getBean("userDaoTemplate");		
	}
	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);// 执行doPost()方法
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		/*if ("login".equals(action)) { // 用户登录
			this.login(request, response);
		} else */if ("exit".equals(action)) {// 用户退出
			this.exit(request, response);
		} else if ("save".equals(action)) { // 保存用户注册信息
			this.save(request, response);
		}else if ("checkUser".equals(action)) {// 检测用户名是否存在
			this.checkUser(request, response);
		}else if("login".equals(action)) {
			this.login(request, response);
		}
	}
	//用户登录
	private void login(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String result="";
		User f = new User();
		f.setUsername(request.getParameter("username")); // 获取并设置用户名
		f.setPwd(request.getParameter("password")); // 获取并设置密码
//		System.out.println("name:" + request.getParameter("username") + " password:" + request.getParameter("password"));
		int r = userDao.login(f);//转到UserDaoTemplate.java,返回用户id.
		if (r >0) {// 当用户登录成功时
			//将登录状态保存到session中
			HttpSession session = request.getSession();
			session.setAttribute("userName", f.getUsername());// 保存用户名
//			System.out.println("f.getUsername() on UserServlet.login(): " + f.getUsername());
			session.setAttribute("uid", r);// 保存用户ID
			request.setAttribute("returnValue", "登录成功！");// 保存提示信息,用requestScope进行展示			
			request.getRequestDispatcher("success.jsp").forward(request, response);// 重定向页面
//			System.out.println("登录成功");
		} else {// 当用户登录不成功时
			response.setCharacterEncoding("utf-8");
			response.setContentType("text/html"); 
			PrintWriter out = response.getWriter();
			out.println("<script>alert('您输入的用户名或密码错误，请重新输入！');history.back();</script>");
		}
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.print(result); 							// 输出检测结果，交给register.jsp中的deal()处理
		out.flush();
		out.close();
	}
//	检测用户名是否被注册
	public void checkUser(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");		//获取用户名
		String sql = "SELECT * FROM tb_user WHERE username='" + username + "'";
		String result = userDao.checkUser(sql);		//调用UserDaoTemplate类的checkUser()方法判断用户是否被注册
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.print(result); 							// 输出检测结果，交给register.jsp中的deal()处理
		out.flush();
		out.close();
	}
//	保存注册的用户信息
	public void save(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username"); // 获取用户名
		String pwd = request.getParameter("pwd"); // 获取密码
		String email = request.getParameter("email"); // 获取E-mail地址
		String sql = "INSERT INTO tb_user (username,pwd,email) VALUE ('"
				+ username
				+ "','"
				+ pwd
				+ "','"
				+ email
				+ "' );";
//		System.out.print(sql);
		String result = userDao.save(sql);// 保存用户信息
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html"); // 设置响应的类型
		PrintWriter out = response.getWriter();
		out.print(result); // 输出执行结果，将其返回给register.jsp的deal_save方法
		out.flush();
		out.close();// 关闭输出流对象
	}
//	用户退出
	private void exit(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		System.out.println("exit called.");
		HttpSession session = request.getSession();// 获取HttpSession的对象
		session.invalidate();// 销毁session
		request.getRequestDispatcher("index.jsp")
				.forward(request, response);// 重定向页面
	}	
}
