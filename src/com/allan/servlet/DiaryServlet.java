package com.allan.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.allan.dao.DiaryDao;
import com.allan.model.Diary;
import com.allan.tool.MyPagination;
@WebServlet(urlPatterns="/DiaryServlet")
public class DiaryServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2380055712429207897L;
	private DiaryDao diaryDao = null;
	MyPagination pagination = null;// 数据分页类的对象
	
	public DiaryServlet() {
		ApplicationContext context = new FileSystemXmlApplicationContext(
				"C:\\Users\\allan\\eclipse-workspace\\SimpleWeb\\WebContent\\WEB-INF\\Beans.xml");
		diaryDao = (DiaryDao)context.getBean("diaryDao");		
	}
	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);// 执行doPost()方法
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
//		System.out.println("doPost called.");
		String action = request.getParameter("action");
		if ("save".equals(action)) { // 保存用户注册信息
			this.save(request, response);
		}else if("listDiary".equals(action)) {
			this.listDiary(request, response);
		}else if("listMyDiary".equals(action)) {
			this.listMyDiary(request, response);
		}else if("delDiary".equals(action)) {
			this.delDiary(request, response);
		}
	}
	//保存文章
	public void save(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		System.out.println("save called");
		String title = request.getParameter("title");
		String uid = request.getParameter("uid"); 
		String content = request.getParameter("content"); // 获取文章内容!注意，post方法中不能有&和=等特殊字符。
		System.out.println("title:"+title+"  content:"+content);
		String WriteTime = request.getParameter("WriteTime");		
		String sql = "INSERT INTO tb_diary (title, uid, content) VALUE ('"
				+ title
				+ "','"
				+ uid
				+ "','"
				+ content
				+ "' );";
//		System.out.print(sql);
//		System.out.println(content);
		String result = diaryDao.save(sql);// 保存用户信息
		System.out.println(result);
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html"); // 设置响应的类型
		PrintWriter out = response.getWriter();
		out.print(result); // 输出执行结果，将其返回给register.jsp的deal_save方法
		out.flush();
		out.close();// 关闭输出流对象
	}
	//列出日记
	public void listDiary(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String currentPage = (String)request.getParameter("Page");//Page从分页导航的url链接中传递过来
		int Page = 1;//指定的页面
		List<Diary> list = null;
		if (currentPage == null) {// 当页面初次运行
			String sql = "select d.*,u.username from tb_diary d "//d和u为两个数据表的别名。
					+ "inner join tb_user u on u.id=d.uid order by d.writeTime DESC limit 50";
			//inner join(等值联接)，产生同时符合两个表格的数据，on后是条件
			//此句即以tb_user的id和tb_diary的uid等值连接,用降序查询所有tb_diary的所有数据和tb_user的username
			pagination = new MyPagination();
			list = diaryDao.require(sql);// 获取日记内容（由diary对象组成的列表）
			System.out.println(list.size());
			int pagesize = 4; // 指定每页显示的记录数
			list = pagination.getInitPage(list, Page, pagesize); // 初始化分页信息，获取首页内容
			request.getSession().setAttribute("pagination", pagination);
		} else {
			pagination = (MyPagination) request.getSession().getAttribute("pagination");
			System.out.println("currentPage="+ currentPage);
			Page = pagination.getPage(currentPage);// 获取当前页码
			list = pagination.getAppointPage(Page); // 获取指定页数据
		}
		request.setAttribute("diaryList", list); // 保存当前页的日记信息
		request.setAttribute("Page", Page); // 保存的当前页码
		request.setAttribute("url", "listDiary");// 保存当前页面的URL
		request.getRequestDispatcher("listAllDiary.jsp").forward(request,response);// 重定向页面
	}
	
	public void listMyDiary(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		// 获取日记内容
		String strPage = (String) request.getParameter("Page");// 获取当前页码
		int Page = 1;
		List<Diary> list = null;
		if (strPage == null) {
			int uid = Integer.parseInt(session.getAttribute("uid").toString()); // 获取用户ID号
			String sql = "select d.*,u.username from tb_diary d inner join tb_user u on u.id=d.uid  where d.uid="
					+ uid + " order by d.writeTime DESC";// 应用内联接查询日记信息
			pagination = new MyPagination();
			list = diaryDao.require(sql);// 获取日记内容
			int pagesize = 4; // 指定每页显示的记录数
			list = pagination.getInitPage(list, Page, pagesize); // 初始化分页信息
			request.getSession().setAttribute("pagination", pagination);// 保存分页信息
		} else {
			pagination = (MyPagination) request.getSession().getAttribute(
					"pagination");// 获取分页信息
			Page = pagination.getPage(strPage);
			list = pagination.getAppointPage(Page); // 获取指定页数据
		}
		for(Diary diary: list) {
			System.out.println(diary.getWriteTime().toString());
		}
		request.setAttribute("diaryList", list); // 保存当前页的日记信息
		request.setAttribute("Page", Page); // 保存的当前页码
		request.setAttribute("url", "listMyDiary");// 保存当前页的URL地址
		request.getRequestDispatcher("listUserDiary.jsp").forward(request,
				response);// 重定向页面到listAllDiary.jsp
	}
	
	public void delDiary(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id")); // 获取要删除的日记的ID
		String url = request.getParameter("url"); // 获取返回的URL地址
		int rtn = diaryDao.delDiary(id);// 删除日记
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html"); 
		PrintWriter out = response.getWriter();
		if (rtn > 0) {// 当删除日记成功时
			out.println("<script>alert('删除日记成功！');window.location.href='DiaryServlet?action="+ url + "';</script>");
		} else {// 当删除日记失败时
			out.println("<script>alert('删除日记失败，请稍后重试！');history.back();</script>");
		}
	}
}
