package com.jiuheng.web.utils;

import java.math.BigDecimal;

public class StringUtil {
	
	
	public static String fillZero(int c, int digit) {
//		if (digit)
//			throw new IllegalArgumentException("SKU码位数太多!");
		
//		System.out.println(Math.pow(10, digit));
//		System.out.println(Math.pow(10, digit) + c);
//		return String.valueOf((long) (Math.pow(10, digit) + c)).substring(1);
		
		return String.format("%0"+digit+"d", c);
	}
	
	/**
	 * 将sku代码转换为前面补0，共18位的商品内码
	 * @param c sku代码
	 * @return 商品内码
	 */
	public static String toSku(int c){
		return fillZero(c, 18);
	}
	
	/**
	 * 将*100金额转换为正常金额
	 */
	public static Float divideAmount(Integer amount){
		return Float.valueOf(amount)/100;
	}
	
	/**
	 * 将*100金额转换为正常金额
	 */
	public static String divideAmountString(Integer amount){
		return String.valueOf(Float.valueOf(amount)/100);
	}
	
	
	/**
	 * 将*100金额转换为正常金额
	 */
	public static BigDecimal divideAmountDecimal(Integer amount){
		Float a=Float.valueOf(amount)/100;
		BigDecimal   b   =   new   BigDecimal(a.toString());
		//保留2位小数
		return b.setScale(2,   BigDecimal.ROUND_HALF_UP);
	}
	
	/**
	 * 将*100金额转换为正常金额
	 */
	public static String divideAmountDecimal(Long amount){
		BigDecimal   b   =   new   BigDecimal(new Double(amount)/100);
		//保留2位小数
		return b.setScale(2,   BigDecimal.ROUND_HALF_UP).toString();
	}
	
	public static String ifNullString(String s){
		if(s == null){
			return "";
		}else{
			return s;
		}
	}
	public static void main(String[] args) {
		System.out.println(toSku(100189698));
		System.out.println(divideAmount(23));
		System.out.println(String.format("%018d", 100037980));
	}
}
