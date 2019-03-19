package com.jiuheng.service.dubbo;

import com.jiuheng.service.domain.Menu;
import com.jiuheng.service.repository.MenuMapper;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by shiziming on 2018/6/24.
 */
@Service("dubboMenuService")
public class DubboMenuServiceImp implements DubboMenuService{

    @Autowired
    private MenuMapper menuMapper;

    @Override
    public List<Menu> queryMenu(Integer userId){
        List<Menu> list=menuMapper.queryMenu(userId);
        return list;
    }

}
