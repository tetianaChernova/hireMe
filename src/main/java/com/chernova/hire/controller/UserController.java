package com.chernova.hire.controller;

import com.chernova.hire.dto.ProfileEditDto;
import com.chernova.hire.model.User;
import com.chernova.hire.service.UserService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

@Controller
@RequestMapping("/users")
public class UserController {

	@Value("${upload.path}")
	private String uploadPath;

	@Resource
	private UserService userService;

	@PreAuthorize("hasAuthority('RECRUITER')")
	@GetMapping
	public String getUsers(Model model) {
		model.addAttribute("users", userService.findAll());
		return "posts";
	}

	@GetMapping("/cv/{userId}")
	public String getUserProfile(Model model, @AuthenticationPrincipal User authenticatedUser, @PathVariable Long userId) {
		User candidate = userService.findById(userId);
		model.addAttribute("candidate", candidate);
		return "cv";
	}


	@PreAuthorize("hasAuthority('USER')")
	@PostMapping("/cv/{userId}/edit")
	public String edit(Model model, @AuthenticationPrincipal User user, @PathVariable Long userId, ProfileEditDto profileEditDto) {
		User updatedUser = userService.updateProfile(user, profileEditDto);
		model.addAttribute("user", updatedUser);
		return "redirect:/users/cv/" + userId;
	}

}
