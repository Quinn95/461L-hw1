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

<%@ page import="java.util.Collections" %>

<%@ page import="com.googlecode.objectify.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="favicon.ico">

    <title>Blog Template for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="bootstrap//assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="blog.css" rel="stylesheet">


    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>



  <body>

    <div class="blog-masthead">
      <div class="container">
        <nav class="blog-nav">
          <a class="blog-nav-item" href="home.jsp">Home</a>
          <a class="blog-nav-item" href="archive.jsp">Archive</a>
          <%
			UserService userService = UserServiceFactory.getUserService();

			User user = userService.getCurrentUser();

			if (user != null) {
  				pageContext.setAttribute("user", user);
			%>
            <a class="blog-nav-item" href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Log out (${user.nickname})</a>

          <% }else{ %>
          <a class="blog-nav-item" href="<%= userService.createLoginURL(request.getRequestURI()) %>">Log in</a>
          <% } %>
        </nav>
      </div>
    </div>

    <div class="container">

      <div class="blog-header">
        <h1 class="blog-title">Make a new post</h1>
      </div>

      <div class="row">

        <div class="col-sm-8 blog-main">
        
        <% if(user != null){ %>
		<form action="/newblogpost" method="post">
		<label for="title">title</label>
		<div><input type="text" name="post_title" id="title"/></div>
		<label for="body">body</label>
		<div><textarea name="post_body" rows="3" cols="60" id="body"></textarea></div>
		<div><input type="submit" value="Post"/></div>
		</form>
		<% }else{ %>
		<p>log in to make a post</p><% } %>
		</div>
        

        </div><!-- /.blog-main -->

    <footer class="blog-footer">
      <p>Blog built by Quinn Zambeck and Brent Atchison for EE 461L</p>
      <p>
        <a href="#">Back to top</a>
      </p>
    </footer>


  </body>
  <script src="bootstrap/js/bootstrap.min.js"></script>
  
</html>
