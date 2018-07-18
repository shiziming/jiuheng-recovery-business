package com.jiuheng.web.controller;

import com.jiuheng.order.domain.RecoveryOrderReq;
import com.jiuheng.order.respResult.Response;
import com.jiuheng.order.respResult.SearchResult;
import com.jiuheng.order.dubbo.DubboOrderService;
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
