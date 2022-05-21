package com.nb.spring.member.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.nb.spring.common.DealType;
import com.nb.spring.member.model.vo.Member;
import com.nb.spring.member.model.vo.MessageBox;
import com.nb.spring.member.model.vo.Wallet;
import com.nb.spring.member.model.vo.WishList;
import com.nb.spring.product.model.vo.Product;

public interface MemberDao {

	Member loginMember(SqlSessionTemplate session,Map<String,String> param);
	
	Member selectMember(SqlSessionTemplate session, String memberNo);
	
	List<Product> salesList(SqlSessionTemplate session, String memberNo);

	Member selectMemberNickName(SqlSessionTemplate session, String nickName);

	int insertMember(SqlSessionTemplate session, Member m);

	public Member selectMemberNamePhone(SqlSessionTemplate session, Map<String, String> param);
	
	Member selectMemberPhoneEmail(SqlSessionTemplate session, Map<String, String> param);

	int updatePassword(SqlSessionTemplate session, Map<String,String> param);

	List<Product> salesSearch(SqlSessionTemplate session, Map param);
	
	List<Wallet> buyList(SqlSessionTemplate session, String memberNo);
	
	List<Wallet> buySearch(SqlSessionTemplate session, Map param);

	int updateBalance(SqlSessionTemplate session, DealType type, Map<String, Object> param);

	int insertWallet(SqlSessionTemplate session, Map<String, Object> param);

	int updateDeliveryAddress(SqlSessionTemplate session, Map<String,String>param);



	Member loginMemberKakao(SqlSessionTemplate session, Map param);

	List<Wallet> emoneyDetail(SqlSessionTemplate session, int cPage, int numPerPage, String memberNo);

	List<Wallet> emoneySelectList(SqlSessionTemplate session, Map param);
	
	Member findMember(SqlSessionTemplate session, String nickName);
	
	int endRealTimeActionWallet(SqlSessionTemplate session, Map<String,Object> param);

	
	List<Map<String,Object>> sellerrank(SqlSessionTemplate session);
	List<Product> sellList(SqlSessionTemplate session, String memberNo);
	List<MessageBox> messageReceivList(SqlSessionTemplate session, String memberNo, int cPage, int numPerPage);
	
	int messageReceivListCount(SqlSessionTemplate session, String memberNo);
	
	int noCheckMsgCount(SqlSessionTemplate session, String memberNo);
	
	List<MessageBox> messageSendList(SqlSessionTemplate session, String memberNo, int cPage, int numPerPage);
	
	int messageSendListCount(SqlSessionTemplate session, String memberNo);
	
	MessageBox messageOne(SqlSessionTemplate session, Map<String,Object> param);
	
	int messageOneCheck(SqlSessionTemplate session, int msgNo);
	
	int insertSendMessageBox(SqlSessionTemplate session,MessageBox mb);
	
	int insertReceivMessageBox(SqlSessionTemplate session,MessageBox mb);
	
	int deleteMessageBox(SqlSessionTemplate session, Map<String,Object> param);
	
	List<WishList> myWishList(SqlSessionTemplate session,String memberNo);
	
	int deleteWish(SqlSessionTemplate session, Map<String,String> param);
	
	int memberBalanceUpdate(SqlSessionTemplate session, Map<String,Object> param);
	
	int insertReceivMessageBoxAction(SqlSessionTemplate session, Map<String,Object> param);
	
	List<Map<String,Object>> beforeDelete(SqlSessionTemplate session, String memberNo);
	
	String pwCheck(SqlSessionTemplate session, String memberNo);
	
	int deleteMember(SqlSessionTemplate session, String memberNo);
	
	int updateMember(SqlSessionTemplate session, Map<String,String> param);

	List<Member> selectMemberList(SqlSessionTemplate session,Map param);
	
	int emoneyCount (SqlSessionTemplate session, String memberNo);
	
	int emoneySelectCount (SqlSessionTemplate session, Map param);
}