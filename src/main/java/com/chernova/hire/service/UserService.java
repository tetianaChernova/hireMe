package com.chernova.hire.service;

import com.chernova.hire.model.CurriculumVitae;
import com.chernova.hire.model.Role;
import com.chernova.hire.model.User;
import com.chernova.hire.repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

import static java.util.Objects.isNull;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.BooleanUtils.isFalse;
import static org.apache.commons.lang3.StringUtils.isEmpty;

@Service
public class UserService implements UserDetailsService {
	@Resource
	private UserRepo userRepo;
	//	@Autowired
//	private UserRepository userNeo4jRepo;
	@Resource
	private MailService mailService;
	@Resource
	private PasswordEncoder passwordEncoder;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user = userRepo.findByUsername(username);
		if (isNull(user)) {
			throw new UsernameNotFoundException("User not found");
		}
		return user;
	}

	public boolean addUser(User user) {
		User userFromDb = userRepo.findByUsername(user.getUsername());
		if (nonNull(userFromDb)) {
			return false;
		}
		user.setActive(false);
		user.setRoles(Collections.singleton(Role.USER));
		user.setActivationCode(UUID.randomUUID().toString());
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		CurriculumVitae cv = CurriculumVitae.builder().user(user).build();
		user.setCv(cv);
		userRepo.save(user);

		if (isFalse(isEmpty(user.getEmail()))) {
			sendMessage(user);
		}
		return true;
	}

	private void sendMessage(User user) {
		String message = String.format(
				"Hello %s! \n" + "Welcome to HireMe! Please visit next link: http:/localhost:9000/activate/%s",
				user.getUsername(), user.getActivationCode()
		);

		mailService.send(user.getEmail(), "Activation code", message);
	}

	public boolean activateUser(String code) {
		User user = userRepo.findByActivationCode(code);
		if (isNull(user)) {
			return false;
		}
		user.setActive(true);
		user.setActivationCode(null);
		userRepo.save(user);
		return true;
	}

	public List<User> findAll() {
		return userRepo.findAll();
	}

	public void saveUser(User user, String username, Map<String, String> form) {
		user.setUsername(username);

		Set<String> roles = Arrays.stream(Role.values())
				.map(Role::name)
				.collect(Collectors.toSet());

		user.getRoles().clear();
		form.keySet().forEach(key -> {
			if (roles.contains(key)) {
				user.getRoles().add(Role.valueOf(key));
			}
		});
		userRepo.save(user);
	}
}

