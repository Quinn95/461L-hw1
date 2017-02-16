<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>

<%@ page import="com.google.appengine.api.datastore.Query" %>

<%@ page import="com.google.appengine.api.datastore.Entity" %>

<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>

<%@ page import="com.google.appengine.api.datastore.Key" %>

<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>

<%@ page import="com.homework.blog.BlogPost" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%
	String name = request.getParameter("name");
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	Key blogPostKey = KeyFactory.createKey("BlogPost", name);
	//System.out.println(blogPostKey);
	
	//Query query = new Query("BlogPost", blogPostKey);
	//List<Entity> posts = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
	Entity post;
	try{
		post = datastore.get(blogPostKey);
	}
	catch(Exception e){
		post = null;
	}
	//System.out.println(post);
	pageContext.setAttribute("post", post);
	pageContext.setAttribute("title", name);
	System.out.println(post);
	if(post == null){
%>
	<p>Sorry, post doesn't exist</p>
	<% }else{ %>
	<p>${fn:escapeXml(post.properties.key)}</p>
	<% } %>