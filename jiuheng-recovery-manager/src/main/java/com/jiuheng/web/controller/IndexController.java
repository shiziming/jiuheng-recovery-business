package com.jiuheng.web.controller;

import com.jiuheng.service.dto.BannerImage;
import com.jiuheng.service.dto.IndexPicture;
import com.jiuheng.service.dubbo.DubboIndexService;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import com.jiuheng.web.utils.SysUser;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class IndexController {

	@Autowired
	private DubboIndexService dubboIndexService;
	@RequestMapping("/index")
	public ModelAndView stockView(){		
		return new ModelAndView("index");
	}
	
	@RequestMapping("/login")
	public ModelAndView loginView(){		
		return new ModelAndView("login");
	}

	@RequestMapping("/index/picture")
	public ModelAndView picture(){
		return new ModelAndView("index/picture");
	}

	@RequestMapping("/index/savePicture")
	@ResponseBody
	public Response<Boolean> savePicture(@RequestBody IndexPicture pics,HttpServletRequest request){
		SysUser sysUser = (SysUser) request.getSession().getAttribute("user");
		for (BannerImage image:pics.getPics()) {
			image.setCreateUser(sysUser.getUserName());
			image.setStatus(1);
		}
		return dubboIndexService.savePicture(pics);
	}
	/**
	 *首页banner图接口
	 * @return
	 */
	@RequestMapping(value = "/index/bannerList")
	@ResponseBody
	public SearchResult getBannerImage(){
		SearchResult result = new SearchResult();
			List<BannerImage> list = dubboIndexService.getBannerImage();
		if(null != list && list.size()>0){
			result.setRows(list);
			result.setTotal(list.size());
		}
		return result;
	}
	@RequestMapping("/index/hotModel")
	public ModelAndView hotModel(){
		return new ModelAndView("index/hotModel");
	}

}
