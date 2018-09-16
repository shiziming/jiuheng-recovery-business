package com.jiuheng.service.dubbo;

import com.jiuheng.service.domain.Menu;
import java.util.List;

/**
 * Created by shiziming on 2018/6/24.
 */
public interface DubboMenuService {

    List<Menu> queryMenu();
}
