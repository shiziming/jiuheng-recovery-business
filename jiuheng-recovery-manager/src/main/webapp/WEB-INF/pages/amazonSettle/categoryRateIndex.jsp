<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="categoryRatePage">
	<div id="listPanel">
		<table id="dataGrid"></table>
		<div id="tb" style="height: auto">
			<div class="search">
				<form id="searchForm">
					<table>
						<tr>
<!-- 							<td class="label">商品大类:</td>  -->
<!-- 							<td width="100px"> -->
<!-- 							   <input id="goodsCat" class="easyui-combobox" style="width: 150px;" -->
<!-- 		                              data-options="loader:categoryrate.goodsCatLoader,mode:'remote',required:true,valueField:'value',textField:'text'"> -->
<!--                             </td> -->
                                <td class="label">渠道代码:</td> 
								<td width="100px" class="content">
								   <input name="channelId"/>
	                            </td>
							
							<td> <a id="btnSearch" class="easyui-linkbutton" iconCls="icon-search">查询</a></td>  
						</tr>
					</table>
				</form>
			</div>
			<div class="toolbar">
					<a id="btnAdd" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">手动增加</a>
					<a id="btnDel" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-remove',plain:true">批量删除</a>
			</div>
		</div>
	</div>
	
	<div id="importPanel" class="easyui-panel"
		data-options="iconCls:'icon-save', closed:true, cache:false"></div>
    </div>
	<script type="text/javascript" src="common/js/amazonSettle/categoryRate.js"></script> 
