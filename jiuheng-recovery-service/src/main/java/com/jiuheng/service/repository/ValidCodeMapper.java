package com.jiuheng.service.repository;

/**
 * Created by shiziming on 2018/9/9.
 */
public interface ValidCodeMapper {

    long checkVaildCode(String validrand,String validCode);

}
