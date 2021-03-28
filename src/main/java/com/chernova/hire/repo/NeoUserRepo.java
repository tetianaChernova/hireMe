package com.chernova.hire.repo;

import com.chernova.hire.model.NeoUser;
import org.springframework.data.neo4j.annotation.Query;
import org.springframework.data.neo4j.repository.Neo4jRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface NeoUserRepo extends Neo4jRepository<NeoUser, Long> {

	@Query("MATCH (user:NeoUser { username: $username })-->(cvs) RETURN cvs.username")
	List<String> getLikedCvs(@Param("username") String name);

	NeoUser findNeoUserByUsername(String username);

	@Query("MATCH (a:NeoUser),(b:NeoCv) WHERE a.username = $username AND b.username = $cvOwner " +
			"CREATE (a)-[r:LIKED { name: a.username + '<->' + b.username }]->(b) RETURN type(r), r.username")
	void likeCv(@Param("username") String username, @Param("cvOwner") String cvOwner);

	@Query("MATCH (:NeoUser {username: $username})-[r:LIKED]-(:NeoCv {username: $cvOwner}) DELETE r")
	void unLikeCv(@Param("username") String username, @Param("cvOwner") String cvOwner);
}
