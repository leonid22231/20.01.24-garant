package com.thedeveloper.garant;


import com.thedeveloper.garant.util.storage.DealImageProperties;
import com.thedeveloper.garant.util.storage.DocumentProperties;
import com.thedeveloper.garant.util.storage.ImageProperties;
import com.thedeveloper.garant.util.storage.StorageService;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;

import java.io.IOException;


@SpringBootApplication
@EnableConfigurationProperties({DocumentProperties.class, ImageProperties.class, DealImageProperties.class})
public class GarantApplication extends SpringBootServletInitializer {
	public static void main(String[] args) throws IOException {
		SpringApplication.run(GarantApplication.class, args);

	}
	@Bean
	CommandLineRunner init(@Qualifier("documentFileService") StorageService storageService) {
		return (args) -> {
			storageService.init();
		};}
	@Bean
	CommandLineRunner init2(@Qualifier("imageService") StorageService storageService) {
		return (args) -> {
			storageService.init();
		};}
	@Bean
	CommandLineRunner init3(@Qualifier("dealsFilesService") StorageService storageService) {
		return (args) -> {
			storageService.init();
		};}
}
