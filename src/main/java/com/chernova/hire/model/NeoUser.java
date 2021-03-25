package com.chernova.hire.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
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
public class NeoUser {
	@Id
	private String username;

	@Relationship(type = "LIKED")
	public Set<NeoCv> likedCvs;

	public void follows(NeoCv cv) {
		if (isNull(likedCvs)) {
			likedCvs = new HashSet<>();
		}
		likedCvs.add(cv);
	}
}
