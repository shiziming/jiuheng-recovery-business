package com.jiuheng.web.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: garmbrood
 * Time: 2009-4-7 16:32:56
 * Company: 天极传媒集团
 * Descripion:日期工具类
 */
public class DateUtil {

    public static final String FORMAT_DEFAULT = "yyyy-MM-dd HH:mm:ss";
    
    public static final String FORMAT_YYYYMMDD="yyyyMMdd";

    public static final String FORMAT_DATE = "yyyy-MM-dd";

    public static final String FORMAT_DATE_WEEK = "yyyy-MM-dd(E)";

    public static final String FORMAT_DATE_WEEK_H_M = "yyyy-MM-dd(E) HH:mm";

    public static final String FORMAT_MONTH = "yyyy-MM";

    public static final String FORMAT_TIME = "HH:mm:ss";

    public static final String FORMAT_SHORT_DATE_TIME = "MM-dd HH:mm";

    public static final String FORMAT_DATE_TIME = FORMAT_DEFAULT;

    public static final String FORMAT_NO_SECOND = "yyyy-MM-dd HH:mm";

    public static final String FORMAT_JAPAN = "MM.dd(EEE) HH";

    public static final String FORMAT_CHINESE_NO_SECOND = "yyyy年MM月dd日 HH:mm";

    public static final String FORMAT_CHINESE_NO_SECOND_1 = "yyyy年MM月dd日HH:mm";

    public static final String FORMAT_CHINESE = "yyyy年MM月dd日 HH点mm分";

    public static final int TYPE_HTML_SPACE = 2;

    public static final int TYPE_DECREASE_SYMBOL = 3;

    public static final int TYPE_SPACE = 4;

    public static final int TYPE_NULL = 5;

    public static Map<String, SimpleDateFormat> getFormaters() {
        return formaters;
    }

    private static Map<String, SimpleDateFormat> formaters = new HashMap<String, SimpleDateFormat>();

    static {
        SimpleDateFormat defaultFormater = new SimpleDateFormat(FORMAT_DEFAULT,Locale.CHINA);
        formaters.put(FORMAT_DEFAULT, defaultFormater);
        formaters.put(FORMAT_DATE, new SimpleDateFormat(FORMAT_DATE,Locale.CHINA));
        formaters.put(FORMAT_DATE_WEEK, new SimpleDateFormat(FORMAT_DATE_WEEK,Locale.CHINA));
        formaters.put(FORMAT_DATE_WEEK_H_M, new SimpleDateFormat(FORMAT_DATE_WEEK_H_M,Locale.CHINA));
        formaters.put(FORMAT_MONTH, new SimpleDateFormat(FORMAT_MONTH,Locale.CHINA));
        formaters.put(FORMAT_TIME, new SimpleDateFormat(FORMAT_TIME,Locale.CHINA));
        formaters.put(FORMAT_SHORT_DATE_TIME, new SimpleDateFormat(FORMAT_SHORT_DATE_TIME,Locale.CHINA));
        formaters.put(FORMAT_CHINESE_NO_SECOND, new SimpleDateFormat(FORMAT_CHINESE_NO_SECOND,Locale.CHINA));
        formaters.put(FORMAT_CHINESE, new SimpleDateFormat(FORMAT_CHINESE,Locale.CHINA));
        formaters.put(FORMAT_DATE_TIME, defaultFormater);
        formaters.put(FORMAT_NO_SECOND, new SimpleDateFormat(FORMAT_NO_SECOND,Locale.CHINA));
        formaters.put(FORMAT_JAPAN, new SimpleDateFormat(FORMAT_JAPAN, Locale.JAPAN));
        formaters.put(FORMAT_CHINESE_NO_SECOND_1, new SimpleDateFormat(FORMAT_CHINESE_NO_SECOND_1,Locale.CHINA));
    }

    /**
     * 使用给定的 pattern 对日期进格式化为字符串
     *
     * @param date    待格式化的日期
     * @param pattern 格式字符串
     * @return 格式化后的日期字符串
     */
    public static String format(Date date, String pattern) {
        SimpleDateFormat dateFormat;
        if (formaters.containsKey(pattern)) {
            dateFormat = formaters.get(pattern);
        } else {
            dateFormat = new SimpleDateFormat(pattern);
        }
        return dateFormat.format(date);
    }

    /**
     * 以默认日期格式(yyyy-MM-dd HH:mm:ss)对日期进行格式化
     *
     * @param date 待格式化的日期
     * @return 格式化后的日期字符串
     */
    public static String format(Date date) {
        return formaters.get(FORMAT_DEFAULT).format(date);
    }

    /**
     * 格式化日期，
     * --------------------------------------------------------------------------<br>
     * 创建者：杨思勇<br>
     * 创建日期：2002-1-16<br>
     * <br>
     * 修改者：<br>
     * 修改日期：<br>
     * 修改原因：<br>
     * --------------------------------------------------------------------------
     *
     * @param date   要格式化的日期对象
     * @param format 格式
     * @param type   如果日期为空，定义返回的类型
     * @return 返回值，如果date为空，则type定义返回类型，如果格式化失败。则返回空串
     */
    public static String format(Date date,
                                String format,
                                int type) {
        if (date != null) {
            //---------------------------------
            // 日期不为空时才格式
            //---------------------------------
            try {
                //---------------------------------
                // 调用SimpleDateFormat来格式化
                //---------------------------------
                return new SimpleDateFormat(format).format(date);
            } catch (Exception e) {
                //---------------------------------
                // 格式化失败后，返回一个空串
                //---------------------------------
                return "";
            }
        } else {
            //---------------------------------
            // 如果传入日期为空，则根据类型返回结果
            //---------------------------------
            switch (type) {
                case TYPE_HTML_SPACE: // '\002'
                    return "&nbsp;";

                case TYPE_DECREASE_SYMBOL: // '\003'
                    return "-";

                case TYPE_SPACE: // '\004'
                    return " ";

                case TYPE_NULL:
                    return null;

                default:
                    //---------------------------------
                    // 默认为空串
                    //---------------------------------
                    return "";
            }
        }
    }

    /**
     * 将给定字符串解析为对应格式的日期,循环尝试使用预定义的日期格式进行解析
     *
     * @param str 待解析的日期字符串
     * @return 解析成功的日期，解析失败返回null
     */
    public static Date parse(String str) {
        Date date = null;
        for (String _pattern : formaters.keySet()) {
            if (_pattern.getBytes().length == str.getBytes().length) {
                try {
                    date = formaters.get(_pattern).parse(str);
                    //格式化成功则退出
                    break;
                } catch (ParseException e) {
                    //格式化失败，继续尝试下一个
                    //e.printStackTrace();
                }
            }else if(_pattern.equals(FORMAT_JAPAN)){
                try {
                    date = formaters.get(_pattern).parse(str);
                    //格式化成功则退出
                    break;
                } catch (ParseException e) {}
            }
        }
        return date;
    }

    public static Date parse(String str,String pattern){
        SimpleDateFormat dateFormat;
        if (formaters.containsKey(pattern)) {
            dateFormat = formaters.get(pattern);
        } else {
            dateFormat = new SimpleDateFormat(pattern);
        }
        Date date = null;
        try {
            date = dateFormat.parse(str);
        } catch (ParseException e) {
            //是格式失败
            e.printStackTrace();
        }
        return date;
    }

    /**
     * date2 是否在date1之后
     * @param date1 参照日期
     * @param date2 比较日期
     * @return true:是 false:否
     */
    public static boolean isAfter(Date date1, Date date2){
        Calendar calendar2 = Calendar.getInstance();
        Calendar calendar1 = Calendar.getInstance();
        calendar2.setTime(date2);
        calendar1.setTime(date1);
        return calendar2.after(calendar1);
    }

   
    /**
     * 获取系统时间的前一个月 
     * @return
     */
   public static String getBeforeMonth()
    {
    	Calendar calendar = Calendar.getInstance(); 
    	calendar.add(Calendar.MONTH, -1); 
    	String date=format(calendar.getTime(),FORMAT_MONTH);
    	return date;
    	
    }
   
    /**
     * 得到传入时间的前daynum天时间
     * @author chenyi
     * @date 2015年6月3日 上午9:36:13 
     * @param date
     * @return
     */
    public static Date getfrontDate(Date date,int daynum){
    	Calendar calendar = Calendar.getInstance(); //得到日历
		calendar.setTime(date);//把当前时间赋给日历
		calendar.add(Calendar.DAY_OF_MONTH, daynum);  //设置为前daynum天
    	return calendar.getTime();//得到系统前一天
    }
    
    
    /**
     * 计算两个日期之间相差的天数   
     * @author chenyi
     * @date 2015年6月3日 上午11:19:06 
     * @param smdate 小时间
     * @param bdate 大时间
     * @return
     * @throws ParseException
     */
    public static int daysBetween(Date smdate,Date bdate) throws ParseException    
    {    
    	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
        smdate=sdf.parse(sdf.format(smdate));  
        bdate=sdf.parse(sdf.format(bdate));  
        Calendar cal = Calendar.getInstance();    
        cal.setTime(smdate);    
        long time1 = cal.getTimeInMillis();                 
        cal.setTime(bdate);    
        long time2 = cal.getTimeInMillis();         
        long between_days=(time2-time1)/(1000*3600*24);  
        return Integer.parseInt(String.valueOf(between_days));           
    }
    
    /**
     * 计算两个日期之间相差的小时数   
     * @author chenyi
     * @date 2015年6月3日 上午11:19:06 
     * @param smdate 小时间
     * @param bdate 大时间
     * @return
     * @throws ParseException
     */
    public static int hoursBetween(Date smdate,Date bdate) throws ParseException    
    {    
    	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
        smdate=sdf.parse(sdf.format(smdate));  
        bdate=sdf.parse(sdf.format(bdate));  
        Calendar cal = Calendar.getInstance();    
        cal.setTime(smdate);    
        long time1 = cal.getTimeInMillis();                 
        cal.setTime(bdate);    
        long time2 = cal.getTimeInMillis();         
        long between_hours=(time2-time1)/(1000*3600);  
        return Integer.parseInt(String.valueOf(between_hours));           
    }
    
    /**
     * 计算传入时间与当前时间的间隔时间
     * @author chenyi
     * @date 2015年10月29日 下午4:09:57 
     * @param smdate
     * @return
     * @throws ParseException
     */
    public static String minuteBetween(Date smdate) throws ParseException    
    {    
    	String str = "";
    	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
        smdate=sdf.parse(sdf.format(smdate));  
        Date bdate=sdf.parse(sdf.format(new Date()));  
        Calendar cal = Calendar.getInstance();    
        cal.setTime(smdate);    
        long time1 = cal.getTimeInMillis();                 
        cal.setTime(bdate);    
        long time2 = cal.getTimeInMillis();         
        long between_minute=(time2-time1)/(1000*60);  
        if(between_minute>0){
        	if(between_minute<60){
            	str= between_minute+"分钟前";
            }else if (between_minute>60 && between_minute<60*24){
            	int hour = (int)between_minute/60;
            	int minute = (int)between_minute-hour*60;
            	str= hour+"小时"+minute+"分钟前";
            }else{
            	int day = (int)between_minute/(60*24);
            	int hours = (int)between_minute-day*24*60;
            	int hour = (int)hours/60;
            	int minute = (int)hours-hour*60;
            	str= day+"天"+hour+"小时"+minute+"分钟前";
            }
        }
        return str;
    }
    
    
    /**
     * 计算传入时间的间隔时间
     * @author chenyi
     * @date 2015年11月20日 上午10:54:50 
     * @param smdate
     * @param eDate
     * @return
     * @throws ParseException
     */
    public static Long minuteBetween(Date smdate,Date eDate)    
    {    
    	try {
    		long time1 = smdate.getTime();                 
	        long time2 = eDate.getTime();     
	        long between_minute=(time2-time1)/(1000*60);  
	        if(between_minute==0){
	        	between_minute=1;
	        }
	        return between_minute;
		} catch (Exception e) {
			e.printStackTrace();
			 return 0L;
		}
    }
    
    
    public static void main(String[] args) throws ParseException {
//    	System.err.println("============"+minuteBetween(DateUtils.parse("2015-11-24 15:25:00"),new Date()));
    	//System.err.println(minuteBetween(parse("2015-11-20 10:20:00"),new Date()));
    }
    
    public static String getNowTime(){
        return DateUtil.format(new Date());
    }
    
    /**
     * 获取系统时间的后一个月 
     * @return
     */
   public static Date getBehindCalendar()
    {
    	Calendar calendar = Calendar.getInstance(); 
    	calendar.add(Calendar.MONTH, 1); 
    	String date=format(calendar.getTime(),FORMAT_MONTH);
    	date+="-"+format(new Date(),"dd HH:mm:ss");
    	Date time= parse(date); 
    	return time;
    	
    }
   
   	public static String dayForWeek(Date pTime) {
   		String week="";
   		Calendar c = Calendar.getInstance();
		c.setTime(pTime);
   		int dayForWeek = 0;
   		if(c.get(Calendar.DAY_OF_WEEK) == 1){
   			dayForWeek = 7;
   		}else{
   			dayForWeek = c.get(Calendar.DAY_OF_WEEK) - 1;
   		}
   		if(dayForWeek==1){
   			week="周一";
   		}else if(dayForWeek==2){
   			week="周二";
   		}else if(dayForWeek==3){
   			week="周三";
   		}else if(dayForWeek==4){
   			week="周四";
   		}else if(dayForWeek==5){
   			week="周五";
   		}else if(dayForWeek==6){
   			week="周六";
   		}else if(dayForWeek==7){
   			week="周日";
   		}
   		return week;
   	}

    /**
     * 处理时间
     * @param time 时间基数，如果为null，则默认当前时间
     * @param field 同{@link Calendar}的field
     * @param amount 大于0则加，小于0则减
     * @return
     */
    public static Date add(Date time, int field, int amount) {
	    if(amount == 0) return time;

	    Calendar cal = Calendar.getInstance();
	    if(time != null) {
		    cal.setTime(time);
	    }
	    cal.add(field, amount);
        return cal.getTime();
    }
    

    /**
     * 增加或减少多少年（或月，日）后日期
     */
    public static Date addOrMinusDate(Date nowdate, int delay, int yearOrmonthOrDay) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(nowdate);
        calendar.add(yearOrmonthOrDay, delay);
        Date date = calendar.getTime();
        return date;
    }

    /**
     * 增加或减少多少年后的日期
     */
    public static Date addOrMinusYear(Date nowdate, int delay) {
        return addOrMinusDate(nowdate, delay, Calendar.YEAR);
    }

    /**
     * 增加或减少多少月后的日期
     */
    public static Date addOrMinusMonth(Date nowdate, int delay) {
        return addOrMinusDate(nowdate, delay, Calendar.MONTH);
    }

    /**
     * 增加或减少多少日后的日期
     */
    public static Date addOrMinusDay(Date nowdate, int delay) {
        return addOrMinusDate(nowdate, delay, Calendar.DAY_OF_YEAR);
    }

    /**
     * 增加或减少多少小时后的日期
     */
    public static Date addOrMinusHour(Date nowdate, int delay) {
        return addOrMinusDate(nowdate, delay, Calendar.HOUR);
    }
}
