package com.care.root.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
@Configuration
public class FileConfig {
	
	    @Bean
	    public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver commons_multipart_resolver = new CommonsMultipartResolver();
		commons_multipart_resolver.setMaxUploadSize(52428800); //50MB
		commons_multipart_resolver.setDefaultEncoding("utf-8");
		return commons_multipart_resolver;
		
    }
    
}
