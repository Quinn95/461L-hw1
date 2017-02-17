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



@SuppressWarnings("serial")
public class NewBlogPostServlet extends HttpServlet {
	static{
		ObjectifyService.register(BlogPost.class);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
				throws IOException{
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		
		
		String title = req.getParameter("post_title");
		if(ofy().load().type(BlogPost.class).filter("title", title).list().size() != 0){
			resp.sendRedirect("/index.jsp");
			return;
		}
		//Key postKey = KeyFactory.createKey("BlogPost", title);
		//System.out.println(postKey);
		String body = req.getParameter("post_body");
		
		
		BlogPost post = new BlogPost(user, title, body);
		
		
		ofy().save().entities(post).now();
		try {
			Thread.sleep(1500);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		resp.sendRedirect("/detail.jsp?name=" + title);
	}
}
