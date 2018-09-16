package com.jiuheng.service.domain;

import java.util.List;
import lombok.Data;

/**
 * Created by shiziming on 2018/8/15.
 */
@Data
public class CategoryRecycleAttribute extends CategoryAttributeVo{

    private List<GoodsAttribute> goodsRecycleAttributeValueList;

}
