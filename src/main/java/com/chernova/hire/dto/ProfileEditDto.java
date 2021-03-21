package com.chernova.hire.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ProfileEditDto {
	private String firstName;
	private String lastName;
	private String position;
	private Integer experience;
	private String title;
	private String nationality;
	private String city;
	private String email;
	private String phone;
	private String description;
}
