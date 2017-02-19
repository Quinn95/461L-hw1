package com.homework.blog;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import org.apache.commons.lang3.time.DateUtils;

import com.sendgrid.*;
import com.homework.blog.UserC;
import com.googlecode.objectify.*;

import java.util.Date;


@SuppressWarnings("serial")
public class CronServlet extends HttpServlet {
	static{
		ObjectifyService.register(UserC.class);
		ObjectifyService.register(BlogPost.class);
	}
	private static final Logger _logger = Logger.getLogger(CronServlet.class.getName());
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		_logger.info("Cron Job has been executed");

		/* set credentials */
		//SendGrid mail = new SendGrid("atchisonbrent","m%JQWXl2");
		SendGrid sendgrid = new SendGrid("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");

		Date date = DateUtils.addDays(new Date(), -1);
		
		List<UserC> users = ofy().load().type(UserC.class).list();
		List<BlogPost> posts = ofy().load().type(BlogPost.class).filter("date >", date).list();
		if(posts.size() > 0){
			Email from = new Email("quinn.and.brent@blog.com");
			String subject = "Blog Summary";
			
			String c = "There are been " + posts.size() + " posts since yesterday<br />";
			for(BlogPost post : posts){
				c = c + "<h1>" + post.getTitle() + "</h1>" + post.getContent() + "<br />";
			}
			
			Content content = new Content("text/html", c);

			for(UserC user : users){
				Email to = new Email(user.getName());
				Mail mail = new Mail(from, subject, to, content);
				
				com.sendgrid.Request request = new com.sendgrid.Request();
				try{
				      request.method = Method.POST;
				      request.endpoint = "mail/send";
				      request.body = mail.build();
				      Response response = sendgrid.api(request);
				    } catch (IOException ex) {
				    }
			}
		}
		
		
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException { doGet(req, resp); }
}