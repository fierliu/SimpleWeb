package com.allan.filter;

import java.io.IOException;
import javax.servlet.*;

public class CharacterEncodingFilter implements Filter {

	protected String encoding = null; // 定义编码格式变量
	protected FilterConfig filterConfig = null; // 定义过滤器配置对象

	public void init(FilterConfig filterConfig) throws ServletException {
//		this.filterConfig = filterConfig; // 初始化过滤器配置对象
//		this.encoding = filterConfig.getInitParameter("encoding"); // 获取配置文件中指定的编码格式
	}

	// 过滤器的接口方法，用于执行过滤业务
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		request.setCharacterEncoding("utf-8");   
	     response.setCharacterEncoding("utf-8");   
	     chain.doFilter(request,response);  
	}

	public void destroy() {
//		this.encoding = null;
//		this.filterConfig = null;
	}

}
