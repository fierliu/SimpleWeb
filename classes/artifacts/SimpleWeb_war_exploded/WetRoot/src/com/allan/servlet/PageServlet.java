package com.allan.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import com.allan.dao.PageDao;

@WebServlet(urlPatterns="/PageServlet")
public class PageServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1219256414836027276L;
	/**
	 * 
	 */
	
	private PageDao pageDao = null;
	public PageServlet() {
		@SuppressWarnings("resource")
		ApplicationContext context = new FileSystemXmlApplicationContext(
				"D:\\\\IT\\\\WEB\\\\SimpleWeb-master\\\\WebContent\\WEB-INF\\Beans.xml");
		pageDao = (PageDao)context.getBean("pageDao");		
	}
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);// 执行doPost()方法
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
//		System.out.println("doPost called.");
		String action = request.getParameter("action");
//		System.out.println("PageServlet doPost() action:" + action);
		if("get".equals(action)) {
			Integer count = this.get(request, response);
			PrintWriter prin = response.getWriter();
//	        String massge = "Success!";
	        prin.print(count);
		}else {
			
		}
}

	private Integer get(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String sql = "SELECT count FROM tb_page WHERE id=1;";
		Integer count = pageDao.require(sql);
//		System.out.println(count);
//		HttpSession session = request.getSession();
//		ServletContext application = session.getServletContext();
//		application.setAttribute("hitCount", count);
		add();
		return count;
	}
	
	private void add() {
		String sql = "UPDATE tb_page SET count=count + 1 WHERE id=1;";
		@SuppressWarnings("unused")
		String result = pageDao.save(sql);
	}
}