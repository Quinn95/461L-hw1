package com.homework.blog;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;

import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Entity
public class UserC {
	@Id Long id;
	String name;
	
	private UserC() {}
	
	public UserC(String name){
		this.name = name;
	}
	
	public String getName(){
		return name;
	}
}
