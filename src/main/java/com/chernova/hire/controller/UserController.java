package com.chernova.hire.controller;

import com.chernova.hire.dto.ProfileEditDto;
import com.chernova.hire.model.User;
import com.chernova.hire.service.UserService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/users")
public class UserController {

	@Value("${upload.path}")
	private String uploadPath;

	@Resource
	private UserService userService;

	@PreAuthorize("hasAuthority('RECRUITER')")
	@GetMapping
	public String getUsers(Model model, @AuthenticationPrincipal User authenticatedUser) {
		model.addAttribute("candidates",
				userService.findAll()
						.stream()
						.filter(candidate -> !candidate.isRecruiter())
						.collect(Collectors.toList()));
		model.addAttribute("likedCandidates", userService.findAllLikedCvs(authenticatedUser.getUsername()));
		model.addAttribute("filter", "");
		model.addAttribute("isRecommendationsPage", false);
		return "posts";
	}

	@GetMapping("/cv/{userId}")
	public String getUserProfile(Model model, @PathVariable Long userId) {
		User candidate = userService.findById(userId);
		model.addAttribute("candidate", candidate);
		return "cv";
	}

	@ResponseBody
	@PreAuthorize("hasAuthority('RECRUITER')")
	@PostMapping("/cv/{candidateId}/like")
	public String likeCandidateProfile(@AuthenticationPrincipal User authenticatedUser,
									   @PathVariable Long candidateId) {
		userService.likeCv(authenticatedUser, candidateId);
		return "ok";
	}

	@ResponseBody
	@PreAuthorize("hasAuthority('RECRUITER')")
	@DeleteMapping("/cv/{candidateId}")
	public String deleteCandidateFromLikedList(@AuthenticationPrincipal User authenticatedUser,
											   @PathVariable Long candidateId) {
		userService.unlike(authenticatedUser.getUsername(), userService.findById(candidateId).getUsername());
		return "ok";
	}

	@PreAuthorize("hasAuthority('USER')")
	@PostMapping("/cv/{userId}/edit")
	public String edit(Model model, @AuthenticationPrincipal User user, @PathVariable Long userId,
					   ProfileEditDto profileEditDto) {
		User updatedUser = userService.updateProfile(user, profileEditDto);
		model.addAttribute("user", updatedUser);
		return "redirect:/users/cv/" + userId;
	}

	@PreAuthorize("hasAuthority('RECRUITER')")
	@GetMapping("/recommendations")
	public String recommendations(Model model,
								  @RequestParam(required = false, defaultValue = "") String technologyFilter,
								  @RequestParam(required = false, defaultValue = "1") Integer experienceFilter,
								  @AuthenticationPrincipal User user) {
		model.addAttribute("candidates",
				userService.getRecommendationsForUser(user.getUsername(), technologyFilter, experienceFilter));
		model.addAttribute("likedCandidates", Collections.emptyList());
		model.addAttribute("isRecommendationsPage", true);
		model.addAttribute("technologyFilter", technologyFilter);
		model.addAttribute("experienceFilter", experienceFilter);
		return "posts";
	}

}
