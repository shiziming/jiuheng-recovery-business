package com.jiuheng.service.dubbo;

/**
 * Created by shiziming on 2018/9/9.
 */
public interface DubboValidCodeService {

    long checkVaildCode(String validrand,String validCode);
}
