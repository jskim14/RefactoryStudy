package com.nb.spring;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.EnableScheduling;

import com.nb.spring.common.filter.DirectAccessFilter;

@EnableScheduling
@SpringBootApplication
public class Gdj41NbifFinalApplication extends SpringBootServletInitializer{

	public static void main(String[] args) {
		SpringApplication.run(Gdj41NbifFinalApplication.class, args);
	}
	
	@Bean
	public FilterRegistrationBean setFilterRegistration() {
		FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean(new DirectAccessFilter());
		
		filterRegistrationBean.addUrlPatterns("/product/*");
		filterRegistrationBean.addUrlPatterns("/member/*");
		filterRegistrationBean.addUrlPatterns("/report/*");
		filterRegistrationBean.addUrlPatterns("/admin/*");
		
		return filterRegistrationBean;
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
	return application.sources(Gdj41NbifFinalApplication.class);
	}

	
}
