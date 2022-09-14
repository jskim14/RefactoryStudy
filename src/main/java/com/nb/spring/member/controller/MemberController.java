package com.nb.spring.member.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.nb.spring.common.statusCode.PermissionYN;
import com.nb.spring.common.statusCode.ProductType;
import com.nb.spring.member.model.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.parameters.P;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.nb.spring.common.statusCode.WalletCategoryType;
import com.nb.spring.common.MsgModelView;
import com.nb.spring.common.PageFactory;
import com.nb.spring.common.StringHandler;
import com.nb.spring.common.statusCode.WalletCategoryDetail;
import com.nb.spring.member.model.service.MemberService;
import com.nb.spring.member.model.service.SendEmailService;
import com.nb.spring.product.model.vo.Product;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
@SessionAttributes({"loginMember","admin","accessToken" ,"salesCnt","buyCnt","msgCount"})
public class MemberController {
	
	@Autowired
	private MemberService service;      
	
	@Autowired
	private SendEmailService mailService;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@PostMapping("/kakaoEnroll")
	public ModelAndView kakaoEnroll(@RequestParam Map param,HttpSession session, ModelAndView mv) {
		log.debug("{}",param);
		Member m = service.loginMemberKakao(param);
		
		if(m!=null) {
			return MsgModelView.msgBuild(mv, "/member/login", "이미 등록된 아이디입니다.");
		}
		
		session.setAttribute("userEmail", param.get("email"));
		mv.setViewName("login/enrollMember");
		return mv;
	}
	
	
	@PostMapping("/kakaoLogin")
	public ModelAndView kakaoLogin(@RequestParam Map param, ModelAndView mv) {
		
		log.debug("{}",param);
		
		Member m = service.loginMemberKakao(param);
		
		if(m!=null) {
			mv.addObject("loginMember", m);
			mv.addObject("accessToken", param.get("accessToken"));
			return MsgModelView.msgBuild(mv, "/", "로그인 성공!");
		}else {
		    return MsgModelView.msgBuild(mv, "/member/login", "로그인 실패!");
		}

		
	}

	@PostMapping("/loginMember")
	public ModelAndView loginMember(ModelAndView mv, String email, String password, String flexCheckDefault, 
			HttpServletResponse res) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("email", email);
		//param.put("password", password);
		Member m = service.loginMember(param);
		if(flexCheckDefault!=null) {
			Cookie c = new Cookie("flexCheckDefault",email);
			c.setPath("/");
			c.setMaxAge(24*60*60*7);
			res.addCookie(c);
		}else {
			Cookie c = new Cookie("flexCheckDefault",email);
			c.setPath("/");
			c.setMaxAge(0);
			res.addCookie(c);
		}
		if(m!=null&&encoder.matches(password, m.getPassword())) {

			if(m.getNickName().equals("admin")) {
				mv.addObject("admin",true);
			}else {
				mv.addObject("admin",false);
			}
			mv.addObject("loginMember", m);
			mv.addObject("msg","로그인 성공");
			mv.addObject("loc","/");
		}else {
			mv.addObject("msg","로그인 실패, 다시 시도하세요.");
			mv.addObject("loc","/member/login");
		}
		mv.setViewName("common/msg");
		return mv;
	}
	
	@RequestMapping("/logout")
	public ModelAndView logout(HttpSession session, SessionStatus stauts, ModelAndView mv) {
		if(!stauts.isComplete()) {
			stauts.setComplete();
		}
		session.invalidate();
		String msg = "로그아웃 완료";
		String loc = "/";
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");
		return mv;
	}

	//todo 마이페이지 메인
	@RequestMapping("/myPage")
	public ModelAndView myPage(String memberNo, ModelAndView mv) {
		Member m = service.selectMember(memberNo);
		
//		판매
		List<Product> list = service.salesList(memberNo);
		int total = list.size();
		int salesWaiting=0;
		int onSale=0;
		int soldOut=0;
		int salesEnd=0;
		if(list.isEmpty()) {
			List<Integer> zeroList = List.of(0,0,0,0,0);
			mv.addObject("salesCnt", zeroList);
		} else {
			for(Product p : list) {
				if(p.getProductNo() != null) {
					if(p.getPermissionYn().equals(PermissionYN.WAITING.getStatus())
							|| p.getPermissionYn().equals(PermissionYN.REJECT.getStatus())) { //판매대기
						salesWaiting++;
					}
					if(p.getPermissionYn().equals((PermissionYN.CONFIRM.getStatus()))
							&& p.getProductStatus().equals(ProductType.ON_SALE.getStatus())) { //판매중
						onSale++;
					}
					if(p.getProductStatus().equals(ProductType.DEPOSIT.getStatus())
							|| p.getProductStatus().equals(ProductType.SHIPPING.getStatus())
							||p.getProductStatus().equals(ProductType.ARRIVAL.getStatus())) { //판매완료
						soldOut++;
					}
					if(p.getProductStatus().equals(ProductType.DONE.getStatus())
							|| p.getProductStatus().equals(ProductType.REPORT.getStatus())) { //종료
						salesEnd++;
					}
				}
			}
			List<Integer> salesCnt = List.of(total,salesWaiting,onSale,soldOut,salesEnd);
			mv.addObject("salesCnt", salesCnt);
		}
		
		mv.addObject("productList",list);
		
//		구매
		List<Wallet> buyList = service.buyList(memberNo);
		int buyTotal = buyList.size();
		int buying=0;
		int waiting=0;
		int end=0;
		
		if(buyList.isEmpty()) {
			List<Integer> zeroList = List.of(0,0,0,0,0);
			mv.addObject("buyCnt", zeroList);
		} else {
			for(Wallet w : buyList) {
				if(!(w.getCategoryDetail().equals("0"))) {
					if(w.getProductNo().getProductStatus() != null) {
						if(w.getProductNo().getProductStatus().equals("0")) {
							buying++;
						}
					}
					if(w.getProductNo().getProductStatus() != null && w.getProductNo().getFinalPrice() != null) {
						if((w.getProductNo().getProductStatus().equals("1")
								||w.getProductNo().getProductStatus().equals("2"))
								&& w.getProductNo().getFinalPrice().equals(w.getAmount())) { //구매대기
							waiting++;
						}
						if((w.getProductNo().getProductStatus().equals("3")
								||w.getProductNo().getProductStatus().equals("4")
								||w.getProductNo().getProductStatus().equals("5"))
								&& w.getProductNo().getFinalPrice().equals(w.getAmount()) ) { //종료
							end++;
						}
						if(!(w.getProductNo().getProductStatus().equals("0"))
								&& !(w.getProductNo().getFinalPrice().equals(w.getAmount()))) { //종료
							end++;
						}
					}
				}
			}
			List<Integer> buyCnt = List.of(buyTotal,buying,waiting,end);
			mv.addObject("buyCnt", buyCnt);
		}
		mv.addObject("productList",buyList);
		
		mv.addObject("myPageMember",m);	
		mv.setViewName("login/myPage");
		return mv;
	}
	
	@RequestMapping("/enrollMember")
	public String enrollmemberView() {
		return "login/enrollEmail";
	}
	
	@PostMapping("/email")
	@ResponseBody
	public Map sendEmail(HttpSession session, String userEmail) {
		log.debug(userEmail);
		String result="";
		String code="";
		Map<String,String> param = Map.of("email", userEmail);
		Member m = service.selectMemberPhoneEmail(param);
		
		if(m!=null) {
			return Map.of("result","이미 가입된 회원입니다.");
		}
		
		
		
		session.removeAttribute("userEmail");
		try {
			code = mailService.mailSend(userEmail);			
		}catch(Exception e) {
			e.printStackTrace();
			throw new IllegalArgumentException();
		}
			
		if(code!=null&&code.length()>0) {
			result ="전송완료";
			session.setAttribute("emailCode", code);
			session.setAttribute("userEmail", userEmail);
		}else {
			result ="전송실패";
		}
		
		return Map.of("result",result);
	}
	
	@PostMapping("/certification")
	@ResponseBody
	public Map certification(String inputCode, HttpSession session) {
		
		String codeInSession = (String)session.getAttribute("emailCode");
		boolean result =false;
		if(codeInSession.equals(inputCode)) {
			// 같은 코드 
			result =true;
			session.removeAttribute("emailCode");
		}else {
			//실패 
			result =false;
		}
		
		
		return Map.of("result",result);
	}
	
	@RequestMapping("/enrollMemberMainView")
	public String enrollMemberMainView() {
		return "login/enrollMember";
	}
	
	@RequestMapping("/duplicationCheck")
	@ResponseBody
	public Map duplicationCheck(String nickName) {
		
		Member m  = service.selectMemberNickName(nickName);
		boolean result = false;
		if(m!=null) {
			result = false;
		}else {
			result =true;
		}
		return Map.of("result",result);
	}
	
	@PostMapping("/enrollMemberMain")
	public ModelAndView enrollMemberMain(@RequestParam Map<String, String> param,HttpSession session, ModelAndView mv) {
		log.debug("{}",param);
		String totalAddress = param.get("address")+" "+ param.get("detailAddress")+" "+param.get("plusAddress");
		String email = (String)session.getAttribute("userEmail");
		
		String encodingPw = encoder.encode(param.get("password"));
		log.debug(encodingPw);
		Member m = Member.builder()
				.memberName(param.get("name"))
				.password(encodingPw)
				.phone(param.get("phone"))
				.email(email)
				.nickName(param.get("nickName"))
				.address(totalAddress)
				.deliveryAddress(totalAddress)
				.build();
		
		int result = service.insertMember(m);
		session.removeAttribute("userEmail");
		if(result > 0) {
			
			mv.addObject("msg","회원가입 성공");
			mv.addObject("loc","/");
		}else {
			mv.addObject("msg","회원가입 실패. 다시 시도해주세요.");
			mv.addObject("loc","/member/enrollMember");
		}
		mv.setViewName("common/msg");
		return mv;
	
	}
	
	@RequestMapping("/findId")
	public String findId() {
		return "login/findId";
	}
	
	@PostMapping("/findIdEnd")
	public ModelAndView findIdEnd(String name, String phone, ModelAndView mv) {
		log.debug(name,phone);
		Member m = service.selectMemberNamePhone(Map.of("name",name,"phone",phone));
		log.debug("{}",m);
		
		if(m==null) {
			String msg = "없는 회원입니다.";
			String loc = "/login";
			mv.addObject("msg", msg);
			mv.addObject("loc", loc);
			mv.setViewName("common/msg");
			return mv;
		}
		
		
		
		
		String email = m.getEmail();
		String id = email.substring(0, email.indexOf("@"));
		String address = email.substring(email.indexOf("@"));
		String idFront = id.substring(0,id.length()-3);
		String idEnd = id.substring(id.length()-3);
		String temp="";
		
		for(int i=0; i<idEnd.length();i++) {
			temp+="*";
		}
		
		String modifyEmail = idFront+temp+address;
		
		mv.addObject("userId", modifyEmail);
		mv.addObject("userName",m.getMemberName());
		mv.setViewName("login/findIdConfirm");
		
		
		return mv;
	}
	
	@RequestMapping("/findPassword")
	public String findPassword() {
		return "login/findPassword";
	}
	
	@PostMapping("/findPasswordEnd")
	public ModelAndView findPasswordEnd(String phone, String email, ModelAndView mv) throws Exception {
		
		Map<String, String > param = Map.of("phone",phone,"email",email);
		Member m = service.selectMemberPhoneEmail(param);
		String msg = "";
		String loc = "";
		if(m==null) {
			msg = "없는 회원입니다.";
			loc = "/member/findPassword";
		}else {
			
			String newEncodingPw = encoder.encode(mailService.mailSendNewPassword(m.getEmail()));
			log.debug(newEncodingPw);
			Map<String, String> param2 = Map.of("memberNo",m.getMemberNo(),"newPw",newEncodingPw);
			int result = service.updatePassword(param2);
			
			log.debug("{}",result);
			if(result>0) {
				msg = "임시 비밀번호 발급완료";
				loc = "/member/login";
			}else {
				msg = "임시 비빌번호 발급 실패";
				loc = "/member/findPassword";
			}
			
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");
		return mv;
	}
	
	@RequestMapping("/login")
	public String loginView() {
		return "login/loginView";
	}

	//todo 판매현황
	@RequestMapping("/salesStates")
	public ModelAndView salesStates(String memberNo, ModelAndView mv) {
		List<Product> list = service.salesList(memberNo);
		log.info("productList = {}", list);
		mv.addObject("productList",list);
		mv.setViewName("product/salesStates");
		return mv;
	}

	//todo 판매현황 검색
	@PostMapping(value = "/salesSearch")
	public String salesSearch (SearchDto searchDto , Model m) { //@RequestParam(value = "count") List<Integer> count

		List<Product> list = service.salesSearch(searchDto);

		m.addAttribute("productList",list);
		return "product/salesStates";
	}

	//todo 구매현황
	@RequestMapping("/buyStates")
	public ModelAndView buyStates(String memberNo, ModelAndView mv) {
		List<Wallet> buyList = service.buyList(memberNo);
		mv.addObject("productList",buyList);
		mv.setViewName("product/buyStates");
		return mv;
	}

	//todo 구매현황 검색
	@PostMapping(value = "/buySearch")
	public String buySearch (SearchDto searchDto, Model m) {
		List<Wallet> list = service.buySearch(searchDto);

//		m.addAttribute("buyCnt", count);
//		m.addAttribute("productList",list.get(0).getWalletList());
		m.addAttribute("productList",list);
		return "product/buyStates";
	}
	
	@RequestMapping("/emoneyDetail")
	public ModelAndView emoneyDetail(@RequestParam(name = "cPage",defaultValue = "1") int cPage,
			@RequestParam(value="numPerPage",defaultValue="15") int numPerPage, String memberNo, ModelAndView mv) {	
		
		int pageBarSize = 5;
		int totalData = service.emoneyCount(memberNo);
		List<Wallet> list = service.emoneyDetail(cPage, numPerPage, memberNo);
		Member m = service.selectMember(memberNo);
		System.out.println(list);
		
		mv.addObject("m",m);
		mv.addObject("list",list);
		mv.addObject("numPerPage",numPerPage);
		mv.addObject("pageBar", PageFactory.getPageBar(totalData, cPage, numPerPage, pageBarSize, "emoneyDetail"));
		mv.setViewName("login/emoneyDetail");
		return mv;
	}

	@RequestMapping("/charge")
	public ModelAndView charge(HttpSession session ,ModelAndView mv) {
		
		Member m = (Member)session.getAttribute("loginMember");
		if(m==null) {
			return MsgModelView.msgBuild(mv, "/", "로그인 후 이용해주세요.");
		}
		
		//유저정보 최신화
		m = service.selectMember(m.getMemberNo());
		
		mv.addObject("member", m);
		
		mv.setViewName("login/chargeMoney");
		
		return mv;
	}
	

	@RequestMapping("/kakaoPay")
	@ResponseBody
	public String kakaoPay(String amount) {
		log.debug(amount);
		String numAmount = StringHandler.removeComma(amount);
		try {
			URL address = new URL("https://kapi.kakao.com/v1/payment/ready");
			HttpURLConnection connection = (HttpURLConnection)address.openConnection();//서버연결
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Authorization", "KakaoAK 6bbfc35e54bdc78656dc5040bd19b498"); // 어드민 키
			connection.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			connection.setDoOutput(true); // 서버한테 전달할게 있는지 없는지
			String parameter = "cid=TC0ONETIME" // 가맹점 코드
					+ "&partner_order_id=partner_order_id" // 가맹점 주문번호
					+ "&partner_user_id=partner_user_id" // 가맹점 회원 id
					+ "&item_name=초코파이" // 상품명
					+ "&quantity=1" // 상품 수량
					+ "&total_amount="+numAmount // 총 금액
					+ "&vat_amount=200" // 부가세
					+ "&tax_free_amount=0" // 상품 비과세 금액
					+ "&approval_url=http://localhost:9090" // 결제 성공 시
					+ "&fail_url=http://localhost:9090" // 결제 실패 시
					+ "&cancel_url=http://localhost:9090"; // 결제 취소 시
			log.debug(parameter);
			OutputStream send = connection.getOutputStream(); // 이제 뭔가를 를 줄 수 있다.
			DataOutputStream dataSend = new DataOutputStream(send); // 이제 데이터를 줄 수 있다.
			dataSend.writeBytes(parameter); // OutputStream은 데이터를 바이트 형식으로 주고 받기로 약속되어 있다. (형변환)
			dataSend.close(); // flush가 자동으로 호출이 되고 닫는다. (보내고 비우고 닫다)
			
			int result = connection.getResponseCode(); // 전송 잘 됐나 안됐나 번호를 받는다.
			InputStream receive; // 받다
			
			if(result == 200) {
				receive = connection.getInputStream();
			}else {
				receive = connection.getErrorStream(); 
			}
			// 읽는 부분
			InputStreamReader read = new InputStreamReader(receive); // 받은걸 읽는다.
			BufferedReader change = new BufferedReader(read); // 바이트를 읽기 위해 형변환 버퍼리더는 실제로 형변환을 위해 존제하는 클레스는 아니다.
			// 받는 부분
			return change.readLine(); // 문자열로 형변환을 알아서 해주고 찍어낸다 그리고 본인은 비워진다.




		}catch (MalformedURLException e) {
			e.printStackTrace();
		}catch (IOException e) {
			e.printStackTrace();
		}
		
		return "";
	}
	
	@RequestMapping("/kakaoSuccess")
	@ResponseBody
	public Boolean kakaoSuccess(String amount, HttpSession session) {
		String numAmount = StringHandler.removeComma(amount);
		
		Member m = (Member)session.getAttribute("loginMember");
		
		Map<String, Object> param = Map.of(
										"memberNo",m.getMemberNo(),
										"dealType", WalletCategoryType.DEPOSIT,
										"walletType", WalletCategoryDetail.EMONEY_CHARGE,
										"bidPrice",numAmount,
										"productNo",""
									);
		int result = service.updateBalance(WalletCategoryType.DEPOSIT, param);
		
		if(result>0) {
			return true;
		}else {
			return false;
		}
		
		
	}

	//todo 이머니내역
	@RequestMapping("/emoneySelectList")
	public String emoneySelectList(HttpSession session, @RequestParam(value = "btnCategory", required=false ) String category,
			@RequestParam(name = "cPage",defaultValue = "1") int cPage,
			@RequestParam(value="numPerPage",defaultValue="15") int numPerPage, Model m) {
		Member sessionMem = (Member) session.getAttribute("loginMember");
		Map param = new HashMap<>();
		param.put("category", category);
		param.put("memberNo", sessionMem.getMemberNo());
		param.put("cPage", cPage);
		param.put("numPerPage", numPerPage);
		
		int pageBarSize = 5;
		int totalData = service.emoneySelectCount(param);

		List<Wallet> list = service.emoneySelectList(param);
		Member mem = service.selectMember(sessionMem.getMemberNo());
		System.out.println("select : "+category+ mem+ list);
		m.addAttribute("m",mem);
		m.addAttribute("list",list);
		m.addAttribute("numPerPage",numPerPage);
		m.addAttribute("pageBar", PageFactory.emoneySearch(totalData, cPage, numPerPage, pageBarSize, "emoneySelectList", category));
		return "login/emoneyDetail";
	}

	//todo 장바구니
	@RequestMapping("/myWishList")
	public ModelAndView myWishList(String memberNo, ModelAndView mv) {
		List<WishList> list = service.myWishList(memberNo);
//		List<Member> list = service.myWishList(memberNo);
		mv.addObject("list",list);
		mv.setViewName("/login/wishList");
		return mv;
	}

	//todo 장바구니 삭제
	@RequestMapping("/deleteWish")
	public ModelAndView deleteWish(@RequestParam Map<String,String> param, ModelAndView mv) {
		int result = service.deleteWish(param);
		System.out.println(param.get("memberNo"));
		
		String msg = "";
		String loc = "/member/myWishList?memberNo="+param.get("memberNo");
		
		if(result>0) {
			msg = "삭제가 완료되었습니다.";
		} else {
			msg = "실패하였습니다.";
		}
		
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("/common/msg");
		return mv;
	}

	
	//셀러랭킹
	@RequestMapping("/sellerrank")
	public ModelAndView sellerrank(ModelAndView mv) {
		List<Map<String,Object>> sellerList = service.sellerrank();
		
		mv.addObject("sellerList",sellerList);
		mv.setViewName("member/sellerrank");
		return mv;
	}
	//셀러상품
	@RequestMapping("/sellList")
	public ModelAndView sellList(ModelAndView mv, String memberNo) {
		List<Product> sellList=service.sellList(memberNo);
		
		mv.addObject("sellList",sellList);
		mv.addObject("seller",memberNo);
		mv.setViewName("member/sellList");
		return mv;
	}
	
	//회원탈퇴화면
	@RequestMapping("/deleteMemberView")
	public String deleteMemberView() {
		return "member/deleteMemberView";
	}
	
	//탈퇴가능 여부
	@RequestMapping("/beforeDelete")
	@ResponseBody
	public void beforeDelete(HttpServletResponse response, String memberNo) throws IOException{
		List<Map<String,Object>> list=service.beforeDelete(memberNo);
		int result;
		if(list.isEmpty()) {
			result=0;
		}else {
			result=1;
		}
		System.out.println("result="+result);
		PrintWriter out=response.getWriter();
		out.write(result+"");
	}
	
	@RequestMapping(value="/checkPw", method=RequestMethod.POST)
	@ResponseBody
	public void pwCheck(HttpServletResponse response, String memberNo, String password) throws Exception{
		String pw = service.pwCheck(memberNo);
		
		int result;
		if(pw!=null&&encoder.matches(password, pw)){
			result= 1;
		}else {
			result=0;
		}
		PrintWriter out=response.getWriter();
		out.write(result+"");
	}
	
	@RequestMapping("/deleteMember")
	public String deleteMember(String memberNo, SessionStatus status, HttpServletResponse response,
			HttpSession session) throws Exception{
		int result=service.deleteMember(memberNo);
		if(result>0) {
			status.setComplete();
			session.invalidate();
		}
		response.setContentType("text/html; charset=UTF-8"); 
		PrintWriter out = response.getWriter(); 
		out.println("<script>alert('성공적으로 탈퇴했습니다.'); location.href='/';</script>"); 
		out.flush();
		return "redirect:/";
	}

	//todo 마이페이지 수정
	@RequestMapping("/updateMyPage")
	public String updateMyPage(String memberNo, Model m) {
		Member member = service.selectMember(memberNo);
		m.addAttribute("m",member);
		return "login/updateMyPage";
	}
	
	@RequestMapping("/updateMyPageEnd") 
	public ModelAndView updateMyPageEnd(HttpSession session, @RequestParam Map<String,String> param, ModelAndView mv) {
		Member m = (Member) session.getAttribute("loginMember");
		System.out.println(param);
		
		if(param.get("shipAddress").equals("")) {
			param.put("address", param.get("memberAddress"));
		} else {
			String totalAddress = param.get("shipAddress")+" "+param.get("detailAddress");
			param.put("address", totalAddress);
		}
		System.out.println(param);
		int result = service.updateMember(param); //닉네임으로 찾아서 수정 
		
		String msg = "";
		String loc = "/member/myPage?memberNo="+m.getMemberNo();
		
		if(result>0) {
			msg = "수정이 완료되었습니다.";
		} else {
			msg = "실패하였습니다. 관리자에게 문의하세요.";
		}
		
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("/common/msg");
		return mv;
	}

	//todo 비밀번호 수정
	@RequestMapping("/updatePassword")
	public String updatePassword() {
		return "/login/updatePassword";
	}
	
	@RequestMapping("/updatePasswordEnd")
	@ResponseBody
	public Map updatePasswordEnd(HttpSession session, String pw, String newPw) {
		Member m = (Member) session.getAttribute("loginMember");

		String msg = "";
		if(encoder.matches(pw,m.getPassword())) { //일치하면
			newPw = encoder.encode(newPw);
			Map<String, String> param = new HashMap<>();
			param.put("newPw", newPw);
			param.put("memberNo", m.getMemberNo());
			int result = service.updatePassword(param);
			if(result>0) {
				msg = "비밀번호 변경이 완료되었습니다.";
			} else {
				msg = "비밀번호 변경에 실패하였습니다. 관리자에 문의하세요.";
			}
		} else {
			msg = "현재비밀번호와 일치하지 않습니다.";
		}
		return Map.of("result",msg);
	}
	
}
