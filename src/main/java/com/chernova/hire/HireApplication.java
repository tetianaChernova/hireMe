package com.chernova.hire;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.neo4j.repository.config.EnableNeo4jRepositories;

@SpringBootApplication
@EnableNeo4jRepositories(basePackages = {"com.chernova.hire.repo"})
public class HireApplication {

	public static void main(String[] args) {
		SpringApplication.run(HireApplication.class, args);
	}

}
