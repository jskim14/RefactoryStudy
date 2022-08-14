package com.nb.spring.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.nb.spring.member.model.vo.*;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nb.spring.common.statusCode.WalletCategoryType;
import com.nb.spring.member.model.dao.MemberDao;
import com.nb.spring.product.model.vo.Product;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDao dao;
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public Member loginMember(Map<String, String> param) {
		return dao.loginMember(session, param);
	}

	@Override
	public Member selectMember(String memberNo) {
		return dao.selectMember(session,memberNo);
	}

	@Override
	public List<Product> salesList(String memberNo) {
		return dao.salesList(session,memberNo);
	}
	
	public Member selectMemberNickName(String nickName) {
		
		return dao.selectMemberNickName(session, nickName);
	}

	@Override
	public int insertMember(Member m) {
		
		return dao.insertMember(session, m);
	}

	@Override
	public Member selectMemberNamePhone(Map<String, String> param) {
		
		return dao.selectMemberNamePhone(session,param);
	}

	@Override
	public Member selectMemberPhoneEmail(Map<String, String> param) {
		
		return dao.selectMemberPhoneEmail(session,param);
	}

	@Override
	public int updatePassword(Map<String, String> param) {
		
		return dao.updatePassword(session,param);
	}

	@Override
	public List<Product> salesSearch(SearchDto salesSearch) {
		return dao.salesSearch(session, salesSearch);
	}

	@Override
	public List<Wallet> buyList(String memberNo) {
		return dao.buyList(session, memberNo);
	}

	@Override
	public List<Wallet> buySearch(SearchDto searchDto) {
		return dao.buySearch(session, searchDto);
	}

	@Override
	public int updateDeliveryAddress(Map<String,String> param) {
		
		return dao.updateDeliveryAddress(session,param);
	}

	
	@Override
	public int updateBalance(WalletCategoryType type, Map<String, Object> param) {
		int result = dao.updateBalance(session, type,param);
		if(result>0) {
			result = dao.insertWallet(session,param);
			return result;
		}
		return 0;
	}

	@Override
	public List<Wallet> emoneyDetail(int cPage, int numPerPage, String memberNo) {
		List<Wallet> list = dao.emoneyDetail(session, cPage, numPerPage, memberNo);
		return list;
	}

	@Override
	public Member loginMemberKakao(Map param) {
		// TODO Auto-generated method stub
		return dao.loginMemberKakao(session, param);
	}

	public List<Wallet> emoneySelectList(Map param) {
		List<Wallet> list = dao.emoneySelectList(session, param);
		return list;
	}
	
	@Override
	public Member findMember(String nickName) {
		return dao.findMember(session, nickName);
	}
	
	@Override
	public int endRealTimeActionWallet(Map<String,Object> param) {
		return dao.endRealTimeActionWallet(session, param);
	}

	@Override
	public List<Map<String, Object>> sellerrank() {
		List<Map<String, Object>> list = dao.sellerrank(session);
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		if(list.size()>10) {
			for(int i=0; i<10; i++) {
				result.add(list.get(i));
			}
		}else {
			result = list;
		}
		return result;
	}

	@Override
	public List<Product> sellList(String memberNo) {
		return dao.sellList(session, memberNo);
	}
	
	
	@Override
	public List<MessageBox> messageReceivList(String memberNo, int cPage, int numPerPage) {
		return dao.messageReceivList(session, memberNo, cPage, numPerPage);
	}
	
	@Override
	public int messageReceivListCount(String memberNo) {
		return dao.messageReceivListCount(session, memberNo);
	}
	
	@Override
	public int noCheckMsgCount(String memberNo) {
		return dao.noCheckMsgCount(session, memberNo);
	}
	
	@Override
	public List<MessageBox> messageSendList(String memberNo, int cPgage, int numPerPage) {
		return dao.messageSendList(session, memberNo, cPgage, numPerPage);
	}
	
	@Override
	public int messageSendListCount(String memberNo) {
		return dao.messageSendListCount(session, memberNo);
	}
	
	@Override
	public MessageBox messageOne(Map<String,Object> param) {
		return dao.messageOne(session, param);
	}
	
	@Override
	public int messageOneCheck(int msgNo) {
		return dao.messageOneCheck(session, msgNo);
	}
	
	@Override
	public int insertMessageBox(MessageBox mb) {
		int result = dao.insertSendMessageBox(session, mb);
		System.out.println("전 : " + mb);
		if(result>0) {
			System.out.println("후 : " + mb);
			result = dao.insertReceivMessageBox(session, mb);
		}
		return result;
	}
	
	@Override
	public int deleteMessageBoxList(List<Integer> msgNoArr, String msgbox) {
		int result = 0;
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("msgbox", msgbox);
		for(Integer i : msgNoArr) {
			param.put("msgNo", i);
			result = dao.deleteMessageBox(session, param);
		}
		return result;
	}
	
	@Override
	public int deleteMessageBoxOne(int msgNo, String msgbox) {
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("msgbox", msgbox);
		param.put("msgNo", msgNo);
		return dao.deleteMessageBox(session, param);
	}

	@Override
	public List<WishList> myWishList(String memberNo) {
		return dao.myWishList(session, memberNo);
	}

	@Override
	public int deleteWish(Map<String,String> param) {
		return dao.deleteWish(session, param);
	}
	
	@Override
	public int memberBalanceUpdate(Map<String,Object> param) {
		int result = 0;
		result = dao.memberBalanceUpdate(session, param);
		if(result>0) {
			result = dao.insertReceivMessageBoxAction(session, param);
		}
		return result;
	}
	
	@Override
	public List<Map<String,Object>> beforeDelete(String memberNo) {
		return dao.beforeDelete(session,memberNo);
	}
	
	@Override
	public String pwCheck(String memberNo) {
		return dao.pwCheck(session,memberNo);
	}
	
	@Override
	public int deleteMember(String memberNo) {
		return dao.deleteMember(session, memberNo);
	}

	
	
	
	@Override
	public int updateMember(Map<String, String> param) {
		return dao.updateMember(session, param);
	}
	
	@Override
	public List<Member> selectMemberList(Map param) {
		return dao.selectMemberList(session,param);
	}

	@Override
	public int emoneyCount(String memberNo) {
		return dao.emoneyCount(session,memberNo);
	}

	@Override
	public int emoneySelectCount(Map param) {
		return dao.emoneySelectCount(session,param);
	}
	
}
