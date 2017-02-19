package com.homework.blog;

import java.io.IOException;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import com.sendgrid.*;
import com.homework.blog.UserC;


@SuppressWarnings("serial")
public class CronServlet extends HttpServlet {
	private static final Logger _logger = Logger.getLogger(CronServlet.class.getName());
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		try { _logger.info("Cron Job has been executed");

		/* set credentials */
		//SendGrid mail = new SendGrid("atchisonbrent","m%JQWXl2");
		SendGrid sendgrid = new SendGrid("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");


		Email from = new Email("test@blog.com");
		String subject = "Subject";
		Email to = new Email("crontesting123@gmail.com");
		Content content = new Content("text/html", "content");
		Mail mail = new Mail(from, subject, to, content);
		
		com.sendgrid.Request request = new com.sendgrid.Request();
		try{
		      request.method = Method.POST;
		      request.endpoint = "mail/send";
		      request.body = mail.build();
		      Response response = sendgrid.api(request);
		    } catch (IOException ex) {
		      throw ex;
		    }

		}catch (Exception ex) {
	//Log any exceptions in your Cron Job
	}

		
		/*
		List<UserC> users = ofy().load().type(UserC.class).list();
		for (UserC user : users) {
			Email from = new Email("test@blog.com");
			String subject = "Subject";
			Email to = new Email("crontesting123@gmail.com");
			Content content = new Content("text/html", "content");
			Mail mail = new Mail(from, subject, to, content);
			
			com.sendgrid.Request request = new com.sendgrid.Request();
			try{
			      request.method = Method.POST;
			      request.endpoint = "mail/send";
			      request.body = mail.build();
			      Response response = sendgrid.api(request);
			      System.out.println(response.statusCode);
			      System.out.println(response.body);
			      System.out.println(response.headers);
			    } catch (IOException ex) {
			      throw ex;
			    }

			}
		}catch (Exception ex) {
		//Log any exceptions in your Cron Job
		}
		*/
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException { doGet(req, resp); }
}