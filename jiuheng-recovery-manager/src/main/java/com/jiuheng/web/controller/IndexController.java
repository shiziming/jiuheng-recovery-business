package com.jiuheng.web.controller;

import com.jiuheng.service.domain.BrandReq;
import com.jiuheng.service.domain.CategoryReq;
import com.jiuheng.service.dto.BannerImage;
import com.jiuheng.service.dto.HotGoods;
import com.jiuheng.service.dto.IndexPicture;
import com.jiuheng.service.dubbo.DubboBrandService;
import com.jiuheng.service.dubbo.DubboCategoryService;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class IndexController {

	@Autowired
	private DubboIndexService dubboIndexService;
	@Autowired
	private DubboCategoryService dubboCategoryService;
	@Autowired
	private DubboBrandService dubboBrandService;
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

	@RequestMapping("/index/hotModelManager")
	public ModelAndView hotModelManager(int row){
		ModelAndView m = new ModelAndView("index/hotModelManager");
		CategoryReq categoryReq = new CategoryReq();
		m.addObject("categories", dubboCategoryService.getCategoryList(categoryReq,0, 0).getResult().getRows());
		//加入-2的条件 停用的品牌也需要显示出来
		BrandReq brand = new BrandReq();
		m.addObject("brands", dubboBrandService.getAllBranch(brand, 0,0).getResult().getRows());
		m.addObject("row",row);
		return m;
	}

	@RequestMapping("/index/getHotModelList")
	@ResponseBody
	public SearchResult getHotModelList(){
		SearchResult result = new SearchResult();
		List<HotGoods> list = dubboIndexService.getHotGoodsList();
		if(null != list && list.size()>0){
			result.setRows(list);
			result.setTotal(list.size());
		}
		return result;
	}

	@RequestMapping("/index/saveHotModels")
	@ResponseBody
	public Response<Boolean> saveHotModels(@RequestBody List<HotGoods> hotModels,HttpServletRequest request){
		SysUser sysUser = (SysUser) request.getSession().getAttribute("user");
		for (HotGoods hotGood:hotModels) {
			hotGood.setCreateUser(sysUser.getUserName());
			hotGood.setStatus(1);
		}
		return dubboIndexService.saveHotModels(hotModels);
	}
}
