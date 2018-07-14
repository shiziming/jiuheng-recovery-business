package com.jiuheng.order.repository;

import com.jiuheng.order.domain.BrandResp;
import com.jiuheng.order.domain.BrandReq;
import java.util.List;

/**
 * Created by shiziming on 2018/7/10.
 */
public interface BranchMapper {

    List<BrandResp> getAllBranch(BrandReq req,int page,int row);

}
