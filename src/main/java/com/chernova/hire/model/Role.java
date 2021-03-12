package com.chernova.hire.model;

import org.springframework.security.core.GrantedAuthority;

public enum Role implements GrantedAuthority {
	USER, RECRUITER;

	@Override
	public String getAuthority() {
		return name();
	}
}
