package com.jiuheng.order.dubbo;

import com.jiuheng.order.domain.Menu;
import com.jiuheng.order.repository.MenuMapper;
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
    public List<Menu> queryMenu(){
        List<Menu> list=menuMapper.queryMenu();
        return list;
    }

}
