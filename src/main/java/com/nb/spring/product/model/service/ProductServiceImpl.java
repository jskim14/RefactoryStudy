package com.nb.spring.product.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nb.spring.member.model.vo.Member;
import com.nb.spring.product.model.dao.ProductDao;
import com.nb.spring.product.model.vo.Product;
import com.nb.spring.product.model.vo.ProductImage;
import com.nb.spring.product.model.vo.Review;
@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	private SqlSessionTemplate session;
	
	@Autowired
	private ProductDao dao;
	
	@Override
	public Product selectOneProductNo(String productNo) {
		
		Product product = dao.selectOneProductNo(session, productNo);
		return product;
	}
	
	@Override
	public int insertProduct(Product p) {
		int result = dao.insertProduct(session, p);
		if(result>0 && !p.getImages().isEmpty()) {
			try {
				for(ProductImage pi : p.getImages()) {
					pi.setProductNo(p.getProductNo());
					result = dao.insertProductImg(session, pi);
				}				
			} catch(RuntimeException e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	@Override
	public int updateBid(Map<String, String> param) {
		int result = dao.updateBid(session,param);
		return result;
	}

	@Override
	public List<Review> selectReview(String sellerNo) {
		List<Review> list = dao.selectReview(session,sellerNo);
		return list;
	}

	@Override
	public int insertWishList(Map<String, String> param) {
		int result = dao.insertWishList(session, param);
		return result;
	}

	@Override
	public int selectWishList(Map<String, String> param) {
		int result = dao.selectWishList(session, param);
		return result;
	}

	@Override
	public Product updateProduct(String productNo) {
		Product p = dao.updateProduct(session, productNo);
		return p;
	}

	@Override
	public int updateProductEnd(Product p) {
		int result = dao.updateProductEnd(session, p);
		if(result>0 && !p.getImages().isEmpty()) {
			try {
				for(ProductImage pi : p.getImages()) {
					pi.setProductNo(p.getProductNo());
					result = dao.insertProductImg(session, pi);
				}				
			} catch(RuntimeException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	@Override
	public List<Product> selectListDeadLine(int startNum, int finishNum) {
		List<Product> result = new ArrayList<Product>();
		List<Product> list = dao.selectListDeadLine(session);
		if(list.size()>finishNum) {
			for(int i=startNum; i<=finishNum; i++) {
				Product p = list.get(i);
				result.add(p);
			}
		}else if(list.size()<=startNum){
			result = null;
		}else {
			for(int i=startNum; i<list.size(); i++) {
				Product p = list.get(i);
				result.add(p);
			}
		}
		return result;
	}

	@Override
	public List<Product> selectListLatest(int startNum, int finishNum) {
		List<Product> result = new ArrayList<Product>();
		List<Product> list = dao.selectListLatest(session);
		if(list.size()>finishNum) {
			for(int i=startNum; i<=finishNum; i++) {
				Product p = list.get(i);
				result.add(p);
			}
		}else if(list.size()<=startNum){
			result = null;
		}else {
			for(int i=startNum; i<list.size(); i++) {
				Product p = list.get(i);
				result.add(p);
			}
		}
		return result;
	}
	@Override
	public List<Map<String, String>> selectBidderList(String productNo) {
		
		return dao.selectBidderList(session,productNo);
	}

	@Override
	public int updateProductBuyNow(Map<String, Object> param) {
		
		return dao.updateProductBuyNow(session,param);
	}

	@Override
	public List<Product> selectWaitingPermission(Map<String, Integer> param) {
		// TODO Auto-generated method stub
		return dao.selectWaitingPermission(session,param);
	}

	@Override
	public int selectWaitingCount() {
	
		return dao.selectWaitingCount(session);
	}

	@Override
	public int updateProductReject(Map<String, Object> param) {
		
		return dao.updateProductReject(session,param);
	}

	@Override
	public int updateProductPermission(String productNo) {
		
		return dao.updateProductPermission(session,productNo);
	}

	@Override
	public int imgDelete(String productNo) {
		return dao.imgDelete(session, productNo);
	}
	
	@Override
	public int waitingDelete(String productNo) {
		return dao.waitingDelete(session, productNo);
	}
	
	@Override
	public int shippingSelect(String productNo) {
		int result = dao.shippingSelect(session, productNo);
		return result;
	}
	
	@Override
	public int endSellRealTimeAction(Map<String,Object> param) {
		return dao.endSellRealTimeAction(session, param);
	}
	
	@Override
	public List<Product> searchProduct(Map<String,Object> param) {
		List<Product> list = dao.searchProduct(session, param);
		for(Product p : list) {
			List<ProductImage> proImg = dao.searchProductImg(session, p.getProductNo());
			p.setImages(proImg);
		}
		return list;
	}
	
	@Override
	public List<Product> searchProductCount(Map<String,Object> param) {
		return dao.searchProductCount(session, param);
	}
	
	@Override
	public int buyEnd(String productNo) {
		int result = dao.buyEnd(session, productNo);
		return result;
	}
	
	@Override
	public int reInsertEnd(Product p) {
		int result = dao.reInsertEnd(session, p);
		if(result>0 && !p.getImages().isEmpty()) {
			try {
				for(ProductImage pi : p.getImages()) {
					pi.setProductNo(p.getProductNo());
					result = dao.insertProductImg(session, pi);
				}				
			} catch(RuntimeException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public int updateStatusFailure() {
		
		return dao.updateStatusFailure(session);
	}

	@Override
	public Product selectOneSpecialProduct() {
		
		return dao.selectOneSpecialProduct(session);
	}
	
	@Override
	public List<Product> selectSpecialProductList() {
		List<Product> list = dao.selectSpecialProductList(session);
		List<Product> result = new ArrayList<Product>();
		if(!list.isEmpty()) {
			for(Product p : list) {
				if(result.size()<5) {
					result.add(p);
				}
			}
		}
		return result;
	}
	
	@Override
	public List<Product> selectListHighPrice(int startNum, int finishNum) {
		List<Product> result = new ArrayList<Product>();
		List<Product> list = dao.selectListHighPrice(session);
		if(list.size()>finishNum) {
			for(int i=startNum; i<=finishNum; i++) {
				Product p = list.get(i);
				result.add(p);
			}
		}else if(list.size()<=startNum){
			result = null;
		}else {
			for(int i=startNum; i<list.size(); i++) {
				Product p = list.get(i);
				result.add(p);
			}
		}
		return result;
	}
	@Override
	public int successfulBidUpdate() {
		List<Product> list = dao.endAuction(session);
		int result = 0;
		for(Product p : list) {
			if(p.getProductStatus().equals("0")) {
				result += dao.updateendAuction(session, p.getProductNo());
			}
		}
		return result;
	}
	
	@Override
	public List<Product> selectOtherList(String memberNo) {
		
		return dao.selectOtherList(session,memberNo);
	}

	@Override
	public List<Product> auctionItemsList(int cPage, int numPerPage, String category) {
		List<Product> list = dao.auctionItemsList(session, cPage, numPerPage, category);
		for(Product p : list) {
			p.setImages(dao.auctionItemsListImg(session,p.getProductNo()));
		}
		return list;
	}

	@Override
	public int auctionItemsListCount(String category) {
		return dao.auctionItemsListCount(session, category);
	}

	@Override
	public List<Product> specialauctionList(int cPage, int numPerPage) {
		List<Product> list = dao.specialauctionList(session, cPage, numPerPage);
		for(Product p : list) {
			p.setImages(dao.auctionItemsListImg(session,p.getProductNo()));
		}
		return list;
	}

	@Override
	public int specialauctionListCount() {
		return dao.specialauctionListCount(session);
	}
	
	public int sellerDeposit(Product p) {
		return dao.sellerDeposit(session, p);
	}
	
	
}
