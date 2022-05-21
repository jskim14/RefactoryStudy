package com.nb.spring.product.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.nb.spring.product.model.vo.Product;
import com.nb.spring.product.model.vo.ProductImage;
import com.nb.spring.product.model.vo.Review;
@Repository
public class ProductDaoImpl implements ProductDao {


	@Override
	public Product selectOneProductNo(SqlSessionTemplate session, String productNo) {
		
		return session.selectOne("product.selectOneProductNo",productNo);
	}
	
	@Override
	public int insertProduct(SqlSessionTemplate session, Product p) {
		return session.insert("product.insertProduct",p);
	}

	@Override

	public int updateBid(SqlSessionTemplate session, Map<String, String> param) {
		
		return session.update("product.updateBid", param);
	}

	@Override
	public int insertProductImg(SqlSessionTemplate session, ProductImage pi) {
		System.out.println(pi);
		return session.insert("product.insertProductImg",pi);
	}

	@Override
	public List<Review> selectReview(SqlSessionTemplate session, String sellerNo) {
		
		return session.selectList("product.selectReview",sellerNo);
	}

	@Override
	public int insertWishList(SqlSessionTemplate session, Map<String, String> param) {
		
		return session.insert("product.insertWishList", param);
	}

	@Override
	public int selectWishList(SqlSessionTemplate session, Map<String, String> param) {
		
		return session.selectOne("product.selectWishList",param);
	}

	@Override
	public Product updateProduct(SqlSessionTemplate session, String productNo) {
		return session.selectOne("product.updateProduct",productNo);
	}

	@Override
	public int updateProductEnd(SqlSessionTemplate session, Product p) {
		return session.update("product.updateProductEnd",p);
	}

//	@Override
//	public int updateProductImg(SqlSessionTemplate session, ProductImage pi) {
//		System.out.println(pi);
//		return session.update("product.updateProductImg",pi);
//	}

	@Override
	public List<Map<String, String>> selectBidderList(SqlSessionTemplate session, String productNo) {
	
		return session.selectList("product.selectBidderList",productNo);
		
	}

	@Override
	public int updateProductBuyNow(SqlSessionTemplate session, Map<String, Object> param) {
		
		return session.update("product.updateProductBuyNow", param);
	}

	@Override
	public List<Product> selectWaitingPermission(SqlSessionTemplate session,Map<String, Integer> param) {
		
		int cPage = param.get("cPage");
		int numPerPage = param.get("numPerPage");
		RowBounds rb = new RowBounds((cPage-1)*numPerPage,numPerPage);
		
		
		return session.selectList("product.selectWaitingPermission",null,rb);
	}

	@Override
	public int selectWaitingCount(SqlSessionTemplate session) {
		
		return session.selectOne("product.selectWaitingCount");
	}
	
	@Override
	public List<Product> selectListDeadLine(SqlSessionTemplate session) {
		return session.selectList("product.selectListDeadLine");
	}
	
	@Override
	public List<Product> selectListLatest(SqlSessionTemplate session) {
		return session.selectList("product.selectListLatest");
	}

	@Override
	public int updateProductReject(SqlSessionTemplate session, Map<String, Object> param) {
		
		return session.update("product.updateProductReject", param);
	}

	@Override
	public int updateProductPermission(SqlSessionTemplate session, String productNo) {
		
		return session.update("product.updateProductPermission", productNo);
	}

	@Override
	public int imgDelete(SqlSessionTemplate session, String productNo) {
		return session.delete("product.imgDelete", productNo);
	}

	@Override
	public int waitingDelete(SqlSessionTemplate session, String productNo) {
		return session.delete("product.waitingDelete", productNo);
	}
	
	@Override
	public int shippingSelect(SqlSessionTemplate session, String memberNo) {
		return session.update("product.shippingSelect", memberNo);
	}
	
	@Override
	public int endSellRealTimeAction(SqlSessionTemplate session, Map<String,Object> param) {
		return session.update("product.endSellRealTimeAction", param);
	}

	@Override
	public int buyEnd(SqlSessionTemplate session, String productNo) {
		return session.update("product.buyEnd", productNo);
	}
	
	@Override
	public int reInsertEnd(SqlSessionTemplate session, Product p) {
		return session.update("product.reInsertEnd",p);
	}

//	@Override
//	public int reInsertImg(SqlSessionTemplate session, ProductImage pi) {
//		System.out.println(pi);
//		return session.update("product.reInsertImg",pi);
//	}
		
	@Override	
	public int updateStatusFailure(SqlSessionTemplate session) {
		// TODO Auto-generated method stub
		return session.update("product.updateStatusFailure");
	}

	@Override
	public Product selectOneSpecialProduct(SqlSessionTemplate session) {
		
		return session.selectOne("product.selectOneSpecilProduct");
	}
	
	@Override
	public List<Product> searchProduct(SqlSessionTemplate session, Map<String,Object> param) {
		int cPage = (int)param.get("cPage");
		int numPerPage = (int)param.get("numPerPage");
		return session.selectList("product.searchProduct", param, new RowBounds((cPage-1)*numPerPage,numPerPage));
	}
	
	@Override
	public List<ProductImage> searchProductImg(SqlSessionTemplate session, String productNo) {
		return session.selectList("product.searchProductImg", productNo);
	}
	
	@Override
	public List<Product> searchProductCount(SqlSessionTemplate session, Map<String,Object> param) {
		return session.selectList("product.searchProductCount", param);
	}
	
	@Override
	public List<Product> selectSpecialProductList(SqlSessionTemplate session) {
		return session.selectList("product.selectSpecialProductList");
	}
	
	@Override
	public List<Product> selectListHighPrice(SqlSessionTemplate session) {
		return session.selectList("product.selectListHighPrice");
	}
	
	@Override
	public List<Product> endAuction(SqlSessionTemplate session) {
		return session.selectList("product.endAuction");
	}
	
	@Override
	public int successfulBidUpdate(SqlSessionTemplate session, Product key) {
		return session.update("product.successfulBidUpdate");
	}
	
	@Override
	public List<Product> selectOtherList(SqlSessionTemplate session, String memberNo) {
		
		return session.selectList("product.selectOtherList",memberNo);
	}
	
	@Override
	public int updateendAuction(SqlSessionTemplate session, String productNo) {
		return session.update("product.updateendAuction", productNo);
	}

	@Override
	public List<Product> auctionItemsList(SqlSessionTemplate session, int cPage, int numPerPage,
			String category) {
		return session.selectList("product.auctionItemsList", category, new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int auctionItemsListCount(SqlSessionTemplate session, String category) {
		return session.selectOne("product.auctionItemsListCount", category);
	}

	@Override
	public List<ProductImage> auctionItemsListImg(SqlSessionTemplate session, String productNo) {
		return session.selectList("product.auctionItemsListImg", productNo);
	}

	@Override
	public List<Product> specialauctionList(SqlSessionTemplate session, int cPage, int numPerPage) {
		return session.selectList("product.specialauctionList", null, new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int specialauctionListCount(SqlSessionTemplate session) {
		return session.selectOne("product.specialauctionListCount");
	}
	
	public int sellerDeposit(SqlSessionTemplate session, Product p) {
		return session.insert("product.sellerDeposit", p);
	}
	
}
