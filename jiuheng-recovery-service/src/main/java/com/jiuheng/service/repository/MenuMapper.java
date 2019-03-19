package com.jiuheng.service.repository;

import com.jiuheng.service.domain.Menu;
import com.jiuheng.service.domain.UserPower;
import java.util.List;

public interface MenuMapper {

    List<Menu> queryMenu(Integer userId);

    List<Menu> queryModel();

    List<Menu> queryAllMenu();

    List<Menu> queryFunctionByFatherId(String modelid);
}