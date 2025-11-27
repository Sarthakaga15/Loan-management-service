package com.delcapital.loanmgmt.config;

import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

import javax.sql.DataSource;

@Configuration
package com.delcapital.loanmgmt.config;

import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

import javax.sql.DataSource;

@Configuration
@Profile("prod")
public class DatabaseConfig {

    @Bean
    public DataSource dataSource() {
        String databaseUrl = System.getenv("DATABASE_URL");
        
        if (databaseUrl == null || databaseUrl.isEmpty()) {
            throw new IllegalStateException(
                "DATABASE_URL environment variable is not set. " +
                "Please connect the Postgres service to this service in Railway."
            );
        }
        
        // Railway provides postgres:// but JDBC needs postgresql://
        if (databaseUrl.startsWith("postgres://")) {
            databaseUrl = databaseUrl.replace("postgres://", "postgresql://");
        }
        
        return DataSourceBuilder
                .create()
                .url(databaseUrl)
                .driverClassName("org.postgresql.Driver")
                .build();
    }
}
