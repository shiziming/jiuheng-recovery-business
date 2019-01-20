package com.jiuheng.service.dto;

import java.io.Serializable;
import java.util.List;
import lombok.Data;

/**
 * Created by shiziming on 2018/12/11.
 */
@Data
public class RegionList implements Serializable{

    private static final long serialVersionUID = 15537833390112432L;
    private List<Region> countys;

    private List<Region> citys;

    private List<Region> provinces;

}
