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


<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Bootstrap 101 Template</title>

    <!-- Bootstrap -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>



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

<div class="container">

  <div class="blog-header">
        <h1 class="blog-title">All posts</h1>
      </div>

      <div class="row">

      <div class="col-sm-8 blog-main">


<c:forEach var="post" items="${posts}">
    <div class="blog-post" style="background-color: #ffffbb;">
    <h2 class="blog-post-title">${fn:escapeXml(post.properties.title)}</h2>
    <p class="blog-post-meta">${post.properties.date} by ${post.properties.user}</p><br />
    <p>${fn:escapeXml(post.properties.content)}</p>
    <% //<a href="detail.jsp?name=${post.properties.title}">continue reading</a> %>
    </div>
</c:forEach>
</div>
</div>

<% if(user != null){ %>
<form action="/newblogpost" method="post">
	<div><input type="text" name="post_title" value="Title"/></div>
	<div><textarea name="post_body" rows="3" cols="60"></textarea></div>
	<div><input type="submit" value="Post"/></div>
	</form>
<% }else{ %>
<p>log in to make a post</p><% } %>
	</div>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="bootstrap/js/bootstrap.min.js"></script>

