package com.chernova.hire.repo;

import com.chernova.hire.model.NeoCv;
import org.springframework.data.neo4j.repository.Neo4jRepository;

public interface NeoCvRepo extends Neo4jRepository<NeoCv, Long> {

	NeoCv findNeoCvByUsername(String username);
}
