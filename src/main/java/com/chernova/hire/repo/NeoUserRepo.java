package com.chernova.hire.repo;

import com.chernova.hire.model.NeoCv;
import com.chernova.hire.model.NeoUser;
import org.springframework.data.neo4j.annotation.Query;
import org.springframework.data.neo4j.repository.Neo4jRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface NeoUserRepo extends Neo4jRepository<NeoUser, Long> {

	@Query("MATCH (user:NeoUser { username: username })-->(cvs)\n" +
			"RETURN cvs")
	List<NeoCv> getLikedCvs(@Param("username") String name);

	NeoUser findNeoUserByUsername(String username);
}
