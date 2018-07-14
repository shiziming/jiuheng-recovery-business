package com.jiuheng.order.dubbo;

import com.jiuheng.order.domain.Menu;
import java.util.List;

/**
 * Created by shiziming on 2018/6/24.
 */
public interface DubboMenuService {

    List<Menu> queryMenu();
}
