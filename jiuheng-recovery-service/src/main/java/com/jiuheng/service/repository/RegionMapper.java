package com.jiuheng.service.repository;

import com.jiuheng.service.dto.Region;
import java.util.List;

/**
 * Created by shiziming on 2018/12/11.
 */
public interface RegionMapper {

    List<Region> getProvinces();

    List<Region> getCitys(String provinceId);

    List<Region> getCountys(String cityId);

    Region getRegionByCode(String code);

}
