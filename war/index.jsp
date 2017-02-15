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

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<table>
<%
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	
	Query query = new Query("BlogPost").addSort("date", Query.SortDirection.DESCENDING);

	List<Entity> posts = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
	
	for (Entity post : posts){
		pageContext.setAttribute("post_user", 
				post.getProperty("user"));
		pageContext.setAttribute("post_title",
				post.getProperty("title"));
		pageContext.setAttribute("post_body",
				post.getProperty("body"));
%>
	<tr><td><p><b>$(fn:escapeXml(post_user"))</b>
	<br />$(fn:escapeXml(post_title))<br />
	$(fn:escapeXml(post_body))</p></td></tr>
<% } %>
</table>