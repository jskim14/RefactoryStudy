package com.nb.spring.report.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.nb.spring.common.PageFactory;
import com.nb.spring.member.model.vo.Member;
import com.nb.spring.product.model.vo.Product;
import com.nb.spring.report.model.service.ReportService;
import com.nb.spring.report.model.vo.Report;
import com.nb.spring.report.model.vo.ReportImage;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/report")
public class ReportController {

	@Autowired
	private ReportService service;
	
	
	@RequestMapping("/reportList")
	public ModelAndView selectReportList(
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerPage", defaultValue="10") int numPerPage,
			ModelAndView mv) {
		List<Report> reportList=service.selectReportList(cPage,numPerPage);
		int totalReport=service.reportCount();
		mv.addObject("pageBar",PageFactory.getPageBar(totalReport, cPage, numPerPage, 5, "/report/reportList"));
		
		mv.addObject("reportList",reportList);
		mv.addObject("report/reportList");
		System.out.println("가져온 리스트"+reportList);
		return mv;
	}
	
	@RequestMapping(value="/insertReport", method=RequestMethod.POST)
	public ModelAndView insertReport(Report r, String product, String writer, ModelAndView mv,
			@RequestParam(value="upFile", required=false) MultipartFile[] upFile,
			HttpServletRequest req) throws Exception{
		
		System.out.println("가져온상품번호"+product);
		System.out.println("가져온작성자"+writer);
		
		r.setReportProduct(new Product());
		r.getReportProduct().setProductNo(product);
		r.setReportMember(new Member());
		r.getReportMember().setMemberNo(writer);
		
		System.out.println("넣은거"+r);
		
		//File upload
		String path=req.getServletContext().getRealPath("/resources/upload/report/");
		File f=new File(path);
		if(!f.exists()) f.mkdirs(); //create a folder
		r.setReportImages(new ArrayList<ReportImage>());
		for(MultipartFile mf: upFile) {
			if(!mf.isEmpty()) {
				//create file
				String orignalFileName=mf.getOriginalFilename();
				//확장자
				String ext=orignalFileName.substring(orignalFileName.lastIndexOf("."));
				//rename rule
				SimpleDateFormat sdf=new SimpleDateFormat("ddMMyyHHmmsssss");
				int rndNum=(int)(Math.random()*1000);
				
				String renameFile=sdf.format(System.currentTimeMillis())+"_"+rndNum+ext;
				
				//save renamed file using method of MultipartFile Class
				try {
					mf.transferTo(new File(path+renameFile));
					ReportImage ri=ReportImage.builder().fileName(renameFile).build();
					r.getReportImages().add(ri);
				}catch(IOException e) {
					e.printStackTrace();
				}
				
			}
		}
		System.out.println("이미지이름"+r.getReportImages());
		int result=service.insertReport(r);
		int result2;
		String msg="";
		String loc="";
		if(result>0) {
			result2=service.changeStatus(r.getReportProduct().getProductNo());
			if(result2>0) {
				msg="신고 완료 하였습니다.";
				loc="/";
			}else {
				msg="신고 실패";
				loc="/";
			}
		}else {
			msg="신고 실패";
			loc="/";
		}
		
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		
		return mv;
	}
	
	@RequestMapping("/insertReportReason")
	public ModelAndView insertReportResult(ModelAndView mv, String productNo, String reportResult) {
		Map<String,String> param= Map.of("productNo",productNo, "reportResult",reportResult);
		int result=service.insertReportResult(param);
		
		String msg="";
		String loc="/report/reportList";
		if(result>0) {
			msg="신고결과 등록 완료";
		}else {
			msg="신고결과 등록 실패";
		}
		
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		return mv;
	}
	
	@PostMapping("/reportCon")
	@ResponseBody
	public void reportCon(String productNo, HttpServletResponse res) throws IOException {
		Report r = service.reportCon(productNo);
		res.setContentType("application/json; charset=utf-8");
		new Gson().toJson(r, res.getWriter());
	}
	
}
