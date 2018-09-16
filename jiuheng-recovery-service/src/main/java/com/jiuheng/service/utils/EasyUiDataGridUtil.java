package com.jiuheng.service.utils;

import com.jiuheng.service.respResult.SearchResult;
import java.util.List;

import net.sf.json.JSONObject;

import com.github.pagehelper.Page;

/**
 * @author Cheng.Biao
 * @Description:easyui表格工具类
 * @date 2015年1月29日下午3:57:10
 */
public class EasyUiDataGridUtil {
	/**
	 * 将list转成datagrid所需的字符串
	 * 
	 * @param gridLists
	 * @return
	 */
	public static String convertList(List<?> gridLists) {
		JSONObject jo = new JSONObject();
		if (null != gridLists) {
			if (gridLists instanceof Page) {
				Page<?> page = (Page<?>) gridLists;
				jo.put("total", page.getTotal());
				jo.put("rows", page.getResult());
			} else {
				jo.put("total", gridLists.size());
				jo.put("rows", gridLists);
			}
		} else {
			jo.put("total", 0);
			jo.put("rows", null);
		}
		return jo.toString();
	}

	public static SearchResult convertToResult(List<?> gridLists) {
		SearchResult searchResult = null;
		if (null != gridLists) {
			if (gridLists instanceof Page) {
				Page<?> page = (Page<?>) gridLists;
				searchResult = new SearchResult(page.getTotal(),
						page.getResult());
			} else {
				searchResult = new SearchResult(gridLists.size(), gridLists);
			}
		} else {
			searchResult = new SearchResult(0, null);
		}
		return searchResult;
	}
}
