package com.chernova.hire.controller;

import com.chernova.hire.model.User;
import com.chernova.hire.service.UserService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class RecruiterController {

	@Resource
	private UserService userService;


	@PreAuthorize("hasAuthority('RECRUITER')")
	@GetMapping("/candidates-list")
	public String getCandidates(Model model, @AuthenticationPrincipal User authenticatedUser) {
		List<String> likedCvsOwnersNames = userService.findAllLikedCvs(authenticatedUser.getUsername());
		model.addAttribute("candidates", userService.findAllByUsernames(likedCvsOwnersNames));
		return "candidates-list";
	}
}
