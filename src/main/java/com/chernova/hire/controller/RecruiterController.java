package com.chernova.hire.controller;

import com.chernova.hire.service.UserService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.annotation.Resource;

@Controller
public class RecruiterController {

	@Resource
	private UserService userService;


	@PreAuthorize("hasAuthority('RECRUITER')")
	@GetMapping("/candidates-list")
	public String getCandidates(Model model) {
		model.addAttribute("candidates", userService.findAll());
		return "candidates-list";
	}
}
