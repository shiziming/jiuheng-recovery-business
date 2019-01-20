package com.jiuheng.service.dubbo;

import com.jiuheng.service.dto.Region;
import com.jiuheng.service.dto.RegionList;
import com.jiuheng.service.respResult.CommonResult;

/**
 * Created by shiziming on 2018/12/11.
 */
public interface DubboRegionService {

    public CommonResult<RegionList> getProvinces();

    public CommonResult<RegionList> getCitys(String provinceId);

    public CommonResult<RegionList> getCountys(String cityId);

    public CommonResult<Region> getRegionByCode(String code);

}
