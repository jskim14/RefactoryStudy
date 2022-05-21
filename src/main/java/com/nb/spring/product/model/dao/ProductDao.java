package com.nb.spring.product.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.nb.spring.product.model.vo.Product;
import com.nb.spring.product.model.vo.ProductImage;
import com.nb.spring.product.model.vo.Review;

public interface ProductDao {

	Product selectOneProductNo(SqlSessionTemplate session, String productNo);
	
	int insertProduct(SqlSessionTemplate session, Product p);
	
	int insertProductImg(SqlSessionTemplate session, ProductImage pi);

	int updateBid(SqlSessionTemplate session, Map<String, String> param);

	List<Review> selectReview(SqlSessionTemplate session, String sellerNo);

	int insertWishList(SqlSessionTemplate session, Map<String, String> param);

	int selectWishList(SqlSessionTemplate session, Map<String, String> param);
	
	Product updateProduct(SqlSessionTemplate session, String productNo);
	
	int updateProductEnd(SqlSessionTemplate session, Product p);
	
//	int updateProductImg(SqlSessionTemplate session, ProductImage pi);
	
	List<Product> selectListDeadLine(SqlSessionTemplate session);

	List<Product> selectListLatest(SqlSessionTemplate session);
	
	List<Map<String, String>> selectBidderList(SqlSessionTemplate session, String productNo);

	int updateProductBuyNow(SqlSessionTemplate session, Map<String, Object> param);

	List<Product> selectWaitingPermission(SqlSessionTemplate session, Map<String, Integer> param);

	int selectWaitingCount(SqlSessionTemplate session);

	int updateProductReject(SqlSessionTemplate session, Map<String, Object> param);

	int updateProductPermission(SqlSessionTemplate session, String productNo);
	
	int imgDelete(SqlSessionTemplate session, String productNo);
	
	int waitingDelete(SqlSessionTemplate session, String productNo);
	
	int shippingSelect(SqlSessionTemplate session, String memberNo);
	
	int endSellRealTimeAction(SqlSessionTemplate session, Map<String,Object> param);
	
	int buyEnd(SqlSessionTemplate session, String memberNo);
	
	int reInsertEnd(SqlSessionTemplate session, Product p);
	
//	int reInsertImg(SqlSessionTemplate session, ProductImage pi);
	
	List<Product> searchProduct(SqlSessionTemplate session, Map<String,Object> param);
	
	List<ProductImage> searchProductImg(SqlSessionTemplate session, String productNo);
	
	List<Product> searchProductCount(SqlSessionTemplate session, Map<String,Object> param);

	int updateStatusFailure(SqlSessionTemplate session);

	Product selectOneSpecialProduct(SqlSessionTemplate session);
	
	List<Product> selectSpecialProductList(SqlSessionTemplate session);
	
	List<Product> selectListHighPrice(SqlSessionTemplate session);
	
	List<Product> endAuction(SqlSessionTemplate session);
	
	int successfulBidUpdate(SqlSessionTemplate session, Product key);

	List<Product> selectOtherList(SqlSessionTemplate session, String memberNo);
	
	int updateendAuction(SqlSessionTemplate session, String productNo);
	
	List<Product> auctionItemsList(SqlSessionTemplate session, int cPage, int numPerPage, String category);
	
	int auctionItemsListCount(SqlSessionTemplate session, String category);
	
	List<ProductImage> auctionItemsListImg(SqlSessionTemplate session, String productNo);
	
	List<Product> specialauctionList(SqlSessionTemplate session, int cPage, int numPerPage);
	
	int specialauctionListCount(SqlSessionTemplate session);
	
	int sellerDeposit(SqlSessionTemplate session, Product p);
}
