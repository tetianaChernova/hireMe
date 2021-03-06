package com.chernova.hire.service;

import com.chernova.hire.dto.ProfileEditDto;
import com.chernova.hire.model.CurriculumVitae;
import com.chernova.hire.model.NeoCv;
import com.chernova.hire.model.NeoUser;
import com.chernova.hire.model.Role;
import com.chernova.hire.model.User;
import com.chernova.hire.repo.NeoCvRepo;
import com.chernova.hire.repo.NeoUserRepo;
import com.chernova.hire.repo.UserRepo;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

import static java.util.Objects.isNull;
import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.BooleanUtils.isFalse;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.apache.commons.lang3.StringUtils.isEmpty;

@Service
public class UserService implements UserDetailsService {
	@Resource
	private UserRepo userRepo;
	@Resource
	private NeoUserRepo neoUserRepo;
	@Resource
	private NeoCvRepo neoCvRepo;
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

	public List<User> findAllByUsernames(List<String> usernames) {
		return userRepo.findAllByUsernameIn(usernames);
	}

	public boolean addUser(User user, boolean isRecruiter) {
		User userFromDb = userRepo.findByUsername(user.getUsername());
		if (nonNull(userFromDb)) {
			return false;
		}
		user.setActive(false);
		user.setRoles(isRecruiter ? Collections.singleton(Role.RECRUITER) : Collections.singleton(Role.USER));
		user.setActivationCode(UUID.randomUUID().toString());
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		if (!isRecruiter) {
			CurriculumVitae cv = CurriculumVitae.builder().user(user).build();
			user.setCv(cv);
		}
		userRepo.save(user);
		if (isFalse(isEmpty(user.getEmail()))) {
			sendActivationCodeMessage(user);
		}
		return true;
	}

	private void sendActivationCodeMessage(User user) {
		mailService.sendGreetingEmail(user);
	}

	public boolean activateUser(String code) {
		User user = userRepo.findByActivationCode(code);
		if (isNull(user)) {
			return false;
		}
		user.setActive(true);
		user.setActivationCode(null);
		userRepo.save(user);
		if (user.isRecruiter()) {
			NeoUser neoUser = NeoUser.builder()
					.username(user.getUsername())
					.build();
			neoUserRepo.save(neoUser);
		} else {
			NeoCv neoCv = NeoCv.builder()
					.username(user.getUsername())
					.mainTechnology(EMPTY)
					.experience(1)
					.build();
			neoCvRepo.save(neoCv);
		}
		return true;
	}

	public List<User> findAll(String technologyFilter, Integer experienceFilter) {
		return userRepo.findAllWithFilters("%" + technologyFilter + "%", experienceFilter);
	}

	public List<String> findAllLikedCvs(String username) {
		return neoUserRepo.getLikedCvs(username);
	}

	public User updateProfile(User user, ProfileEditDto profileEditDto) {
		user.setEmail(profileEditDto.getEmail());
		CurriculumVitae cv = user.getCv();
		cv.setFirstName(profileEditDto.getFirstName());
		cv.setLastName(profileEditDto.getLastName());
		cv.setCity(profileEditDto.getCity());
		cv.setNationality(profileEditDto.getNationality());
		cv.setDescription(profileEditDto.getDescription());
		cv.setPosition(profileEditDto.getPosition());
		cv.setTitle(profileEditDto.getTitle());
		cv.setPhone(profileEditDto.getPhone());
		if (!profileEditDto.getMainTechnology().equals(cv.getMainTechnology()) || !profileEditDto.getExperience().equals(cv.getExperience())) {
			NeoCv neoCv = neoCvRepo.findNeoCvByUsername(user.getUsername());
			if (nonNull(neoCv)) {
				neoCv.setMainTechnology(profileEditDto.getMainTechnology());
				neoCv.setExperience(profileEditDto.getExperience());
				neoCvRepo.save(neoCv);
			}
		}
		cv.setExperience(profileEditDto.getExperience());
		cv.setMainTechnology(profileEditDto.getMainTechnology());
		cv.setUser(user);
		user.setCv(cv);
		userRepo.save(user);
		return user;
	}

	public User findById(Long userId) {
		return userRepo.findById(userId).get();
	}

	public void likeCv(User user, Long candidateId) {
		User cvOwner = findById(candidateId);
		neoUserRepo.likeCv(user.getUsername(), cvOwner.getUsername());
		mailService.sendCandidateInformationEmail(user, cvOwner);
	}

	public void unlike(String username, String cvOwner) {
		neoUserRepo.unLikeCv(username, cvOwner);
	}

	public List<User> getRecommendationsForUser(String username, String technologyFilter, Integer experienceFilter) {
		return findAllByUsernames(neoUserRepo.findRecommendationsForUser(username, technologyFilter, experienceFilter));
	}
}

