package com.jiuheng.service.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import lombok.Data;

/**
 * Created by shiziming on 2019/1/19.
 */
@Data
public class IndexPicture implements Serializable{

    private List<BannerImage> pics = new ArrayList<>();


}
