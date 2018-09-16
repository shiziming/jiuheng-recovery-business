package com.jiuheng.service.domain;

import java.io.Serializable;
import lombok.Data;

/**
 * Created by shiziming on 2018/7/14.
 * 品牌品类关联bean
 */
@Data
public class BrandCategory implements Serializable{

    private static final long serialVersionUID = 8520977163422943649L;
    private Integer brandId;

    private Integer categoryId;

    private String brandName;

    private String categoryName;

}
