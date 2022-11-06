package com.nb.spring.product.module;

import com.nb.spring.member.model.vo.Member;
import com.nb.spring.product.model.vo.InsertProductDto;
import com.nb.spring.product.model.vo.Product;
import com.nb.spring.product.model.vo.ProductImage;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

@Slf4j
public class EnrollProduct {

    public Product process(Product product, InsertProductDto insertProductDto, MultipartFile[] imageFile, HttpServletRequest req) throws ParseException {
        //buynow
        if(product.getBuyNowPrice().equals("")) {
            product.setBuyNowPrice("0");
        }

        //date
        utilDateToSqldate(product, insertProductDto);

        //seller
        product.setSeller(new Member());
        product.getSeller().setMemberNo(insertProductDto.getSellerNo());

        //bidUnit
        settingBidUnit(product, insertProductDto);

        //file
        String path = req.getServletContext().getRealPath("/resources/upload/product/");
        File f = new File(path);
        if(!f.exists()) f.mkdir();
        product.setImages(new ArrayList<ProductImage>());
        for(MultipartFile mf : imageFile) {
            if(!mf.isEmpty()) {
                String originalFileName = mf.getOriginalFilename();
                String ext = originalFileName.substring(originalFileName.lastIndexOf("."));

                SimpleDateFormat sdf = new SimpleDateFormat("ddMMyyHHmmssss");
                int ranNum = (int)(Math.random()*1000);
                String renameFile = sdf.format(System.currentTimeMillis())+"_"+ranNum+ext;
                try {
                    mf.transferTo(new File(path+renameFile));
                    ProductImage pi = ProductImage.builder().imageName(renameFile).build();
                    product.getImages().add(pi);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        log.info("product = {}", product);
        return product;
    }

    private void utilDateToSqldate(Product product, InsertProductDto insertProductDto) throws ParseException {
        String date = insertProductDto.getMaxDate()+" "+insertProductDto.getMaxTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        Date utilDate = sdf.parse(date);
        java.sql.Date endDate = new java.sql.Date(utilDate.getTime());
        product.setEndDate(endDate);
    }

    private void settingBidUnit(Product product, InsertProductDto insertProductDto) {
        String[] splitUnit = insertProductDto.getUnit().split(",");
        if(insertProductDto.getUnit().contains(",")) {
            product.setBidUnit(splitUnit[1]);
        } else {
            product.setBidUnit(insertProductDto.getUnit());
        }
    }
}
