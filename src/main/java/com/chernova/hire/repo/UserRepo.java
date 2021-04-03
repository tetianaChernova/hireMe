package com.chernova.hire.repo;

import com.chernova.hire.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface UserRepo extends JpaRepository<User, Long> {
	User findByUsername(String username);

	List<User> findAllByUsernameIn(List<String> username);

	User findByActivationCode(String code);

	@Query(value = "select u from User u where (u.cv.experience >= :experienceFilter) and (u.cv.mainTechnology like :technologyFilter)")
	List<User> findAllWithFilters(String technologyFilter, Integer experienceFilter);
}
