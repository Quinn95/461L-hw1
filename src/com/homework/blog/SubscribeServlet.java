package com.homework.blog;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;

import com.google.appengine.api.users.UserService;

import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;

import java.io.IOException;

import java.util.Date;
<<<<<<< HEAD
import java.util.List;
=======
>>>>>>> 89e2affdab0234075558620832c5cafb13b6ba04

import com.homework.blog.UserC;

import static com.googlecode.objectify.ObjectifyService.ofy;
 

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;


import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.http.client.protocol.ResponseContentEncoding;

@SuppressWarnings("serial")
public class SubscribeServlet extends HttpServlet {
<<<<<<< HEAD
	static{
		ObjectifyService.register(UserC.class);
		ObjectifyService.register(BlogPost.class);
	}
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException{
		
		List<UserC> users = ofy().load().type(UserC.class).list();
		
		String email = req.getParameter("email");
		
		for(UserC user : users){
			if(user.getName().equals(email)){
				ofy().delete().entities(ObjectifyService.ofy().load().type(UserC.class).filter("name", email).list()).now();
				resp.sendRedirect("/unsubscribe.jsp");
				return;
			}
		}
		
		
=======
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException{
		String email = req.getParameter("email");
		
>>>>>>> 89e2affdab0234075558620832c5cafb13b6ba04
		UserC user = new UserC(email);
		
		ofy().save().entities(user).now();
		
<<<<<<< HEAD
		resp.sendRedirect("/subscribed.jsp");
=======
		resp.sendRedirect("/home.jsp");
>>>>>>> 89e2affdab0234075558620832c5cafb13b6ba04
		
	}
}
