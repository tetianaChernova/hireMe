package com.chernova.hire.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.MapsId;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@NoArgsConstructor
@AllArgsConstructor
@Entity
@Getter
@Setter
@Builder
@Table(name = "cv")
public class CurriculumVitae {
	@Id
	@Column(name = "user_id")
	private Long id;
	private String firstName;
	private String lastName;
	private String phone;
	private String position;
	private String title;
	@Column(length = 2048)
	private String description;
	private Integer experience;
	private String nationality;
	private String city;
	@OneToOne
	@MapsId
	@JoinColumn(name = "user_id")
	private User user;
}
