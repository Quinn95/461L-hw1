package com.homework.blog;

import java.io.IOException;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import com.sendgrid.*;

@SuppressWarnings("serial")
public class CronServlet extends HttpServlet {
	private static final Logger _logger = Logger.getLogger(CronServlet.class.getName());
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		try { _logger.info("Cron Job has been executed");

		/* set credentials */
		//SendGrid mail = new SendGrid("atchisonbrent","m%JQWXl2");
		SendGrid mail = new SendGrid("atchisonbrent");
		/* Loop through subscriber list, sending emails */
		int numSubscribers = 1;
		for (int i = 0; i < numSubscribers; i++) {
			/* Set email data */
			mail.setTo(subscriber.getEmail()).setFrom("homeworkBlog@gmail.com").setSubject("Recent Posts on Blog").setText(blog.getRecentPosts()).setHtml("<strong>Hello World!</strong>");
			mail.send();
		}
		
		} catch (Exception ex) {
		//Log any exceptions in your Cron Job
		}
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException { doGet(req, resp); }
}