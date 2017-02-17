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

<%@ page import="com.googlecode.objectify.*" %>

<%@ page import="com.homework.blog.BlogPost" %>



<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%
	UserService userService = UserServiceFactory.getUserService();

	User user = userService.getCurrentUser();

	if (user != null) {
  		pageContext.setAttribute("user", user);
%>
		<p>Hello, ${fn:escapeXml(user.nickname)}! (You can

		<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>
<%
    } else {
%>
		<p>Hello!

		<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>

		to include your name with greetings you post.</p>
<%
    }
%>

<%
	String name = request.getParameter("name");
	//DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	ObjectifyService.register(BlogPost.class);
	List<BlogPost> greetings = ObjectifyService.ofy().load().type(BlogPost.class).filter("title", name).list();
	BlogPost post = null;
	try{
		post = greetings.get(0);
	}
	catch(Exception e){}
	//Key blogPostKey = KeyFactory.createKey("BlogPost");
	//System.out.println(blogPostKey);
	
	//Query query = new Query("BlogPost");
	//List<Entity> posts = datastore.filter("name", name).prepare(query).asList(FetchOptions.Builder.withLimit(5));
	/*Entity post;
	try{
		post = datastore.get(blogPostKey);
	}
	catch(Exception e){
		post = null;
	}
	*/
	//Entity post = ofy().load().type(Car.class).filter("vin", "123456789").first().now();

	//System.out.println(post);
	pageContext.setAttribute("p", post);
	//pageContext.setAttribute("title", name);
	if(post == null){
%>
	<p>Sorry, post doesn't exist</p>
	<% }else{ %>
	<h1>${fn:escapeXml(user.nickname)} says: ${fn:escapeXml(p.title)}</h1><p>${fn:escapeXml(p.content)}</p>
	<% } %>