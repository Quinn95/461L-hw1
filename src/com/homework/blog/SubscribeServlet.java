package com.homework.blog;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;

import com.google.appengine.api.users.UserService;

import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;

import java.io.IOException;

import java.util.Date;

import com.homework.blog.UserC;

import static com.googlecode.objectify.ObjectifyService.ofy;
 

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;


import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.http.client.protocol.ResponseContentEncoding;

@SuppressWarnings("serial")
public class SubscribeServlet extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException{
		String email = req.getParameter("email");
		
		UserC user = new UserC(email);
		
		ofy().save().entities(user).now();
		
		resp.sendRedirect("/home.jsp");
		
	}
}
