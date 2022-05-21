package com.nb.spring.cs.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.nb.spring.common.PageFactory;
import com.nb.spring.cs.model.service.CustomerServiceService;
import com.nb.spring.cs.model.vo.Notice;
import com.nb.spring.cs.model.vo.Qna;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/cs")
public class CustomerServiceController {

	@Autowired
	private CustomerServiceService service;
	
//	@RequestMapping("/customerServiceList")
//	@ResponseBody
//	public void selectCsList(HttpServletResponse response, 
//			@RequestParam(value="choice", defaultValue="1") String choice) throws IOException{
//		
//		System.out.println("카테고리 도착 "+choice);
//		List<Notice> noticeList=null;
//		List<Qna> qnaList=null;
//		Gson gson=new Gson();
//		
//		switch(choice) {
//		case "1": 
//			noticeList=service.selectNoticeList();
//			response.setContentType("application/json; charset=utf-8");
//			gson.toJson(noticeList, response.getWriter());
//			break;
//		case "2": 
//			qnaList=service.selectQnaList(); 
//			response.setContentType("application/json; charset=utf-8");
//			gson.toJson(qnaList, response.getWriter());
//			break;
//		}
//		
//		System.out.println(noticeList);
//		System.out.println(qnaList);
//		
//	}
	
	@RequestMapping("/noticeList")
	public ModelAndView noticeView(
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerPage", defaultValue="5") int numPerPage,
			ModelAndView mv) {
		List<Notice> noticeList=service.selectNoticeList(cPage,numPerPage);
		
		int totalNotice=service.noticeCount();
		mv.addObject("totalNotice",totalNotice);
		mv.addObject("pageBar", PageFactory.getPageBar(totalNotice,cPage,numPerPage,5,"noticeList"));
		
		mv.addObject("noticeList",noticeList);
		mv.setViewName("cs/notice");
		return mv;
	}
	@RequestMapping("/qnaList")
	public ModelAndView qnaView(
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerPage", defaultValue="5") int numPerPage,
			ModelAndView mv) {
		List<Qna> qnaList=service.selectQnaList(cPage,numPerPage);
		int totalQna=service.qnaCount();
		mv.addObject("totalQna",totalQna);
		mv.addObject("pageBar", PageFactory.getPageBar(totalQna, cPage, numPerPage, 5, "qnaList"));
		
		mv.addObject("qnaList",qnaList);
		mv.setViewName("cs/qna");
		return mv;
	}
	
	
	@RequestMapping("/insertNotice")
	public ModelAndView insertNotice(ModelAndView mv, String noticeTitle, String noticeContent, String memberNo) {
		
		Map<String,String> param= Map.of("noticeTitle",noticeTitle, "noticeContent",noticeContent, "memberNo",memberNo);
		
		int result=service.insertNotice(param);
		String msg="";
		String loc="";
		if(result>0) {
			msg="공지사항 등록 완료";
			loc="/cs/noticeList";
		}else{
			msg="공지사항 등록 실패";
			loc="/cs/noticeList";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		return mv;
	}
	@RequestMapping("/insertQuestion")
	public ModelAndView insertQuestion(ModelAndView mv, String qnaTitle, String qnaContent, String memberNo) {
		System.out.println("넘어온 데이터"+memberNo);
		
		Map<String,String> param2= Map.of("qnaTitle",qnaTitle, "qnaContent",qnaContent, "memberNo",memberNo);
		
		int result=service.insertQuestion(param2);
		String msg="";
		String loc="";
		if(result>0) {
			msg="문의사항 등록 완료";
			loc="/cs/qnaList";
		}else{
			msg="문의사항 등록 실패";
			loc="/cs/qnaList";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		return mv;
	}
	
	@RequestMapping("/deleteNotice")
	public ModelAndView deleteNotice(int noticeNo, ModelAndView mv) {
		
		int result=service.deleteNotice(noticeNo);
		String msg="";
		String loc="";
		if(result>0) {
			msg="삭제 완료";
			loc="/cs/noticeList";
		}else{
			msg="삭제 실패";
			loc="/cs/noticeList";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		return mv;
		
	}
	
	@RequestMapping("/qnaContent")
	public ModelAndView qnaContent(int qnaNo, ModelAndView mv) {
		mv.addObject("qna", service.qnaContent(qnaNo));
		mv.setViewName("cs/qnaContent");
		return mv;
	}
	
	@RequestMapping("/insertAnswer")
	public ModelAndView insertAnswer(ModelAndView mv, String qnaNo, String qnaAnswer ) {
		System.out.println("넘어온 데이터: "+qnaNo+qnaAnswer);
		
		Map<String,String> param= Map.of("qnaNo",qnaNo, "qnaAnswer",qnaAnswer);
		int result=service.insertAnswer(param);
		
		String msg="";
		String loc="/cs/qnaContent?qnaNo="+qnaNo;
		if(result>0) {
			msg="답변 등록 완료";
		}else {
			msg="답변 등록 실패";
		}
		
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		return mv;
	}
	
	@RequestMapping("/myQna")
	public ModelAndView myQnaView(ModelAndView mv, String memberNo) {
		List<Qna> myQnaList=service.myQnaList(memberNo);
		
		mv.addObject("myQnaList",myQnaList);
		mv.setViewName("cs/myQna");
		return mv;
	}
	
}
