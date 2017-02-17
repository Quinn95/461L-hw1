package com.homework.blog;

import java.io.IOException;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import com.sendgrid.*;

@SuppressWarnings("serial")
public class GAEJCronServlet extends HttpServlet {
	private static final Logger _logger = Logger.getLogger(GAEJCronServlet.class.getName());
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		try { _logger.info("Cron Job has been executed");

		//Put your logic here
		//BEGIN
		// set credentials
		Sendgrid mail = new Sendgrid("<sendgrid_username>","<sendgrid_password>");

		// set email data
		mail.setTo("foo@bar.com").setFrom("me@bar.com").setSubject("Subject goes here").setText("Hello World!").setHtml("<strong>Hello World!</strong>");

		// send your message
		mail.send();
		//END
		
		} catch (Exception ex) {
		//Log any exceptions in your Cron Job
		}
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException { doGet(req, resp); }
}