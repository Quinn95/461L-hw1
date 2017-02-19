package com.homework.blog;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;

import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Entity
public class UserC {
	@Id Long id;
<<<<<<< HEAD
	@Index String name;
=======
	String name;
>>>>>>> 89e2affdab0234075558620832c5cafb13b6ba04
	
	private UserC() {}
	
	public UserC(String name){
		this.name = name;
	}
	
	public String getName(){
		return name;
	}
}
