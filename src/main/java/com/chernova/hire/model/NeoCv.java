package com.chernova.hire.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.neo4j.ogm.annotation.GeneratedValue;
import org.neo4j.ogm.annotation.Id;
import org.neo4j.ogm.annotation.NodeEntity;
import org.neo4j.ogm.annotation.Relationship;

import java.util.HashSet;
import java.util.Set;

import static java.util.Objects.isNull;

@NodeEntity
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
public class NeoCv {
	@Id
	@GeneratedValue
	private Long id;

	private String username;

	private String mainTechnology;

	private Integer experience;

	@Relationship(type = "LIKED", direction = "INCOMING")
	public Set<NeoUser> likedBy;

	public void addRecruiter(NeoUser recruiter) {
		if (isNull(likedBy)) {
			likedBy = new HashSet<>();
		}
		likedBy.add(recruiter);
	}
}
