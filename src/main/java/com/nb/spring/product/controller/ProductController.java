package com.nb.spring.product.controller;


import static com.nb.spring.common.MsgModelView.msgBuild;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.nb.spring.common.DealType;
import com.nb.spring.common.ProductType;
import com.nb.spring.common.WalletType;
import com.nb.spring.member.model.service.MemberService;
import com.nb.spring.member.model.vo.Member;
import com.nb.spring.product.model.service.ProductService;
import com.nb.spring.product.model.vo.Product;
import com.nb.spring.product.model.vo.ProductImage;
import com.nb.spring.product.model.vo.Review;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/product")
public class ProductController {

	private final ProductService productService;
	private final MemberService memberService;
	
	List<Product> cookieList = new ArrayList<>();

	@RequestMapping("/productDetail")
	public ModelAndView productDetail(@RequestParam String productNo, HttpSession session, ModelAndView mv,
			HttpServletResponse res, HttpServletRequest req) {

		System.out.println(productNo);
		
		Member loginMember = (Member)session.getAttribute("loginMember");
		Product product = productService.selectOneProductNo(productNo);
		
		if(product==null) return msgBuild(mv, "/", "ERROR-제품번호");
		
		List<Product> otherList = productService.selectOtherList(product.getSeller().getMemberNo());
		mv.addObject("otherList",otherList);
		boolean isGeneral = true;
		if(product.getBannerImageName()==null||product.getBannerImageName().length()<=0) {
			//일반 판매 상품 
			isGeneral =true;
		}else {
			//실시간 경매 상품 
			isGeneral = false;
		}
		
		long now = new Date().getTime();
		long endDate = product.getEndDate().getTime();
		
		long gap = now-endDate;
		
		boolean isSell = false;
		
		if(gap>=0) {
			//기한 만료 
			isSell = false;
		}else {
			// 진행중 
			isSell = true;
		}
		
		mv.addObject("isGeneral",isGeneral);
		mv.addObject("isSell",isSell);
		
		
		
		if(loginMember!=null) {
			Map<String, String> param = Map.of("productNo",product.getProductNo(),"memberNo",loginMember.getMemberNo());
			int result = productService.selectWishList(param);
			
			if(result >0) {
				mv.addObject("isWishList",true);
			}else {
				mv.addObject("isWishList",false);
			}
		}
		
		List<Map<String, String >> list = productService.selectBidderList(product.getProductNo());
		
		mv.addObject("bidderList",list);
		
		
//		----------------------------------
		//productNum
		Cookie[] cookies = req.getCookies();
		String read="";
		boolean isRead = false;
		
		if(cookies != null) {
			for(Cookie c : cookies) {
				if(c.getName().equals("productNum")) {
					read = c.getValue();
					if(c.getValue().contains("|"+productNo)) {
						isRead = true;
						break; 
					}
				}
			}
		}
		if(!isRead) {
			Cookie view = new Cookie("productNum",read+"|"+productNo);
			view.setMaxAge(60*60*24);
			res.addCookie(view);
		}
//		----------------------------------
		
		
		System.out.println(product);
		mv.addObject("product", product);
		mv.setViewName("detail/productDetail");
		return mv;
	}

	
	@RequestMapping("/insertProduct")
	public String insertProduct() {
		return "/product/insertProduct";
	}
	
	@RequestMapping(value =  "/insertProductEnd", method=RequestMethod.POST)
	public ModelAndView insertProductEnd(ModelAndView mv, Product p,
			 String sellerNo, String maxDate, String maxTime, String unit,
			 @RequestParam(value = "imageFile", required = false) MultipartFile[] imageFile, HttpServletRequest req) throws Exception {

		System.out.println("시작가 : "+p.getMinBidPrice());
		System.out.println("즉구 : "+p.getBuyNowPrice());
		System.out.println(p.getBuyNowPrice().equals("")?true:false);
		System.out.println(p);
		
		//buynow
		if(p.getBuyNowPrice().equals("")) {
			p.setBuyNowPrice("0");
		}
		
		//date 
		String date = maxDate+" "+maxTime;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date utilDate = sdf.parse(date);
		java.sql.Date endDate = new java.sql.Date(utilDate.getTime());
		p.setEndDate(endDate);
		
		//seller 
		p.setSeller(new Member());
		p.getSeller().setMemberNo(sellerNo);
		
		System.out.println("unit:"+ unit);
		//bidUnit
		if(unit.contains("typing")) {
			String splitUnit[] = unit.split(",");
			p.setBidUnit(splitUnit[1]);
		} else {
			String splitUnit[] = unit.split(",");
			p.setBidUnit(splitUnit[0]);
		}
		
		//file
		String path = req.getServletContext().getRealPath("/resources/upload/product/"); 
		File f = new File(path);
		if(!f.exists()) f.mkdir();
		p.setImages(new ArrayList<ProductImage>());
		for(MultipartFile mf : imageFile) {
			if(!mf.isEmpty()) {
				String originalFileName = mf.getOriginalFilename();
				String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
				
				SimpleDateFormat sdf2 = new SimpleDateFormat("ddMMyyHHmmssss"); 
				int ranNum = (int)(Math.random()*1000);
				String renameFile = sdf2.format(System.currentTimeMillis())+"_"+ranNum+ext;
				try {
					mf.transferTo(new File(path+renameFile));
					ProductImage pi = ProductImage.builder().imageName(renameFile).build();
					p.getImages().add(pi);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		int result= productService.insertProduct(p);
		
		String msg = "";
		String loc = "";
		
		if(result>0) {
			msg = "물품등록이 정상적으로 요청되었습니다.";
			loc = "/";
		}else {
			msg = "물품등록에 실패하였습니다. 관리자에게 문의하세요.";
			loc = "/product/insertProduct";
		}
		
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("/common/msg");
		return mv;
	}

	@RequestMapping("/realtimeaction")
	public ModelAndView realtimeaction(ModelAndView mv, String productNo) {
		mv.addObject("productOne", productService.selectOneProductNo(productNo));
		mv.setViewName("detail/productRealTimeAction");
		return mv;
	}
	
	@RequestMapping("/endProductAction")
	@ResponseBody
	public String endProductAction(String nickName, int price, String productNo, HttpServletResponse res) throws IOException {
		String msg = "";
		Member m = memberService.findMember(nickName);
		Map<String,Object> param = Map.of("memberNo",m.getMemberNo(),"price",price,"productNo",productNo);
		int resultWal = memberService.endRealTimeActionWallet(param);
		if(resultWal>0) {
			int resultPro = productService.endSellRealTimeAction(param);
			if(resultPro>0) {
				int result = memberService.memberBalanceUpdate(param);
				if(result>0) {
					msg = "실시간 경매가 종료되었습니다!";					
				}
			}
		}else {
			
		}
		return msg;
	}

	@RequestMapping("/checkBuyNow")
	public void checkBuyNow(@RequestParam(value = "productNo") String productNo, HttpServletRequest req,
			HttpServletResponse response) throws IOException {
		log.debug(productNo);

		Product product = productService.selectOneProductNo(productNo);

		boolean isBuy = true;

		if (product != null) {
			// 제품명의 제품이 있음
			if (product.getFinalPrice() == null) {
				// 최종낙찰가가 없음 -> 구매불가
				isBuy = false;
			} else {
				// 구매가능
				isBuy = true;
			}
		}

		response.setContentType("application/json;charset=utf-8");
		response.getWriter().print(isBuy);

	}
	
	
	@PostMapping("/buyNowEnd")
	public ModelAndView buyNowEnd(@RequestParam Map<String,String> param,HttpSession session,ModelAndView mv) {
		
		//기본주소/배송주소 / 새로 입력한 주소 
		String radio = param.get("radioAddressCheck");
		String productNo = param.get("productNo");
		String shipAddress = param.get("shipAddress");
		String phone = param.get("phone");
		String name = param.get("name");
		
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		if(loginMember==null) {   //로그인 상태 아님
			return msgBuild(mv, "/", "로그인후 이용해주세요");
		}
		
		
		Product product = productService.selectOneProductNo(productNo);
		Member m = memberService.selectMember(loginMember.getMemberNo());
		
		
		if(Integer.parseInt(product.getProductStatus())!=ProductType.SELLING.ordinal()) {
			return msgBuild(mv,"/","입찰중인 상품이 아닙니다.");
		}
		
		
		//사용자 잔고 
		int balance = Integer.parseInt(m.getBalance());
		//제품 즉시 구매가 
		int buyNowPrice = Integer.parseInt(product.getBuyNowPrice());
		
		if(balance<buyNowPrice) {
			return msgBuild(mv, "/", "잔고 부족");
		}
		
		
		
		String finalDeliveryAddress="";
		
		if(radio.equals("ship")) {
			//배송주소 클릭
			String userShipAddress = m.getDeliveryAddress();
			
			if(shipAddress.equals(userShipAddress)) {
				//저장된 배송 주소
				finalDeliveryAddress = m.getDeliveryAddress();
			}else {
				//새로 입력
				finalDeliveryAddress= shipAddress;
			}
		}else {
			//기본주소 
			finalDeliveryAddress= m.getAddress();
		}
		
		Map<String,String> param2= Map.of("deliveryAddress",finalDeliveryAddress,"memberNo",m.getMemberNo());
		int result = memberService.updateDeliveryAddress(param2);
		
		if(result<=0) {
			return msgBuild(mv, "/", "Address Update Failure");
		}
		
		//통과
		
		//END DATE -> SYSDATE
		//FINALPRICE -> 즉시 구매가 
		// WALLET
		//PRODUCTSTATUS -> 1 
		//HIGHESTBIDDER -> 구매자 
		
		result = exeBuyNow(m,product);
		log.debug("{}",param);
	
		if(result>0) {
			return msgBuild(mv,"/","구매 완료");
		}else {
			return msgBuild(mv,"/","구매 실패-관리자에게 문의하세요!");
		}
		
	}
	
	private int exeBuyNow(Member m , Product p) {
		
		Map<String,Object> param = Map.of(
					"highestBidder", m.getMemberNo(),
					"productStatus", ProductType.SUCCESS,
					"finalPrice", p.getBuyNowPrice(),
					"productNo",p.getProductNo()
				);
		
		
		
		int result = productService.updateProductBuyNow(param);
		
		if(result>0) {
			Map<String,Object> param2 = Map.of(
						"bidPrice", p.getBuyNowPrice(),
						"memberNo", m.getMemberNo(),
						"dealType", DealType.OUTPUT,
						"walletType",WalletType.BUYNOW,
						"productNo",p.getProductNo()
					);
			result = memberService.updateBalance(DealType.OUTPUT, param2);
		}
		
		
		
		return result;
	}
	

	@RequestMapping("/bid")
	@ResponseBody
	public Map bid(String userBidPrice,String productNo,HttpSession session, HttpServletResponse res) throws IOException{
		log.debug(userBidPrice);
		log.debug(productNo);
		
		int bidPrice = Integer.parseInt(userBidPrice);
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		
		//log.debug("{}",m);
		if(loginMember==null) {
			//로그 아웃 상태 임
			
			return Map.of("result","로그인 후 이용해주세요");
		}
	
		Member m = memberService.selectMember(loginMember.getMemberNo());
		
		Product product = productService.selectOneProductNo(productNo);
		
		Member highestBidder = product.getHighestBidder();
		
		if(highestBidder!=null&&highestBidder.getEmail().equals(m.getEmail())) {
			return Map.of("result","본인이 최고 입찰자입니다.");
		}
		
		
		
		
		
		log.debug("{}",product);
		
		int nowBidPrice = Integer.parseInt(product.getNowBidPrice()==null?"0":product.getNowBidPrice());
		
		int bidUnit = Integer.parseInt(product.getBidUnit());
		
		if(bidPrice >= nowBidPrice+bidUnit) {
			
			int balance = Integer.parseInt(m.getBalance());
			if(balance<bidPrice) {
				log.debug("{}",balance);
				log.debug("{}",bidPrice);
				//잔액부족 
				return Map.of("result","잔액부족");
			}
			
			//입찰가능 
			log.debug("{}",bidPrice);
			log.debug("{}",m.getMemberNo());
			
			Member exHigher = product.getHighestBidder();
			String exHigherPrice = product.getNowBidPrice();
			
			
			
			int result = exeBid(productNo,String.valueOf(bidPrice),m.getMemberNo());
			
			if(result>0) {
				
				Map<String, Object> param = Map.of("dealType",DealType.OUTPUT,"amount",bidPrice,"walletType",WalletType.BID,"productNo",product.getProductNo(),"memberNo",m.getMemberNo(),"bidPrice",String.valueOf(bidPrice));
				result = memberService.updateBalance(DealType.OUTPUT,param);
				
				if(result>0) {
					
					if(exHigher!=null) {
						
					
						param = Map.of("dealType",DealType.INPUT,"amount",exHigherPrice,"walletType",WalletType.FAILURE,"productNo",product.getProductNo(),"memberNo",exHigher.getMemberNo(),"bidPrice",exHigherPrice);
						result = memberService.updateBalance(DealType.INPUT,param);
					
						if(result>0) {
							return Map.of("result","입찰성공");
						}else {
							return Map.of("result","입찰실패");
						}
					
					}else {
						return Map.of("result","입찰성공");
					}
					
				}else {
					return Map.of("result","입찰실패");
				}
				
			}else {
				return Map.of("result","입찰실패");
			}
			
			
			
		}else {
			//입찰불가 
			
			return Map.of("result","입찰불가금액");
		}
	}
	
	private int exeBid(String productNo,String bidPrice,String memberNo) {
		Map<String,String> param = Map.of(
											"productNo",productNo,
											"bidPrice",bidPrice,
											"memberNo",memberNo
										);
		int result = productService.updateBid(param);
		return result;
	}
	
	
	@RequestMapping("/review")
	@ResponseBody
	public List<Review> review(String sellerNo){
		log.debug(sellerNo);
		List<Review> list = productService.selectReview(sellerNo);
		
		return list;
	}
	
	
	@RequestMapping("/wishList")
	@ResponseBody
	public Map wishList(String productNo, String memberNo) {
		log.debug(productNo);
		log.debug(memberNo);
		
		if(memberNo.length()<=0) {
			return Map.of("result","로그인 후 이용");
		}
		
		Map<String, String> param = Map.of("productNo",productNo, "memberNo",memberNo);
		
		int result = productService.insertWishList(param);
		String msg ="";
		
		if(result>0) {
			msg="등록성공";
		}else {
			msg="등록실패";
		}
		
		
		return Map.of("result",msg);
	}
	
	@RequestMapping("/updateProduct")
	public ModelAndView updateProduct(String productNo, ModelAndView mv) {
		System.out.println("수정" + productNo);
		Product p = productService.updateProduct(productNo);
		mv.addObject("p",p);
		mv.setViewName("/product/updateProduct");
		return mv;
	}
	
	@PostMapping("/updateProductEnd")
	public ModelAndView updateProductEnd(ModelAndView mv, Product p,
			 String sellerNo, String productNum, String maxDate, String maxTime, String unit,
			 @RequestParam(value = "imageFile", required = false) MultipartFile[] imageFile, HttpServletRequest req) throws Exception {
		System.out.println("p.getproductno : " + p.getProductNo());
		//date 
		String date = maxDate+" "+maxTime;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date utilDate = sdf.parse(date);
		java.sql.Date endDate = new java.sql.Date(utilDate.getTime());
		p.setEndDate(endDate);
		
		//seller 
		p.setSeller(new Member());
		p.getSeller().setMemberNo(sellerNo);
		
		//productNo
		p.setProductNo(productNum);
		System.out.println("p.getproductno : " + p.getProductNo());
		
		//bidUnit
		if(unit.contains(",")) {
			String splitUnit[] = unit.split(",");
			p.setBidUnit(splitUnit[1]);
		} else {
			p.setBidUnit(unit);
		}
		
		//file
		String path = req.getServletContext().getRealPath("/resources/upload/product/"); 
		File f = new File(path);
		if(!f.exists()) f.mkdir();
		p.setImages(new ArrayList<ProductImage>());
		for(MultipartFile mf : imageFile) {
			if(!mf.isEmpty()) {
				String originalFileName = mf.getOriginalFilename();
				String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
				
				SimpleDateFormat sdf2 = new SimpleDateFormat("ddMMyyHHmmssss"); 
				int ranNum = (int)(Math.random()*1000);
				String renameFile = sdf2.format(System.currentTimeMillis())+"_"+ranNum+ext;
				try {
					mf.transferTo(new File(path+renameFile));
					ProductImage pi = ProductImage.builder().productNo(productNum).imageName(renameFile).build();
					p.getImages().add(pi);
					
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		System.out.println("p.getproductno : " + p.getProductNo());

		int imgDelete = productService.imgDelete(productNum);
		int result = 0;
		if(imgDelete>0) {
			result = productService.updateProductEnd(p);
		}
		
		String msg = "";
		String loc = "";
		
		if(result>0) {
			msg = "물품등록 수정에 성공하였습니다. ";
			loc = "/member/salesStates?memberNo="+p.getSeller().getMemberNo();
		}else {
			msg = "물품등록에 실패하였습니다. 관리자에게 문의하세요.";
			loc = "/product/updateProduct?productNo="+p.getProductNo();
		}
		
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("/common/msg");
		return mv;
	}
	
	@RequestMapping("/waitingDelete")
	public ModelAndView waitingDelete(String productNo, HttpSession session, ModelAndView mv) {
		System.out.println("삭제"+productNo);
		Member login = (Member)session.getAttribute("loginMember");
		int imgDelete = productService.imgDelete(productNo);
		int result = 0;
		if(imgDelete>0) {
			result = productService.waitingDelete(productNo);
		}
		
		String msg = "";
		String loc = "/member/salesStates?memberNo="+login.getMemberNo();
		
		if(result>0) {
			msg = "물품을 삭제하였습니다.";
		}else {
			msg = "물품삭제에 실패하였습니다. 관리자에게 문의하세요.";
		}
		
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("/common/msg");
		return mv;
	}
	
	@RequestMapping("/shipping") 
	public ModelAndView shippingSelect(String productNo, HttpSession session, ModelAndView mv) {
		System.out.println("발송:"+ productNo);
		Member login = (Member)session.getAttribute("loginMember");
		int result = productService.shippingSelect(productNo);
		
		String msg = "";
		String loc = "/member/salesStates?memberNo="+login.getMemberNo();
		
		if(result>0) {
			msg = "물품발송이 완료되었습니다.";
		}else {
			msg = "실패";
		}
		
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("/common/msg");
		return mv;
	}
	
	@RequestMapping("/buyEnd")
	public ModelAndView buyEnd(String productNo, HttpSession session, ModelAndView mv) {
		Member login = (Member)session.getAttribute("loginMember");
		Product p = productService.selectOneProductNo(productNo);
		
		int result = productService.buyEnd(productNo);
		System.out.println(result);
		String msg = "";
		String loc = "/member/buyStates?memberNo="+login.getMemberNo();
		
		if(result>0) {
			msg = "구매가 확정되었습니다.";
			int deposit = productService.sellerDeposit(p);
			System.out.println("결과:"+deposit);
		}else {
			msg = "실패";
		}
		
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("/common/msg");
		return mv;
	}
	
	@RequestMapping("/reInsertProduct")
	public ModelAndView reInsertProduct(String productNo, ModelAndView mv) {
		Product p = productService.updateProduct(productNo);
		mv.addObject("p",p);
		mv.setViewName("/product/reInsertProduct");
		return mv;
	}
	
	@PostMapping("/reInsertEnd")
	public ModelAndView reInsertEnd(ModelAndView mv, Product p,
			 String sellerNo, String productNum, String maxDate, String maxTime, String unit,
			 @RequestParam(value = "imageFile", required = false) MultipartFile[] imageFile, HttpServletRequest req) throws Exception {
		System.out.println("p.getproductno : " + p.getProductNo());
		//date 
		String date = maxDate+" "+maxTime;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date utilDate = sdf.parse(date);
		java.sql.Date endDate = new java.sql.Date(utilDate.getTime());
		p.setEndDate(endDate);
		
		//seller 
		p.setSeller(new Member());
		p.getSeller().setMemberNo(sellerNo);
		
		//productNo
		p.setProductNo(productNum);
		System.out.println("p.getproductno : " + p.getProductNo());
		
		//bidUnit
		if(unit.contains(",")) {
			String splitUnit[] = unit.split(",");
			p.setBidUnit(splitUnit[1]);
		} else {
			p.setBidUnit(unit);
		}
		
		//file
		String path = req.getServletContext().getRealPath("/resources/upload/product/"); 
		File f = new File(path);
		if(!f.exists()) f.mkdir();
		p.setImages(new ArrayList<ProductImage>());
		for(MultipartFile mf : imageFile) {
			if(!mf.isEmpty()) {
				String originalFileName = mf.getOriginalFilename();
				String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
				
				SimpleDateFormat sdf2 = new SimpleDateFormat("ddMMyyHHmmssss"); 
				int ranNum = (int)(Math.random()*1000);
				String renameFile = sdf2.format(System.currentTimeMillis())+"_"+ranNum+ext;
				try {
					mf.transferTo(new File(path+renameFile));
					ProductImage pi = ProductImage.builder().productNo(productNum).imageName(renameFile).build();
					p.getImages().add(pi);
					
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		int imgDelete = productService.imgDelete(productNum);
		int result = 0;
		if(imgDelete>0) {
			result = productService.reInsertEnd(p);
		}
		
		String msg = "";
		String loc = "";
		
		if(result>0) {
			msg = "물품등록이 정상적으로 요청되었습니다.";
			loc = "/member/salesStates?memberNo="+p.getSeller().getMemberNo();
		}else {
			msg = "물품등록에 실패하였습니다. 관리자에게 문의하세요.";
			loc = "/product/reInsertProduct?productNo="+p.getProductNo();
		}
		
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("/common/msg");
		return mv;
	}
	
	@RequestMapping("/todayView")
	public String todayView(@CookieValue(value = "productNum", required = false) Cookie view, Model m) {
		System.out.println("test");
		if(view != null) {
			cookieList.clear();
			String nums[] = view.getValue().split("\\|");
			System.out.println("nums"+nums[1]);
			for(int i=1; i<nums.length; i++) {
				Product p = productService.selectOneProductNo(nums[i]);
				if(p != null) {
					cookieList.add(p);
					//List<Product> todayList = cookieList.stream().distinct().collect(Collectors.toList());
					m.addAttribute("list",cookieList);
				}
			}
		} 
		return "/product/todayView";
	}

	@RequestMapping("/todayDelete") 
	public String todayDelete(@CookieValue(value = "productNum", required = false) Cookie view, HttpServletResponse res, Model m) {
		System.out.println("delete"+view.getValue());
		List<Product> todayList = cookieList.stream().distinct().collect(Collectors.toList());
		todayList = null;
		view.setMaxAge(0); 
		res.addCookie(view);
		
		m.addAttribute("list",todayList);
		return "/product/todayView";
//		int index = 0;
//		for(int i=0; i<todayList.size(); i++) {
//			if(todayList.get(i).getProductNo().equals(productNo)) {
//				index = i;
//			}
//		}
//		System.out.println(index);
//		todayList.remove(index);
//		
	}
	

}
