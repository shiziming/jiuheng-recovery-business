package com.jiuheng.web.common;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Properties;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * User:Weicj company:TMG DateTime:2014年4月21日 下午2:16:20 Description: 系统常量配置
 */
public class Constant {
	static Properties prop = new Properties();
	protected static Log log = LogFactory.getLog(Constant.class);
	/**
	 * 上传文件的根路径
	 */
	public static String UPLOAD_FILE_ROOT_PATH;

	public static final String FILE_UPLOAD_TYPE = ".png,.jpg,.jpeg,.gif";

	/**
	 * 上传文件的相对路径
	 */
	public static String UPLOAD_FILE_PRE_PATH;
	/**
	 * 前台文件上传相对路径
	 */
	public static String UPLOAD_FILE_TMP_PATH;
	/**
	 * 上传文件访问路径
	 */
	public static String UPLOAD_FILE_URL_PRE;

	public static final String SESSION_ENGINEER = "__sessionEngineer__";
	/**
	 * 工程师登陆
	 */
	public static final String ENGINEER_SESSION_KEY = "__sessionEngineer__";

	/**
	 * 渠道商登陆
	 */
	public static final String CHANNEL_SESSION_KEY = "__sessionchannel__";

	/**
	 * 后台用户信息
	 */
	public static final String USER_SESSION_KEY = "__sessionUser__";

	/**
	 * 用户wap/app端登录
	 */
	public static final String USER_APP_LOGIN_KEY = "__appLoginInfo__";

	/**
	 * 外部接口访问 token
	 */
	public static final String APP_USER_LOGIN_TOKEN = "__appLoginToken__";
	/**
	 * 国美登陆用户信息
	 */
	public static final String GOME_USER_SESSION_KEY = "__gomeSessionUser__";
	/**
	 * 国美登陆用户id
	 */
	public static final String GOME_USER_ID_KEY = "gomeUserId";
	/**
	 * 国美登陆用户id
	 */
	public static final String GOME_ZX_USER_ID_KEY = "gomeZxUserId";

	/**
	 * 国美登陆用户rand
	 */
	public static final String GOME_USER_RAND_KEY = "gomeUserRand";

	/**
	 * 订单使用的微信地址
	 */
	public static String WEIXIN_QCODE_URL;

	/**
	 * 苹果序列号 地址
	 */
	public static String APP_INFO_URL = "http://apis.haoservice.com/lifeservice/AppleInfo";

	/**
	 * WAP订单详情页路径
	 */
	public static String WAP_ORDER_INFO_URL;

	/**
	 * 我得订单
	 */
	public static String MY_ORDER;

	/**
	 * 获取access_token
	 */
	public static String ACCESS_TOKEN;
	
	/**
	 * 保险单图片路径
	 */
	public static String UPLOAD_FILE_POLICY;

	// 读取基础配置 具体项目配置项将覆盖bese工程配置项
	static {

        InputStream in = null;
        try {
            // 读取配置项 保存到基础配置
            URL resource = Constant.class.getClassLoader().getResource("config.properties");
            String fullName = resource.getFile();
            File folder = new File(fullName).getParentFile();
            for (File file : folder.listFiles(new FilenameFilter() {
                @Override
                public boolean accept(File dir, String name) {
                    return  !"jdbc.properties".equals(name) && name.matches("^([\\w\\-_]+)\\.properties$");
                }
            })) {
                in = Constant.class.getClassLoader().getResourceAsStream(file.getName());
                prop.load(in);
                in.close();
            }

			init(prop);

		} catch (Exception e) {
			log.error("初始化数据失败" + e.getMessage(), e);
		}finally {
            if(in !=null) {
                try {
                    in.close();
                } catch (IOException e) {
                }
            }
        }
    }

	private static void init(Properties prop) {

		String weixinQcodeUrl = prop.getProperty("weixinQcodeUrl");
		if (weixinQcodeUrl != null) {
			WEIXIN_QCODE_URL = weixinQcodeUrl;
		}

		String uploadFileRootPath = prop.getProperty("uploadFileRootPath");
		if (uploadFileRootPath != null) {
			UPLOAD_FILE_ROOT_PATH = uploadFileRootPath;
		}

		String uploadFilePrePath = prop.getProperty("uploadFilePrePath");
		if (uploadFilePrePath != null) {
			UPLOAD_FILE_PRE_PATH = uploadFilePrePath;
		}

		String uploadFileTmpPath = prop.getProperty("uploadFileTmpPath");
		if (uploadFileTmpPath != null) {
			UPLOAD_FILE_TMP_PATH = uploadFileTmpPath;
		}

		String uploadFileUrlPath = prop.getProperty("uploadFileUrlPath");
		if (uploadFileUrlPath != null) {
			UPLOAD_FILE_URL_PRE = uploadFileUrlPath;
		}

		String wapOrderInfoUrl = prop.getProperty("wap_order_info_url");
		if (wapOrderInfoUrl != null) {
			WAP_ORDER_INFO_URL = wapOrderInfoUrl;
		}

		String myOrder = prop.getProperty("myOrder");
		if (myOrder != null && myOrder.length() != 0) {
			MY_ORDER = myOrder;
		}

		String accessToken = prop.getProperty("accessToken");
		if (accessToken != null && accessToken.length() != 0) {
			ACCESS_TOKEN = accessToken;
		}
		
		String uploadFilePolicy = prop.getProperty("uploadFilePolicy");
		if (uploadFilePolicy != null && uploadFilePolicy.length() != 0) {
			UPLOAD_FILE_POLICY = uploadFilePolicy;
		}
		
	}

	public static String getConfig(String key) {
		return prop.getProperty(key);
	}

	public static String getConfig(String key, String defaultValue) {
		return prop.getProperty(key, defaultValue);
	}

}
