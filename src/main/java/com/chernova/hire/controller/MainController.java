package com.chernova.hire.controller;

import com.chernova.hire.model.User;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MainController {
	@GetMapping("/")
	public String greeting() {
		return "greeting";
	}

	@GetMapping("/main")
	public String main(
			@RequestParam(required = false, defaultValue = "") String filter,
			@AuthenticationPrincipal User user,
			Model model) {
//		Iterable<MessageDto> messages = messageService.getMessageList(filter, user);
//		model.addAttribute("messages", messages);
//		model.addAttribute("filter", filter);
		return "main";
	}

}
