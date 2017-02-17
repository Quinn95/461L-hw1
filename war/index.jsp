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

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	
	Query query = new Query("BlogPost");//.addSort("date", Query.SortDirection.DESCENDING);

	List<Entity> posts = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
	pageContext.setAttribute("posts", posts);
	System.out.println(posts);
%>
<table>
<c:forEach var="post" items="${posts}">
  <tr style="border: 1px solid black;">
    <td style="border: 1px solid black;"><a href="detail.jsp?name=${post.properties.title}">title: ${fn:escapeXml(post.properties.title)}</a></td>
    <td style="border: 1px solid black;"><p>${fn:escapeXml(post.properties.content)}</p></td>
  </tr>
</c:forEach>
</table>

<% if(user != null){ %>
<form action="/newblogpost" method="post">
	<div><input type="text" name="post_title" value="Title"/></div>
	<div><textarea name="post_body" rows="3" cols="60"></textarea></div>
	<div><input type="submit" value="Post"/></div>
<% }else{ %>
<p>log in to make a post</p> <% } %>
</form>