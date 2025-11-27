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

        if (databaseUrl != null && databaseUrl.startsWith("postgres://")) {
            // Railway provides postgres:// but JDBC needs postgresql://
            databaseUrl = databaseUrl.replace("postgres://", "postgresql://");
        }

        return DataSourceBuilder
                .create()
                .url(databaseUrl)
                .build();
    }
}
