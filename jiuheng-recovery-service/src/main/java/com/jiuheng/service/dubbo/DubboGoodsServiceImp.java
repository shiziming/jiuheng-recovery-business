package com.jiuheng.service.dubbo;

import com.github.pagehelper.PageHelper;
import com.jiuheng.service.domain.Brand;
import com.jiuheng.service.domain.BrandReq;
import com.jiuheng.service.domain.CategoryResp;
import com.jiuheng.service.domain.GoodsAttribute;
import com.jiuheng.service.domain.GoodsReq;
import com.jiuheng.service.domain.GoodsResp;
import com.jiuheng.service.repository.AttributeMapper;
import com.jiuheng.service.repository.BranchMapper;
import com.jiuheng.service.repository.CategoryMapper;
import com.jiuheng.service.repository.GoodsMapper;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import com.jiuheng.service.utils.EasyUiDataGridUtil;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by shiziming on 2018/7/6.
 */
@Service("dubboGoodsService")
public class DubboGoodsServiceImp implements DubboGoodsService{

    private Logger log = LoggerFactory.getLogger(DubboCategoryService.class);

    @Autowired
    private GoodsMapper goodsMapper;
    @Autowired
    private CategoryMapper categoryMapper;
    @Autowired
    private BranchMapper branchMapper;
    @Autowired
    private AttributeMapper attributeMapper;
    @Override
    public Response<SearchResult> getGoodsList(GoodsReq goodsReq, int pageNo, int pageSize){
        try {
            if (goodsReq == null) {
                goodsReq = new GoodsReq();
            }
            if(pageSize != 0){
                PageHelper.startPage(pageNo, pageSize);
            }
            List<GoodsResp> respList = goodsMapper.getGoodsList(goodsReq);
            return Response.ok(EasyUiDataGridUtil.convertToResult(respList));
        } catch (Exception e) {
            log.error("DubboGoodsService.getGoodsList",e);
            return Response.fail(e.getMessage());
        }
    }

    @Override
    public Response<GoodsResp> getGoodsById(Integer goodsId) {
        try {
            GoodsResp resp = null;
            if (goodsId > 0) {
                resp = goodsMapper.getGoodsById(goodsId);
            }
            return Response.ok(resp);
        } catch (Exception e) {
            log.error("DubboGoodsService.getGoodsById",e);
            return Response.fail(e.getMessage());
        }

    }

    @Override
    public Response<Boolean> saveGoods(GoodsReq goodsReq) {
        try {
            setGoodsIndexPath(goodsReq);
            goodsReq.setStatus(1);
            goodsMapper.insertGoods(goodsReq);
            // 保存设备属性值
            List<GoodsAttribute> attrs = goodsReq.getAttrs();
            if (attrs != null && !attrs.isEmpty()) {
                for (GoodsAttribute attr : attrs) {
                    attr.setGoodsId(goodsReq.getId());
                    if (attr.getId() == null) {
                        attributeMapper.insertGoodsAttributeValue(attr);
                    } else {
                        throw new IllegalStateException("新增时，属性值id不为空");
                    }
                }

            }
            return Response.ok(Boolean.TRUE);
        } catch (IllegalStateException e) {
            log.error("DubboGoodsService.saveGoods",e);
            return Response.fail(e.getMessage());
        }
    }

    @Override
    public Response<Boolean> updateGoods(GoodsReq goodsReq){
        try {
            setGoodsIndexPath(goodsReq);
            goodsMapper.updateGoods(goodsReq);
            // 保存设备属性值
            List<GoodsAttribute> attrs = goodsReq.getAttrs();
            if (attrs != null && !attrs.isEmpty()) {
                for (GoodsAttribute attr : attrs) {
                    attr.setGoodsId(goodsReq.getId());
                    if (attr.getId() == null) {
                        attributeMapper.insertGoodsAttributeValue(attr);
                    } else {
                        attributeMapper.updateGoodsAttributeValue(attr);
                    }
                }

            }
            return Response.ok(Boolean.TRUE);
        } catch (Exception e) {
            log.error("DubboGoodsService.updateGoods",e);
            return Response.fail(e.getMessage());
        }

    }

    private void setGoodsIndexPath(GoodsReq goodsReq) {
        // 查询分类path
        if (goodsReq.getCategoryId() == null || goodsReq.getCategoryId() <= 0) {
            throw new IllegalArgumentException("未选择分类!");
        }
        CategoryResp categoryResp = categoryMapper.getDeviceCategory(goodsReq.getCategoryId());

        // 查询品牌名
        if (goodsReq.getBrandId() == null || goodsReq.getBrandId() <= 0) {
            throw new IllegalArgumentException("未选择品牌!");
        }
        BrandReq brandReq = new BrandReq();
        brandReq.setId(goodsReq.getBrandId());
        Brand brand = branchMapper.getBrandById(brandReq);

        goodsReq.setIndexPath(categoryResp.getPathName() + " >> " + brand.getName() + " >> " + goodsReq.getModel());
    }

    @Override
    public Response<Boolean> updateGoodsStatus(GoodsReq goodsReq) {
        try {
            goodsMapper.updateGoods(goodsReq);
            return Response.ok(Boolean.TRUE);
        } catch (Exception e) {
            log.error("DubboGoodsService.updateGoodsStatus",e);
            return Response.fail(e.getMessage());
        }
    }


    @Override
    public Response<Boolean> deleteGoods(GoodsReq goodsReq) {
        try {
            goodsMapper.updateGoods(goodsReq);
            return Response.ok(Boolean.TRUE);
        } catch (Exception e) {
            log.error("DubboGoodsService.deleteGoods",e);
            return Response.fail(e.getMessage());
        }
    }

    @Override
    public Response<Boolean> duplicateGoods(Integer goodsId,String userName){

        try {
            GoodsResp resp = goodsMapper.getGoodsById(goodsId);
            GoodsReq rep = new GoodsReq();
            BeanUtils.copyProperties(resp, rep);

            rep.setId(null);
            rep.setModel(resp.getModel() + "_副本");
            rep.setCreateTime(null);
            rep.setUpdateTime(null);
            rep.setUpdator(userName);
            List<GoodsAttribute> attrs = rep.getAttrs();
            if (attrs != null && !attrs.isEmpty()) {
                for (GoodsAttribute attr : attrs) {
                    attr.setId(null);
                }
            }
            saveGoods(rep);
            return Response.ok(Boolean.TRUE);
        } catch (BeansException e) {
            log.error("DubboGoodsService.duplicateGoods",e);
            return Response.fail(e.getMessage());
        }
    }

}
