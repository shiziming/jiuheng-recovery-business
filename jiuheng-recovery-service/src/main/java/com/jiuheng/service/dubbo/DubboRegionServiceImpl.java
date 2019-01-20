package com.jiuheng.service.dubbo;

import com.jiuheng.service.dto.Region;
import com.jiuheng.service.dto.RegionList;
import com.jiuheng.service.repository.RegionMapper;
import com.jiuheng.service.respResult.CommonResult;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by shiziming on 2018/12/11.
 */
@Service("dubboRegionService")
public class DubboRegionServiceImpl implements DubboRegionService{

    private Logger log = LoggerFactory.getLogger(DubboRegionServiceImpl.class);

    @Autowired
    private RegionMapper regionMapper;
    @Override
    public CommonResult<RegionList> getProvinces(){
        CommonResult<RegionList> result = null;
        try {
            List<Region> list = regionMapper.getProvinces();
            RegionList regionList =new RegionList();
            regionList.setProvinces(list);
            result = new CommonResult<RegionList>(regionList);
            return result;
        } catch (Exception e) {
            log.error("DubboRegionService.getProvinces",e);
            return result;
        }
    }

    @Override
    public CommonResult<RegionList> getCitys(String provinceId) {
        CommonResult<RegionList> result = null;
        try {
            List<Region> list = regionMapper.getCitys(provinceId);
            RegionList regionList =new RegionList();
            regionList.setCitys(list);
            result = new CommonResult<RegionList>(regionList);
            return result;
        } catch (Exception e) {
            log.error("DubboRegionService.getCitys",e);
            return result;
        }
    }

    @Override
    public CommonResult<RegionList> getCountys(String cityId) {
        CommonResult<RegionList> result = null;
        try {
            List<Region> list = regionMapper.getCountys(cityId);
            RegionList regionList =new RegionList();
            regionList.setCountys(list);
            result = new CommonResult<RegionList>(regionList);
            return result;
        } catch (Exception e) {
            log.error("DubboRegionService.getCountys",e);
            return result;
        }
    }
    @Override
    public CommonResult<Region> getRegionByCode(String code){
        CommonResult<Region> result = null;
        try {
            Region region = regionMapper.getRegionByCode(code);
            result = new CommonResult<Region>(region);
            return result;
        } catch (Exception e) {
            log.error("DubboRegionService.getRegionByCode",e);
        }
        return result;
    }

}
