package com.jiuheng.service.dubbo;

import com.jiuheng.service.repository.ValidCodeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by shiziming on 2018/9/9.
 */
@Service("dubboValidCodeService")
public class DubboValidCodeServiceImpl implements DubboValidCodeService {

    @Autowired
    private ValidCodeMapper validCodeMapper;

    public long checkVaildCode(String validrand,String validCode){
        long phone = validCodeMapper.checkVaildCode(validrand,validCode);
        return phone;
    }

}
