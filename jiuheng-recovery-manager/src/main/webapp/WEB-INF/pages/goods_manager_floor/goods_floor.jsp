<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
	.tr-common{
		height:24px ;
	}
	.td-level{
		width:15%;
	}

</style>
<div id="goods_up_page11">
	<input type='hidden' id="djbh" value="${djbh}"/>
	<input type='hidden' id="spptfldm" value="${spptfldm}"/>
	<input type='hidden' id="saveupdateFlag" value="${saveupdateFlag}"/>
					
	<table id="indexGoodsAdd" style="width:100%;padding: 7px 120px;">
		<tr class="tr-common">
			<td width="10%"><span style="font-weight:bold;">单据信息</span></td>						
		</tr>
		<tr class="tr-common">
			<td class="td-level"><font color="FF0000">*</font>类型</td>
			<c:if test="${empty djbh}">
					<td class="td-level">
						<input style="width: 30%"
							placeholder="首页" class="easyui-textbox" type="text" 
							name="lcwzlx" disabled="true" id="lcwzlx"  value="首页" 
							data-options="required:true" />
					</td>
			</c:if>
			
			<c:if test="${not empty djbh}">
					<td class="td-level">
						<input style="width: 30%"
							placeholder="首页" class="easyui-textbox" type="text" 
							name="lcwzlx" disabled="true" id="lcwzlx" disabled="true" 
							value="首页"  data-options="required:true" value="首页" />
					</td>
			</c:if>

					
			<td class="td-level"><font color="FF0000">*</font>销售组织代码：</td>
			<td class="td-level">
					<input style="width: 40%"
							 class="easyui-textbox" name="xszzdm" type="text"  
							 id="xszzdm" data-options="required:true" 
							 <c:if test="${not empty djbh}">disabled="true"  </c:if>	 
							 value="${m.xszzdm}" />
							
			</td>
			
		</tr>
		
		<tr class="tr-common">
			<td width="10%"><font color="FF0000">*</font>是否覆盖分部楼层</td>
			<td width="10%">
			<span class="radioSpan">
			<c:if test="${empty m}">
			<input type="radio" id="Zbfgfblx1" name="Zbfgfblx"  value="0"  >否</input>
			<input type="radio" id="Zbfgfblx2" name="Zbfgfblx"  value="1" >是</input>
			</c:if>
			
			<c:if test="${m.zbfgfblx==0}">
				<input type="radio" id="Zbfgfblx" name="Zbfgfblx" disabled value="0" checked="checked" >否</input>
				<input type="radio" id="Zbfgfblx2" name="Zbfgfblx" disabled value="1" >是</input>
			</c:if>
               <c:if test="${m.zbfgfblx==1}">
               <input type="radio" id="Zbfgfblx" name="Zbfgfblx" disabled  value="0"  >否</input>
				 <input type="radio" id="Zbfgfblx2" name="Zbfgfblx" disabled value="1" checked="checked">是</input>
			</c:if> 
			
			<c:if test="${m.zbfgfblx==2}">
               <input type="radio" id="Zbfgfblx" name="Zbfgfblx" disabled  value="0"  >否</input>
				 <input type="radio" id="Zbfgfblx2" name="Zbfgfblx" disabled value="1" checked="checked">是</input>
			</c:if> 
               
            </span>
			
			</td>
			<td width="6%"></td>
			<td width="8%">
					
			</td>
			
		</tr>
		
		<div>
		<tr id="goods_xxzjList" class="tr-common" style="display: none">
			<td width="10%" style="text-align:center;">例外：</td>
			<td width="10%">
			<input style="width: 99%"
				 placeholder="严格参照（1001-1002-1003）格式" name="xxzjList" <c:if test="${not empty djbh}">disabled="true"  </c:if> type="text"  id="xxzjList" value="${m.xxzjList}" />
			</td>
			<td width="6%"></td>
			<td width="8%">
					
			</td>
			
		</tr>
		</div>
		
		<tr class="tr-common">
			<td width="10%"><span style="font-weight:bold;">楼层信息</span></td>
			
			
		</tr>
		
		<tr class="tr-common">
			<td width="10%"><font color="FF0000">*</font>楼层分类</td>
			<td width="30%"><input type="text" name="spptfldm"  id="spptfldm"   style="display:none" value="${m.spptfldm}"/>
							 
							<!--  <input id="spptflmc"  name="spptflmc"  data-options="searcher:search" class="easyui-searchbox" style="width:300px" ></input>	
							-->
							<input 
							  type="text" name="spptflmc"  id="spptflmc"  disabled="true"  class="easyui-textbox" value="${m.spptflmc}" />
							<a href="#" class="easyui-linkbutton" <c:if test="${saveupdateFlag=='1'}">disabled="true"  </c:if>
					data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-search'"
				onclick="splc_goods_up.getlcfl();"></a>
							
							</td>
							
			<td width="6%"><font color="FF0000">*</font>排序：</td>
			<td width="8%">
				<input style="width: 40%"
				class="easyui-textbox" name="spptfldmOrderId" type="text" value="${m.spptfldmOrderId}" id="spptfldmOrderId"  data-options="required:true" />
			</td>
			
		</tr>
		
		
		
	</table>
	<table id="dg"></table>
	<form id="searchForm">
		<table class="table table-hover table-condensed"
			style="width: 100%; padding: 7px 80px 0px 80px">
			<tr>
				<td width="10%"></td>
				<td width="10%"></td>
				<td width="10%" align="center">
				<a href="#" class="easyui-linkbutton"	data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-ok'"
					 onclick="splc_goods_up.save();">保存</a>
				<a href="#" class="easyui-linkbutton"	data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-back'"
					onclick="splc_goods_up.back();">返回</a></td>
				<td width="10%"></td>
				<td width="10%"></td>
				<td width="10%"></td>
			</tr>
		</table>
	</form>
	<div id="tb" style="display: none;">
		<a href="javascript:void(0);"	class="easyui-linkbutton"
			data-options="iconCls:'icon-add',plain:true" onclick="splc_goods_up.addRow();">增加</a>
		<a href="javascript:void(0);" class="easyui-linkbutton"
			data-options="iconCls:'icon-remove',plain:true" onclick="splc_goods_up.delRow();">删除</a>
	</div>
	<div class="easyui-window" data-options="closed:true,cache:false" id="magnifier"></div>
</div>
<script type="text/javascript"	src="common/js/goods_manager_floor/goods_floor.js"></script>
<script type="text/css"	src="radio.css"></script>
<script type="text/javascript"> 
    function search(){ 
        alert("11111") ;
    } 
    
    function displayList(cs){ 
        alert("222222") ;
        if (cs == 0) {
        	  document.getElementById("xxzjList").style.visibility="hidden";
        }
        if (cs==1) {
        	
        document.getElementById("xxzjList").style.visibility="visible";
        }
    } 
</script>
