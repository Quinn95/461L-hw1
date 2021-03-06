package com.homework.blog;

import java.util.Date;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;

import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Entity
public class BlogPost implements Comparable<BlogPost> {
	@Id Long id;
	User user;	
	String title;
	String content;
	@Index Date date;
	private BlogPost() {}
	
	public BlogPost(User user, String title, String content){
		this.user = user;
		this.title = title;
		this.content = content;
		date = new Date();
	}
	
	@Override
	public int compareTo(BlogPost other) {
        if (date.after(other.date)) {
            return 1;
        } else if (date.before(other.date)) {
            return -1;
        }
        return 0;
	}
	
	public String getUser(){
		return user.getNickname();
	}
	
	public String getTitle(){
		return title;
	}

	public String getContent(){
		return content;
	}
	
	public Date getDate(){
		return date;
	}
}
