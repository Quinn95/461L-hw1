package com.homework.blog;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;

import com.google.appengine.api.users.UserService;

import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;

import java.io.IOException;

import java.util.Date;

import static com.googlecode.objectify.ObjectifyService.ofy;
 

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;


import org.apache.commons.lang3.StringEscapeUtils;



@SuppressWarnings("serial")
public class NewBlogPostServlet extends HttpServlet {
	static{
		ObjectifyService.register(UserC.class);
		ObjectifyService.register(BlogPost.class);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
				throws IOException{
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		
		
		String title = req.getParameter("post_title");
		String body = req.getParameter("post_body");
		String escaped = StringEscapeUtils.escapeHtml4(body);
		String escapeTitle = StringEscapeUtils.escapeHtml4(title);
		escaped = escaped.replace("\n", "<br />");
		
		BlogPost post = new BlogPost(user, escapeTitle, escaped);
		
		
		ofy().save().entities(post).now();
		/*
		try {
			Thread.sleep(1500);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} */
		resp.sendRedirect("/home.jsp");
	}
}
