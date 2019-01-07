package com.jiuheng.service.dubbo;

import com.jiuheng.service.domain.RecycleQuotation;
import com.jiuheng.service.domain.RecycleQuotationItem;
import com.jiuheng.service.domain.RecycleQuotationItemVo;
import com.jiuheng.service.domain.RecycleQuotationVo;
import com.jiuheng.service.repository.RecoveryQuotationMapper;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by shiziming on 2018/11/10.
 */
@Service("dubboRecoveryQuotationService")
public class DubboRecoveryQuotationServiceImp implements DubboRecoveryQuotationService{

    @Autowired
    private RecoveryQuotationMapper recoveryQuotationMapper;
    @Override
    public List<RecycleQuotationVo> getRecycleQuotationList(RecycleQuotation recycleQuotation,int page,int pageSize){
        return recoveryQuotationMapper.getRecycleQuotationList(recycleQuotation, page * pageSize - pageSize, pageSize);
    }

    @Override
    public int getRecycleQuotationCount(RecycleQuotation recycleQuotation) {
        return recoveryQuotationMapper.getRecycleQuotationCount(recycleQuotation);
    }

    @Override
    public RecycleQuotationVo getRecycleQuotationById(Long id) {
        return recoveryQuotationMapper.getRecycleQuotationById(id);
    }

    @Override
    public RecycleQuotationVo getRecycleQuotation(Integer deviceId) {
        return recoveryQuotationMapper.getRecycleQuotation(deviceId);
    }

    @Override
    public List<RecycleQuotationItemVo> getRecycleQuotationItem(Integer deviceId,Long quotationId) {
        return recoveryQuotationMapper.getRecycleQuotationItem(deviceId,quotationId);
    }

    @Override
    public void saveRecycleQuotation(RecycleQuotation recycleQuotation) {
        if(recycleQuotation.getId() == null){
            recoveryQuotationMapper.addRecycleQuotation(recycleQuotation);
        }else{
            recoveryQuotationMapper.updateRecycleQuotation(recycleQuotation);
        }
    }

    @Override
    public void saveRecycleQuotationItem(RecycleQuotationItem recycleQuotationItem) {
        if(recycleQuotationItem.getId() == null){
            recoveryQuotationMapper.addRecycleQuotationItem(recycleQuotationItem);
        }else{
            recoveryQuotationMapper.updateRecycleQuotationItem(recycleQuotationItem);
        }

    }


}
