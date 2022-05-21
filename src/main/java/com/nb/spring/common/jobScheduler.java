package com.nb.spring.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.nb.spring.common.constant.ConstantVal;
import com.nb.spring.product.model.service.ProductService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class jobScheduler {
	
	@Autowired
	private ProductService productService;
	
	//@Scheduled(cron = "0 15 10 15 * ?")         //첫번째 부터 초(0-59) 분(0-59) 시간(0-23) 일(1-31) 월(1-12) 요일(0-7)
	@Scheduled(fixedDelay = ConstantVal.SCHEDULER_FIXED_DELAY, initialDelay = ConstantVal.SCHEDULER_INITIAL_DELAY)
	public void secheduleEndDate() {
		int result = productService.updateStatusFailure();
		int result2 = productService.successfulBidUpdate();
	}
}
