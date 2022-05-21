package com.nb.spring.admin.controller;

import static com.nb.spring.common.MsgModelView.msgBuild;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.nb.spring.common.PageFactory;
import com.nb.spring.common.StringHandler;
import com.nb.spring.member.model.service.MemberService;
import com.nb.spring.member.model.vo.Member;
import com.nb.spring.product.model.service.ProductService;
import com.nb.spring.product.model.vo.Product;
import com.nb.spring.product.model.vo.ProductImage;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/productManage")
	public ModelAndView productManage(@RequestParam(name = "cPage",defaultValue = "1")int cPage,
			@RequestParam(value="numPerPage",defaultValue="5")int numPerPage,ModelAndView mv) {
		log.debug("{}",numPerPage);
		int pageBarSize = 3;
		int totalData = productService.selectWaitingCount();
		
		
		Map<String,Integer> param = Map.of("cPage",cPage,"numPerPage",numPerPage);
		
		List<Product> list = productService.selectWaitingPermission(param);
		
		mv.addObject("numPerPage",numPerPage);
		mv.addObject("waitList", list);
		mv.addObject("pageBar", PageFactory.getPageBar(totalData, cPage, numPerPage, pageBarSize, "/admin/productManage"));
		mv.setViewName("admin/productManage");
	
		return mv;
	}
	
	@RequestMapping("/productConfirmDetail")
	public ModelAndView productConfirmDetail(String productNo,ModelAndView mv) {
		log.debug(productNo);
		Product product = productService.selectOneProductNo(productNo);
		log.debug("{}",product);
		mv.addObject("product", product);
		mv.setViewName("detail/productConfirmDetail");
		return mv;
	}
	
	@RequestMapping("/permission")
	public ModelAndView permission(String productNo,ModelAndView mv) {
		log.debug(productNo);
		
		int result = productService.updateProductPermission(productNo);
		
		if(result>0) {
			mv = msgBuild(mv,"/admin/productManage", "승인완료");
		}else {
			mv = msgBuild(mv, "/admin/productManage", "ERROR - 처리 실패 ");
		}
		
		return mv;
		
		
	}
	
	@PostMapping("/reject")
	public ModelAndView reject(String productNo,@RequestParam(defaultValue = "거부") String rejectReason,ModelAndView mv) {
		log.debug("reject : "+productNo);
		log.debug("reject : "+rejectReason);
		
		Map<String,Object> param = Map.of("productNo",productNo,"rejectReason",rejectReason);
		
		int result = productService.updateProductReject(param);
		
		if(result>0) {
			mv = msgBuild(mv,"/admin/productManage", "처리완료");
		}else {
			mv = msgBuild(mv, "/admin/productManage", "ERROR - 처리 실패 ");
		}
		
		return mv;
	}
	
	@RequestMapping("/specialProductEnroll")
	public String specialPoduct() {
		
		return "admin/specialProductEnroll";
	}
	
	
	
	@PostMapping("/specialProductEnrollEnd")
	public ModelAndView specialProductEnrollEnd(@RequestParam Map<String,String>param, 
						@RequestParam(value="bannerImageFile",required=true) MultipartFile bannerImageFile,
						@RequestParam(value="imageFile",required = true) MultipartFile[] imageFiles, 
						ModelAndView mv,
						HttpSession session,
						HttpServletRequest req) throws Exception {
		
		log.debug("{}",param);
		log.debug("{}",bannerImageFile);
		log.debug("{}",imageFiles);
		
		//로그인한 상태인지 
		Member m = (Member)session.getAttribute("loginMember");
		
		if(!m.getNickName().equals("admin")) {
			return msgBuild(mv, "/", "관리자 계정 로그인후 이용해주세요");
		}
		
		
	
		String bidPrice = StringHandler.removeComma(param.get("minBidPrice"));
		
		log.debug("bidPrice : " +bidPrice);
		
		
		String bidUnit = param.get("bidUnit");
		if(bidUnit=="typing") {
			bidUnit = param.get("bidUnitInput");
		}
		
		

		
		String dateStr = param.get("startDate")+" "+param.get("startTime");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		

		Date startDate = sdf.parse(dateStr);
		
		java.sql.Date startSqlDate = new java.sql.Date(startDate.getTime());
		
		Product product = Product.builder()
				.productCategory(param.get("category"))
				.productName(param.get("productName"))
				.productContent(param.get("productContent"))
				.seller(m)
				.nowBidPrice("0")
				.minBidPrice(bidPrice)
				.bidUnit(bidUnit)
				.buyNowPrice("0")
				.extendYn("N")
				.startDate(startSqlDate)
				.endDate(startSqlDate)
				.images(new ArrayList<ProductImage>()).build();
			
		
		
		//-----------file
		String path = req.getServletContext().getRealPath("/resources/upload/product/");
		File f= new File(path);
		
		if(!f.exists()) f.mkdir();
		
		
		String oriName = bannerImageFile.getOriginalFilename();
		String ext2 = oriName.substring(oriName.lastIndexOf("."));
		
		SimpleDateFormat sdf3 = new SimpleDateFormat("ddMMyyHHmmssss");
		int randNum = (int)(Math.random()*1000);
		String renameFile2 = sdf3.format(System.currentTimeMillis())+"_"+randNum+ext2;
		try {
			bannerImageFile.transferTo(new File(path+renameFile2));
			product.setBannerImageName(renameFile2);
			log.debug(renameFile2);
		}catch(IOException e) {
			e.printStackTrace();
		}
		
		
		
		for(MultipartFile mf: imageFiles) {
			if(!mf.isEmpty()) {
				String originalFileName = mf.getOriginalFilename();
				String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
				
				SimpleDateFormat sdf2 = new SimpleDateFormat("ddMMyyHHmmssss");
				int ranNum = (int)(Math.random()*1000);
				String renameFile = sdf2.format(System.currentTimeMillis())+"_"+ranNum+ext;
				
				try {
					mf.transferTo(new File(path+renameFile));
					ProductImage productImage = ProductImage.builder().imageName(renameFile).build();
					product.getImages().add(productImage);
				}catch(IOException e) {
					e.printStackTrace();
				}
				
			}
		}
		
		int result= productService.insertProduct(product);
		
		if(result>0) {
			return msgBuild(mv, "/admin/specialProductEnroll", "물품등록이 정상적으로 완료되었습니다.");
		}else {
			return msgBuild(mv, "/admin/specialProductEnroll", "물품등록에 실패 - 다시시도 ~!");
		}
	
	}
	
	@RequestMapping("/adminMain")
	public String adminMainView() {
		return "admin/adminMain";
	}
	
	@RequestMapping("/memberManagement")
	public ModelAndView memberManageMent(@RequestParam Map param, ModelAndView mv) {
		
		if(!param.containsKey("type")) param.put("type", 1);
		
		
		
		List<Member> memberList = memberService.selectMemberList(param);
		
		mv.addObject("memberList",memberList);
		mv.setViewName("admin/memberManagement");
		return mv;
	}
	
	
}
