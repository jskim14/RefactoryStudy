package com.nb.spring.member.model.service;

import java.util.List;
import java.util.Map;

import com.nb.spring.common.statusCode.WalletCategoryType;
import com.nb.spring.member.model.vo.*;
import com.nb.spring.product.model.vo.Product;

public interface MemberService {

	Member loginMember(Map<String, String> param);
	
	Member selectMember(String memberNo);
	
	List<Product> salesList(String memberNo);

	Member selectMemberNickName(String nickName);

	int insertMember(Member m);

	Member selectMemberNamePhone(Map<String, String> param);

	Member selectMemberPhoneEmail(Map<String, String> param);

	int updatePassword(Map<String,String> param);
	
	List<Product> salesSearch(SalesSearch salesSearch);
	
	List<Wallet> buyList(String memberNo);
	
	List<Wallet> buySearch(Map param);

	int updateBalance(WalletCategoryType type, Map<String, Object> param);
	
	int updateDeliveryAddress(Map<String,String> param);
	
	Member loginMemberKakao(Map param);

	List<Wallet> emoneyDetail(int cPage, int numPerPage, String memberNo);

	List<Wallet> emoneySelectList(Map param);

	Member findMember(String nickName);
	
	int endRealTimeActionWallet(Map<String,Object> param);

	List<Map<String,Object>> sellerrank();
	
	List<Product> sellList(String memberNo);
	
	List<MessageBox> messageReceivList(String memberNo, int cPage, int numPerPage);
	
	int messageReceivListCount(String memberNo);
	
	int noCheckMsgCount(String memberNo);
	
	List<MessageBox> messageSendList(String memberNo, int cPage, int numPerPage);
	
	int messageSendListCount(String memberNo);
	
	MessageBox messageOne(Map<String,Object> param);
	
	int messageOneCheck(int msgNo);
	
	int insertMessageBox(MessageBox mb);
	
	int deleteMessageBoxList(List<Integer> msgNoArr, String msgbox);
	
	int deleteMessageBoxOne(int msgNo, String msgbox);
	
	List<WishList> myWishList(String memberNo);
	
	int deleteWish(Map<String,String> param);
	
	int memberBalanceUpdate(Map<String,Object> param);
	
	List<Map<String,Object>> beforeDelete(String memberNo);
	String pwCheck(String memberNo);
	
	int deleteMember(String memberNo);
	
	int updateMember(Map<String,String> param);

	List<Member> selectMemberList(Map param);
	
	int emoneyCount(String memberNo);
	
	int emoneySelectCount(Map param);
}
