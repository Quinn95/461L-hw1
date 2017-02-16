package com.homework.blog;

import java.io.IOException;
import javax.servlet.http.*;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class BlogHomeServlet extends HttpServlet {
	static{
		ObjectifyService.register(BlogPost.class);
	}
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		resp.setContentType("text/plain");
		resp.getWriter().println("Hello, world");
	}
}
