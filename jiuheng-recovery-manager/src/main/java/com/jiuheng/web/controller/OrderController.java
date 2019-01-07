package com.jiuheng.web.controller;

import com.jiuheng.service.domain.RecoveryOrderReq;
import com.jiuheng.service.domain.RecoveryOrderResp;
import com.jiuheng.service.dto.Order;
import com.jiuheng.service.dto.PropsView;
import com.jiuheng.service.dto.RecoveryProp;
import com.jiuheng.service.dto.Region;
import com.jiuheng.service.dto.RegionList;
import com.jiuheng.service.dto.TemplateOrder;
import com.jiuheng.service.dubbo.DubboRegionService;
import com.jiuheng.service.dubbo.DubboTmpOrderService;
import com.jiuheng.service.respResult.CommonResult;
import com.jiuheng.service.respResult.Response;
import com.jiuheng.service.respResult.SearchResult;
import com.jiuheng.service.dubbo.DubboOrderService;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by shiziming on 2018/6/28.
 */
@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private DubboOrderService dubboOrderService;
    @Autowired
    private DubboTmpOrderService dubboTmpOrderService;
    @Autowired
    private DubboRegionService dubboRegionService;
    @RequestMapping("/index")
    public ModelAndView index(){
            ModelAndView m = new ModelAndView("order/index");
            return m;
    }
    @RequestMapping("/list")
    @ResponseBody
    public SearchResult list(RecoveryOrderReq req,HttpServletRequest request){
        Response<SearchResult> result = dubboOrderService.getOrderList(req, Integer.parseInt(request.getParameter("page")), Integer.parseInt(request.getParameter("rows")));
        return result.getResult();
    }
    @RequestMapping("/viewOrderInfo")
    public ModelAndView viewOrderInfo(String orderId){
        ModelAndView m = new ModelAndView("order/view");
        Response<RecoveryOrderResp> result = dubboOrderService.getOrderDetail(orderId);
        List<RecoveryProp> props = dubboTmpOrderService.getTemplateOrderByOrderId(orderId);
        m.addObject("order",result.getResult());
        List<PropsView> viewList = new ArrayList<PropsView>();
        if(null != props && props.size()>0){
            int time = props.size()%3 == 0 ? props.size()/3:props.size()/3+1;
            for (int i =0;i<time;i++){
                PropsView view = new PropsView();
                int k=i*3;
                int l=0;
                for (int j = k;j < props.size();j++) {
                    if(l==3){
                        break;
                    }
                    if(l==0){
                        view.setProp1(props.get(j));
                    }
                    if(l==1){
                        view.setProp2(props.get(j));
                    }
                    if(l==2){
                        view.setProp3(props.get(j));
                    }
                    l++;
                }
                viewList.add(view);
            }
            m.addObject("props",viewList);
        }
        return m;
    }

    @RequestMapping("/update")
    public ModelAndView update(String orderId){
        ModelAndView m = new ModelAndView("order/update");
        Response<RecoveryOrderResp> result = dubboOrderService.getOrderDetail(orderId);
        //省
        CommonResult<RegionList> pRegionList = dubboRegionService.getProvinces();
        //市
        CommonResult<RegionList> cRegionList = dubboRegionService.getCitys(String.valueOf(result.getResult().getProvince()));
        //区
        CommonResult<RegionList> dRegionList = dubboRegionService.getCountys(String.valueOf(result.getResult().getCity()));
        m.addObject("order",result.getResult());
        m.addObject("provinces",pRegionList.getData().getProvinces());
        m.addObject("citys",cRegionList.getData().getCitys());
        m.addObject("countys",dRegionList.getData().getCountys());
        return m;
    }

    @RequestMapping("/updateOrder")
    @ResponseBody
    public Response<Boolean> updateOrder(RecoveryOrderReq orderReq){
        Response<Boolean> result = null;
        orderReq.setDealPrice(orderReq.getDealPrice()*100);
        orderReq.setFreightPrice(orderReq.getFreightPrice()*100);
        result = dubboOrderService.updateOrder(orderReq);
        return result;
    }
    /*private final String[] headers={"分单号","类型","状态","订单号","特殊订单类型","预售商品标记","店主ID","店主名称","国美员工ID","员工信息","销售组织代码","销售组织名称","门店代码","门店名称","销售公司代码","销售公司名称","成交金额","运费",
        "原分单号","物流确定配送日期","收货人","电话","收货地址","SKUID","商品价格","发放佣金标记","商品佣金","佣金审核否","支付方式","订单提交时间","订单支付时间","收款凭证状态"};
    private final String[] fields={"xsfdh","xsfdlx1","status1","xsddh","tsddlx1","ysztbj1","wddzid","wddzmc","gmygid","gmygmcgw","xszzdm","xszzmc","mddm","mdmc","xsgsdm","xsgsmc","ddcjje1","fee",
        "yxsfdh","wlpsrq","shrmc","shrdh1","shdzxx","skuid","spjg1","ygyjbj1","spyj1","yjfhdStatus1","zffsid1","tjsj","zfsj","pzscbjStatus"};

    @RequestMapping(value ="/export")
    public ModelAndView export(RecoveryOrderReq req, HttpServletRequest request, HttpServletResponse response, String version) throws IOException {
        *//*try {*//*
            *//*SysUser user =  (SysUser) request.getSession().getAttribute("user");
            if("GMZB".equals(user.getOrgId()) ){
                req.setSaleOrgs(null);
            }else {
                if(user.getOrgType()==5){
                    req.setSjkcddm(user.getOrgId());
                }else{
                    Response<List<String>> re = getSaleOrgReadService.getSaleOrgWithTypeAndCode(user.getOrgType()==null?"":user.getOrgType().toString(), user.getOrgId());
                    if(re.isOk() && re.getResult()!=null && re.getResult().size()>0){
                        req.setSaleOrgs(re.getResult());
                    }
                }
            }*//*
            *//*Response<List<GetOnlineOrderInfoResp>> result = orderReadService.listOrderInfo(req);
            Workbook workbook =null;
            String fileName = null;
            JsonConfig jsonConfig = new JsonConfig();
            PropertyFilter filter = new PropertyFilter() {
                public boolean apply(Object object, String fieldName, Object fieldValue) {
                    return (null == fieldValue || "".equals(fieldValue));
                }
            };
            jsonConfig.setJsonPropertyFilter(filter);
            //转换订单类型状态
            for (GetOnlineOrderInfoResp resp : result.getResult()) {
                resp.setXsfdlx1(orderTypes.get(resp.getXsfdlx()));
                resp.setStatus1(getOrderStatus(resp.getXsfdlx(),resp.getStatus(),resp.getCjazbj()));
                resp.setDdcjje1(StringUtil.divideAmountDecimal(Long.valueOf(resp.getDdcjje())));
                resp.setFee(StringUtil.divideAmountDecimal(Long.valueOf(resp.getPslqf()+resp.getPsycf())));
                resp.setZffsid1(payMethods.get(resp.getZffsid()));
                resp.setSpjg1(StringUtil.divideAmountDecimal(Long.valueOf(resp.getSpjg())));
                resp.setShdzxx(resp.getShdz1()+resp.getShdz2()+resp.getShdz3()+resp.getShdz4()+resp.getShdz6()==null?"":resp.getShdz6());
                resp.setYgyjbj1(resp.getYgyjbj().intValue()==1?"是":"否");
                resp.setSpyj1(StringUtil.divideAmountDecimal(Long.valueOf(resp.getSpyj())));
                if(resp.getYjfhdStatus()==null){
                    resp.setYjfhdStatus1("未建单");
                }else{
                    resp.setYjfhdStatus1(resp.getYjfhdStatus().intValue()==1?"是":"否");
                }
                resp.setPzscbjStatus(switchFI187Status(resp,resp.getPzscbj(), resp.getSappzh(), resp.getSapfkxx()));
                resp.setTsddlx1(switchSpecialOrderType(resp.getTsddlx()));
                resp.setYsztbj1(resp.getYsztbj()==0?"非预售":"预售");
            }
            if("excel2003".equals(version)){
                workbook = ExportUtils.exportExcel2003("sheet1", headers, fields, BeanMapUtils.convertListBean(result.getResult()));
                fileName = URLEncoder.encode("订单导出"+JSONObject.fromObject(req,jsonConfig).toString(), "utf-8")+".xls";
            }else{
                workbook = ExportUtils.exportExcel2007("sheet1", headers, fields, BeanMapUtils.convertListBean(result.getResult()));
                fileName = URLEncoder.encode("订单导出"+JSONObject.fromObject(req,jsonConfig).toString(), "utf-8")+".xlsx";
            }
            this.setHeader(request, response, fileName);
            workbook.write(response.getOutputStream());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(response.getOutputStream()!=null){
                    response.getOutputStream().flush();
                    response.getOutputStream().close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }*//*
        return null;
    }*/

}
