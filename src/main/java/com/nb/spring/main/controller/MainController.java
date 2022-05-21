package com.nb.spring.main.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.nb.spring.common.PageFactory;
import com.nb.spring.member.model.service.MemberService;
import com.nb.spring.member.model.vo.Member;
import com.nb.spring.member.model.vo.MessageBox;
import com.nb.spring.product.model.service.ProductService;
import com.nb.spring.product.model.vo.Product;

@Controller
@SessionAttributes({"specialProduct"})
public class MainController {
	
	@Autowired
	private ProductService service;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/")
	public ModelAndView mainView(ModelAndView mv) {
		int startNum = 0;
		int finishNum = 3;
		
		mv.addObject("specialProductList", service.selectSpecialProductList());
		mv.addObject("deadLine", service.selectListDeadLine(startNum, finishNum));
		mv.addObject("latest", service.selectListLatest(startNum, finishNum));
		mv.addObject("highPrice",service.selectListHighPrice(startNum, finishNum));
		mv.setViewName("index");
		return mv;
	}
	
	@RequestMapping("/addLatest")
	public void addLatest(int startNum, int finishNum, HttpServletResponse res) throws IOException {
		List<Product> list = service.selectListLatest(startNum,finishNum);
		res.setContentType("application/json; charset=utf-8");
		new Gson().toJson(list, res.getWriter());
	}
	
	@RequestMapping("/addDeatLine")
	public void addDeatLine(int startNum, int finishNum, HttpServletResponse res) throws IOException {
		List<Product> list = service.selectListDeadLine(startNum,finishNum);
		res.setContentType("application/json; charset=utf-8");
		new Gson().toJson(list, res.getWriter());
	}
	
	@RequestMapping("/addHighPirce")
	public void addHighPirce(int startNum, int finishNum, HttpServletResponse res) throws IOException {
		List<Product> list = service.selectListHighPrice(startNum,finishNum);
		res.setContentType("application/json; charset=utf-8");
		new Gson().toJson(list, res.getWriter());
	}
	
	@RequestMapping("/productSearch")
	public ModelAndView searchProduct(ModelAndView mv, String keyword,
			@RequestParam(value="cPage", defaultValue="1") int cPage
			,@RequestParam(value="numPerPage", defaultValue="16") int numPerPage
			,@RequestParam(value="category", defaultValue="all")String category) {
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("cPage", cPage);
		param.put("numPerPage", numPerPage);
		param.put("keyword", keyword);
		param.put("category", category);
		List<Product> totalDataCount = service.searchProductCount(param);
		int totalData = totalDataCount.size();
		int pageBarSize = 5;
		if(totalData>0) {
			mv.addObject("pageBar", PageFactory.getPageBarSearch(totalData, cPage, numPerPage, pageBarSize));
		}
		mv.addObject("searchProduct", service.searchProduct(param));
		mv.addObject("keyword", keyword);
		mv.addObject("totalData", totalData);
		mv.addObject("category", category);
		mv.setViewName("/product/searchProduct");
		return mv;
	}
	
	@RequestMapping("/member/messagebox")
	public ModelAndView messageBox(String memberNo, ModelAndView mv,
			@RequestParam(value = "msgbox", defaultValue = "receiv")String msgbox,
			@RequestParam(value = "cPage", defaultValue = "1") int cPage
			,@RequestParam(value = "numPerPage", defaultValue = "10") int numPerPage) {
		int pageBarSize = 5;
		List<MessageBox> list = new ArrayList<MessageBox>();
		int totalData = 0;
		int noCheckMsg = 0;
		if(msgbox.equals("receiv")) {
			list = memberService.messageReceivList(memberNo, cPage, numPerPage);
			totalData = memberService.messageReceivListCount(memberNo);
			noCheckMsg = memberService.noCheckMsgCount(memberNo);
		}else {
			list = memberService.messageSendList(memberNo, cPage, numPerPage);
			totalData = memberService.messageSendListCount(memberNo);
		}
		mv.addObject("msgbox", msgbox);
		mv.addObject("noCheckMsg", noCheckMsg);
		mv.addObject("totalData", totalData);
		mv.addObject("messageList", list);
		mv.addObject("pageBar", PageFactory.getPageBarMessageBox(totalData, cPage, numPerPage, pageBarSize, "/member/messagebox", msgbox, memberNo));
		mv.setViewName("member/messagebox");
		return mv;
	}
	
	@RequestMapping("/member/messageboxView")
	public ModelAndView messageboxView(ModelAndView mv,int msgNo,String msgbox) {
		if(msgbox.equals("receiv")) {
			memberService.messageOneCheck(msgNo);
		}
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("msgNo", msgNo);
		param.put("msgbox", msgbox);
		mv.addObject("messageOne",memberService.messageOne(param));
		mv.addObject("msgbox",msgbox);
		mv.setViewName("member/messageboxView");
		return mv;
	}
	
	@RequestMapping("/member/sendMessage")
	public ModelAndView sendMessage(ModelAndView mv,
			@RequestParam(value="nickName", required = false) String nickName) {
		mv.addObject("member", memberService.selectMemberNickName(nickName));
		mv.setViewName("member/sendMessage");
		return mv;
	}
	
	@PostMapping("/member/sendMessageEnd")
	@ResponseBody
	public boolean sendMessageEnd(String receiver,String senderNo, String msgContent) {
		boolean flag = false;
		Member m = memberService.selectMemberNickName(receiver);
		if(m!=null) {
			MessageBox mb = new MessageBox();
			mb.setMsgContent(msgContent);
			Member sender = new Member();
			sender.setMemberNo(senderNo);
			mb.setSender(sender);
			mb.setReceiver(m);
			System.out.println(mb);
			int result = memberService.insertMessageBox(mb);
			if(result>0) flag = true;
		}
		return flag;
	}
	
	@PostMapping("/member/deleteMessageBox")
	@ResponseBody
	public boolean deleteMessageBox(
			@RequestParam(value="msgNo[]", required = false)List<Integer> msgNoArr,
			@RequestParam(value="msgNoOne", required = false, defaultValue = "1")int msgNo,
			String msgbox) {
		boolean flag = false;
		if(msgNoArr != null) {
			int result = memberService.deleteMessageBoxList(msgNoArr, msgbox);
			if(result>0) flag = true;
		}else {
			int result = memberService.deleteMessageBoxOne(msgNo, msgbox);
			if(result>0) flag = true;
		}
		return flag;
	}
	
	@RequestMapping("/auctions")
	public ModelAndView auctionItems(ModelAndView mv,
			@RequestParam(value="cPage", defaultValue="1") int cPage
			,@RequestParam(value="numPerPage", defaultValue="16") int numPerPage
			,@RequestParam(value="category", defaultValue="all")String category) {
		int pageBarSize = 5;
		int totalData = service.auctionItemsListCount(category);
		List<Product> list = service.auctionItemsList(cPage, numPerPage , category);
		System.out.println(totalData);
		mv.addObject("pageBar", PageFactory.getPageBarSearch(totalData, cPage, numPerPage, pageBarSize));
		mv.addObject("auctionItems", list);
		mv.addObject("category", category);
		mv.setViewName("product/auctionItems");
		return mv;
	}
	
	@RequestMapping("/specialauction")
	public ModelAndView specialauction(ModelAndView mv,
			@RequestParam(value="cPage", defaultValue="1") int cPage
			,@RequestParam(value="numPerPage", defaultValue="16") int numPerPage
			,@RequestParam(value="category", defaultValue="all")String category) {
		int pageBarSize = 5;
		int totalData = service.specialauctionListCount();
		List<Product> list = service.specialauctionList(cPage, numPerPage);
		System.out.println(list);
		String msg = "";
		String loc = "";
		if(list.isEmpty()) {
			mv.setViewName("common/msg");
			loc = "/";
			msg = "준비중인 실시간경매 물품이 없습니다.";
			mv.addObject("loc", loc);
			mv.addObject("msg",msg);

		}else {
			mv.setViewName("product/specialAuction");
			mv.addObject("specialauction", list);
		}
		mv.addObject("category", category);
		mv.addObject("pageBar", PageFactory.getPageBarSearch(totalData, cPage, numPerPage, pageBarSize));
		return mv;
	}
}

