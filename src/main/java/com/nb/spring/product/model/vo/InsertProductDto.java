package com.nb.spring.product.model.vo;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class InsertProductDto {

    private String sellerNo;
    private String maxDate;
    private String maxTime;
    private String unit;
    private String productNo;

}
