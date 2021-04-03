package com.chernova.hire.service;

import com.chernova.hire.model.User;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSendException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

@Service
public class MailService {

	private static final String UTF_8 = "UTF-8";
	private static final String TEMPLATES_PATH = "/templates";

	private static final String ACTIVATION_TEMPLATE_NAME = "activation-code-email.ftl";
	private static final String CANDIDATE_INFO_TEMPLATE_NAME = "candidate-info-email.ftl";

	@Value("${spring.mail.username}")
	private String username;

	@Resource
	private Configuration getFreeMarkerConfiguration;

	@Resource
	private JavaMailSender customMailSender;

	public void sendGreetingEmail(User receiver) {

		String link = String.format("http:/localhost:9000/activate/%s", receiver.getActivationCode());
		String message = String.format("Hello %s! \n" + "Welcome to HireMe! Please visit next link: %s",
				receiver.getUsername(), link);
		Map<String, Object> model = new HashMap<>();
		model.put("text", message);
		sendHtmlMessage(receiver.getEmail(), "Activation code", ACTIVATION_TEMPLATE_NAME, model);
	}

	public void sendCandidateInformationEmail(User receiver, User candidate) {
		String message = String.format("Hello %s! \n" + "You have recently liked: %s %s profile! If you want to chat with %s " +
						"this is contact's data: ", receiver.getUsername(), candidate.getCv().getFirstName(),
				candidate.getCv().getLastName(), candidate.getCv().getFirstName());
		Map<String, Object> model = new HashMap<>();
		model.put("text", message);
		model.put("email", candidate.getEmail());
		model.put("phone", candidate.getCv().getPhone());
		sendHtmlMessage(receiver.getEmail(), "Candidate information", CANDIDATE_INFO_TEMPLATE_NAME, model);
	}

	private void sendHtmlMessage(String to, String subject, String htmlBody, Map<String, Object> model) {
		try {
			MimeMessagePreparator mimeMessagePreparator = mimeMessage ->
					prepareMimeMessage(htmlBody, to, mimeMessage, model, subject);
			customMailSender.send(mimeMessagePreparator);
		} catch (MailException e) {
			throw new MailSendException(Objects.requireNonNull(e.getMessage()));
		}
	}

	private void prepareMimeMessage(String templateName, String receiver, MimeMessage mimeMessage, Map<String, Object> model,
									String subject) throws IOException, TemplateException, MessagingException {

		MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, UTF_8);
		getFreeMarkerConfiguration.setClassForTemplateLoading(this.getClass(), TEMPLATES_PATH);
		Template template = getFreeMarkerConfiguration.getTemplate(templateName, UTF_8);
		String text = FreeMarkerTemplateUtils.processTemplateIntoString(template, model);
		helper.setFrom(username);
		helper.setTo(receiver);
		helper.setText(text, true);
		helper.setSubject(subject);
	}

}
