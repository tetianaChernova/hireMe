package com.chernova.hire.repo;

import com.chernova.hire.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepo extends JpaRepository<User, Long> {
	User findByUsername(String username);

	List<User> findAllByUsernameIn(List<String> username);
	User findByActivationCode(String code);
}
