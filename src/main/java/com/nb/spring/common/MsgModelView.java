package com.nb.spring.common;

import org.springframework.web.servlet.ModelAndView;

public class MsgModelView {
	public static ModelAndView msgBuild(ModelAndView mv, String loc, String msg) {
		
		mv.addObject("msg",msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");
		
		return mv;
	}
}
