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

    <title>Cat blog!</title>

    <!-- Bootstrap core CSS -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="blog.css" rel="stylesheet">


  </head>



  <body>

    <div class="blog-masthead">
      <div class="container">
        <nav class="blog-nav">
          <a class="blog-nav-item active" href="home.jsp">Home</a>
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
        <h1 class="blog-title">Welcome!</h1>
      </div>

      <div class="row">

        <div class="col-sm-8 blog-main">
        
        <a href="newpost.jsp"><button type="button" class="btn btn-lg btn-primary">New post</button></a>
		<%
			ObjectifyService.register(BlogPost.class);
			List<BlogPost> posts = ObjectifyService.ofy().load().type(BlogPost.class).list();
			Collections.sort(posts);
			Collections.reverse(posts);
			if(posts.size() >= 5){
				posts = posts.subList(0, 5);
			}
			for(BlogPost post : posts){ %>
          <div class="blog-post">
            <h2 class="blog-post-title"><%=post.getTitle()%></h2>
    	<p class="blog-post-meta"><%=post.getDate()%> by <%=post.getUser()%> </p>
            <p><%=post.getContent()%></p>
          </div><!-- /.blog-post -->
       	<% } %>
        </div><!-- /.blog-main -->

        <div class="col-sm-3 col-sm-offset-1 blog-sidebar">
        <p><b>You have unsubscribed</b></p>
        
          <div class="sidebar-module sidebar-module-inset">
            <h4>About</h4>
            <p>The domestic cat (Latin: Felis catus) is a small, typically furry, carnivorous mammal. They are often called house cats when kept as indoor pets or simply cats when there is no need to distinguish them from other felids and felines. Cats are often valued by humans for companionship and for their ability to hunt vermin. There are more than 70 cat breeds, though different associations proclaim different numbers according to their standards.</p>
          </div>
          <img src="cat.jpg" imdata-src="holder.js/200x200" class="img-thumbnail" alt="A generic square placeholder image with a white border around it, making it resemble a photograph taken with an old instant camera">
          <div class="sidebar-module">
            <h4>Archives</h4>
            <ol class="list-unstyled">
              <li><a href="archive.jsp">February 2017</a></li>
            </ol>
          </div>
          <div class="sidebar-module">
            <h4>Elsewhere</h4>
            <ol class="list-unstyled">
              <li><a href="https://github.com/Quinn95/461L-hw1">GitHub</a></li>
            </ol>
          </div>
        </div><!-- /.blog-sidebar -->

      </div><!-- /.row -->

    </div><!-- /.container -->

    <footer class="blog-footer">
      <p>Blog built by Quinn Zambeck and Brent Atchison for EE 461L</p>
      <p>
        <a href="#">Back to top</a>
      </p>
    </footer>


  </body>
  <script src="bootstrap/js/bootstrap.min.js"></script>
  
</html>
