package com.jiuheng.web.controller;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.jiuheng.web.common.Constant;
import com.jiuheng.web.utils.DateUtil;
import com.jiuheng.web.utils.StringUtils;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.DefaultHttpRequestRetryHandler;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

/**
 * User:Weicj
 * company:TMG
 * DateTime:2014年4月18日 下午3:44:52
 * Description:
 */
@Controller
public class FileUploadController {

    protected Log log = LogFactory.getLog(FileUploadController.class);

    @Value("${GFS_TOKEN}")
    private String token = null;
    @Value("${GFS_URL}")
    private String url = null;
    //定义允许上传的文件扩展名
    protected static HashMap<String, String> extMap = new HashMap<String, String>();
    static{
	    extMap.put("image", "gif,jpg,jpeg,png,bmp");
	    extMap.put("flash", "swf,flv");
	    extMap.put("media", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb");
	    extMap.put("file", "doc,docx,xls,xlsx,ppt,htm,html,txt,zip,rar,gz,bz2,js,css");
    }
    
//    @RequestMapping("showFileUploadView")
//    public ModelAndView showFileUploadView(Map<String, String> param) {
//        return new ModelAndView("common.fileUpload");
//    }

    @RequestMapping("fileUpload")
    public Map fileUpload(HttpServletRequest request, @RequestParam(value = "file", required = true) MultipartFile file,Map model) {
    	
    	String errorMsg = "";
    	String dirName = request.getParameter("dir");
    	if (dirName == null) {
    		dirName = "image";
    	}
    	
    	if(!extMap.containsKey(dirName)){
    		errorMsg = "暂不支持该文件类型";
            model.put("state", errorMsg);
            model.put("error", "1");
            model.put("message", errorMsg);
            return  model;
    	}
    	
    	//检查扩展名
    	String fileName = file.getOriginalFilename();
		String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
		if(!Arrays.<String>asList(extMap.get(dirName).split(",")).contains(fileExt)){
			errorMsg = "上传文件扩展名是不允许的扩展名。\n只允许" + extMap.get(dirName) + "格式。";
            model.put("state", errorMsg);
            model.put("error", "1");
            model.put("message", errorMsg);
            return model;
		}
    			
    	if("image".equals(dirName))
    		return imgFileUpload(request,file);
    	else if("media".equals(dirName))
    		return videoFileUpload(null,file);
    	else if("file".equals(dirName))
    		return attachmentFileUpload(request,file);
    	else{
    		errorMsg = "暂不支持该类型";
            model.put("state", errorMsg);
            model.put("error", "1");
            model.put("message", errorMsg);
            return model;
    	}
    	
    }
    
    /**
     * 功能：图片文件上传
     *
     * @param ：scale格式 width1,height1,width2,height2,width3,height3  如：  110,280,120,340,210x421
     * @return
     */
    @RequestMapping("imgFileUpload")
    @ResponseBody
    public Map imgFileUpload(HttpServletRequest request,@RequestParam(value = "file", required = true) MultipartFile file) {

        log.debug("文件上传,文件名:" + file.getOriginalFilename() + ";文件大小:" + file.getSize());
        Map model = new HashMap();
        try {

            //生成保存到服务器的路径
            String fileName = file.getOriginalFilename();
            StringBuffer sb = new StringBuffer("/images/");
            sb.append(DateUtil.format(new Date(), "yyyy")).append("/");
            sb.append(DateUtil.format(new Date(), "MM")).append("/");
            sb.append(DateUtil.format(new Date(), "dd")).append("/");
            sb.append(new Date().getTime()).append(getFileExt(fileName));

            //判断路径的所在文件夹是否存在 不存在则创建
            File saveFile = new File(Constant.UPLOAD_FILE_ROOT_PATH + Constant.UPLOAD_FILE_PRE_PATH + sb.toString());
            log.info("拼接后的保存文件路径是:" + Constant.UPLOAD_FILE_ROOT_PATH + Constant.UPLOAD_FILE_PRE_PATH + sb.toString());
            if (!saveFile.getParentFile().exists()) {
                log.info("保存文件的目录不存在,创建目录中..");
                saveFile.getParentFile().mkdirs();
            }

            //复制文件
            log.info("文件路径为:" + saveFile.getPath());
            file.transferTo(saveFile);


            String scale = request.getParameter("scale");
            if (StringUtils.isNotEmpty(scale)) {
                String[] s = scale.split(",");
                if (s.length % 2 == 0) {
                    for (int i = 0; i < s.length; i = i + 2) {
                        try {
                            int w = Integer.parseInt(s[i]);
                            int h = Integer.parseInt(s[i + 1]);
                            int dot = saveFile.getPath().lastIndexOf(".");
                            String picTo = saveFile.getPath().substring(0, dot) + "_" + w + "_" + h + saveFile.getPath().substring(dot);

//                            boolean ret = ImageUtils.resize(saveFile.getPath(), picTo, w, h, true);
//                            log.debug("文件缩放路径为:" + picTo + " :"+ret);

                        } catch (Exception e) {
                            e.printStackTrace();
                            throw e;
                        }
                    }
                } else {
                    //参数不成对
                    throw new Exception("缩放参数格式错误");
                }
            }
//
//            try {
//                Thread.sleep(2 * 1000);//上传完成后，休息2秒，给文件同步一点时间
//            } catch (Exception e) {
//            }

            //封装返回数据
            model.put("state", "SUCCESS");
            model.put("error", 0);
            model.put("url", Constant.UPLOAD_FILE_PRE_PATH + sb.toString());
            model.put("fileType", getFileExt(fileName));
            model.put("original", fileName);
            model.put("title", request.getParameter("pictitle") == null ? "" : request.getParameter("pictitle"));
            model.put("lisitPath", Constant.UPLOAD_FILE_URL_PRE);
            //生成一个图片标示
            model.put("imagId",UUID.randomUUID());
            log.info("返回给页面的属性值是:url:" + Constant.UPLOAD_FILE_PRE_PATH + sb.toString() + ",fileType:" + getFileExt(fileName) + ",original:" + fileName + ",lisitPath:" + Constant.UPLOAD_FILE_URL_PRE);
        } catch (Exception e) {
            model.put("state", "IO\\u5f02\\u5e38");
            model.put("message", "IO\\u5f02\\u5e38");
            model.put("error", 0);
            model.put("url", "");
            log.error("上传图片文件失败:" + e.getMessage(), e);
        }
        return model;
    }

    /**
     * 功能：视频文件上传
     *
     * @param
     * @return
     */
    @RequestMapping("videoFileUpload")
    public Map videoFileUpload(Map<String, String> param,
                                        @RequestParam(value = "file", required = true) MultipartFile file) {

        log.debug("文件上传,文件名:" + file.getOriginalFilename() + ";文件大小:" + file.getSize());
        Map model = new HashMap();
        try {

            //生成保存到服务器的路径
            String fileName = file.getOriginalFilename();
            StringBuffer sb = new StringBuffer("/video/");
            sb.append(DateUtil.format(new Date(), "yyyy")).append("/");
            sb.append(DateUtil.format(new Date(), "MM")).append("/");
            sb.append(DateUtil.format(new Date(), "dd")).append("/");
            sb.append(new Date().getTime());

            //判断路径的所在文件夹是否存在 不存在则创建
            File saveFile = new File(Constant.UPLOAD_FILE_ROOT_PATH + Constant.UPLOAD_FILE_PRE_PATH + sb.toString() + getFileExt(fileName));
            if (!saveFile.getParentFile().exists()) {
                saveFile.getParentFile().mkdirs();
            }

            //复制文件
            log.debug("文件路径为:" + saveFile.getPath());
            file.transferTo(saveFile);
            //生成图片缩略图
//            VideoUtils.toThumbnail(saveFile, new File(Constant.UPLOAD_FILE_ROOT_PATH + Constant.UPLOAD_FILE_PRE_PATH + sb.toString() + "_thumbnail.jpg"));

            //调用视频处理（统一转为mp4）
//            VideoUtils videoUtils = new VideoUtils();
//            videoUtils.toMp4(saveFile, new File(Constant.UPLOAD_FILE_ROOT_PATH+Constant.UPLOAD_FILE_PRE_PATH+sb.toString()+"_v.mp4"));
            //封装返回数据
            model.put("state", "SUCCESS");
            model.put("error", 0);
            model.put("url", Constant.UPLOAD_FILE_PRE_PATH + sb.toString() + getFileExt(fileName));
            model.put("fileType", getFileExt(fileName));
            model.put("original", fileName);
            model.put("lisitPath", Constant.UPLOAD_FILE_URL_PRE);
            

           
        } catch (Exception e) {
            model.put("state", "IO错误");
            model.put("message", "IO\\u5f02\\u5e38");
            model.put("error", 1);
            log.error("上传视频文件失败:" + e.getMessage(), e);
        }
        return model;
    }

    @RequestMapping("testConver")
    public void testConver(String path, String ext) {
        File file = new File(path + "." + ext);
//        VideoUtils videoUtils = new VideoUtils();
//        try {
//            videoUtils.toMp4(file, new File(path+"_v.mp4"));
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
    }


    /**
     * 功能：附件上传
     *
     * @param
     * @return
     */
    @RequestMapping("attachmentFileUpload")
    public Map attachmentFileUpload(HttpServletRequest request,
                                             @RequestParam(value = "file", required = true) MultipartFile file) {

        log.debug("文件上传,文件名:" + file.getOriginalFilename() + ";文件大小:" + file.getSize());


        Map model = new HashMap();
        try {

            //生成保存到服务器的路径
            String fileName = file.getOriginalFilename();

            String ext = getFileExt(fileName);
            String pre = "attach";
            StringBuffer sb = new StringBuffer("");
            boolean isTemplateFile = false;
            boolean overrideIfExists = "true".equalsIgnoreCase(request.getParameter("overrideIfExists"));

            //对于上传的模板资源，如js，css只放到js或css文件夹就可以了，不需要再分到每天的目录上
            String templateSource = ".js.css.html";
            if (StringUtils.isNotEmpty(ext) && templateSource.indexOf(ext) >= 0) {
                isTemplateFile = true;
                pre = ext.substring(1);
                sb.append("/" + pre + "/");

                //采用原始文件名
                sb.append(fileName);

            } else {

                sb.append("/" + pre + "/");
                sb.append(DateUtil.format(new Date(), "yyyy")).append("/");
                sb.append(DateUtil.format(new Date(), "MM")).append("/");
                sb.append(DateUtil.format(new Date(), "dd")).append("/");
                sb.append(new Date().getTime());
            }

            String urlPath = Constant.UPLOAD_FILE_PRE_PATH + sb.toString() + (isTemplateFile ? "" : getFileExt(fileName));

            //判断路径的所在文件夹是否存在 不存在则创建
            File saveFile = new File(Constant.UPLOAD_FILE_ROOT_PATH + urlPath);
            if (!saveFile.getParentFile().exists()) {
                saveFile.getParentFile().mkdirs();
            }

            if (!overrideIfExists && saveFile.exists()) {

                //封装返回数据
                model.put("state", "目标文件已存在，并且未设置覆盖");

            } else {
                //复制文件
                log.debug("文件路径为:" + saveFile.getPath());
                file.transferTo(saveFile);

                //封装返回数据
                model.put("state", "SUCCESS");
                model.put("error", 0);

            }


//            if (".zip".equalsIgnoreCase(ext)) {
//
//                if ("true".equalsIgnoreCase(request.getParameter("customTemplate"))) {
//                    //自定义模板的zip文件上传，需要做处理
//                    TemplateUploadUtils util = new TemplateUploadUtils();
//                    StringBuffer outIndexHtml = new StringBuffer();
//
//                    int flag = util.handleTemplateZipFile(request, saveFile, outIndexHtml);
//                    if (flag == 0) {
//                        model.addAttribute("extraInfo", outIndexHtml.toString());
//                    } else {
//                        model.addAttribute("state", flag == 1 ? "没有index主页文件" : "zip文件有错");
//                    }
//                }
//            }

            model.put("url", urlPath);
            model.put("fileType", getFileExt(fileName));
            model.put("original", fileName);
            model.put("lisitPath", Constant.UPLOAD_FILE_URL_PRE);
        } catch (Exception e) {
            model.put("state", "IO\\u5f02\\u5e38");
            model.put("message", "IO\\u5f02\\u5e38");
            model.put("error", 1);
            log.error("上传文件失败:" + e.getMessage(), e);

            e.printStackTrace();
        }
        return model;
    }

    /**
     * 获取文件扩展名
     *
     * @param fileName : 文件名
     * @return :返回文件扩展名
     */
    private String getFileExt(String fileName) {

        if (fileName.lastIndexOf(".") == -1) {
            //说明可能有乱码情况，取最后的匹配的格式后缀
            fileName = fileName.toLowerCase();


            String regex = ".*?((jpg)|(gif)|(png)|(js)|(css)|(html)|(flv)|(zip)|(mp3))$";

            Pattern pa = Pattern.compile(regex);
            Matcher ma = pa.matcher(fileName);
            if (ma.find()) {
                String ext = ma.group(1);

                return "." + ext;
            } else {
                return fileName.substring(fileName.length() - 3);
            }

        } else
            return fileName.substring(fileName.lastIndexOf("."));
    }
    // 工程头像上传图片
    /**
     * 上传图片的功能
     *
     * @param request
     * @return
     */
    @RequestMapping("/uploadImg")
    public ModelAndView uploadImg(HttpServletRequest request,@RequestParam(value = "file", required = true) MultipartFile file) {
        log.debug("文件上传,文件名:" + file.getOriginalFilename() + ";文件大小:" + file.getSize());
        ModelMap model = new ModelMap();

        // 获取上传文件的路径
        String uploadFilePath = file.getOriginalFilename();
        log.info("uploadFlePath:" + uploadFilePath);

        // 截取上传文件的文件名
        String uploadFileName = uploadFilePath.substring(uploadFilePath.lastIndexOf('\\') + 1,
            uploadFilePath.lastIndexOf('.'));
        log.info("uploadFileName：  " + uploadFileName);

        // 截取上传文件的后缀
        String suffix = uploadFilePath.substring(uploadFilePath.lastIndexOf(".") + 1);
        log.info("uploadFileSuffix:   " + suffix);

        InputStream fis = null;
        try {
            Integer length = file.getBytes().length;
            log.info("file size: " + length);

            fis = file.getInputStream();
            Map result = this.upload(fis, suffix);
            log.info("map:"+result);

            //封装返回数据
            model.addAttribute("state", "SUCCESS");
            model.addAttribute("error", 0);
            model.addAttribute("url", result.get("url"));
            model.addAttribute("fileType", suffix);
            model.addAttribute("original", uploadFilePath);
            model.addAttribute("title", request.getParameter("pictitle") == null ? "" : request.getParameter("pictitle"));
            return new ModelAndView("jsonView", model);

        } catch (Exception e) {
            model.addAttribute("state", "IO\\u5f02\\u5e38");
            model.addAttribute("message", "IO\\u5f02\\u5e38");
            model.addAttribute("error", 0);
            model.addAttribute("url", "");
            log.error("上传图片文件失败:" + e.getMessage(), e);
            return new ModelAndView("jsonView", model);
        } finally {
            if (fis != null) {
                try {
                    fis.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * 上传图片后，将图片的信息返回
     * @param fis
     * @return
     */
    private Map upload(InputStream fis, String suffix) {

        try {
            ByteArrayOutputStream bos = new ByteArrayOutputStream(1000);

            byte[] b = new byte[1024];
            int n = 0;
            while ((n = fis.read(b)) != -1) {
                bos.write(b, 0, n);
            }
            byte[] buffer = bos.toByteArray();
            DefaultHttpClient httpClient = new DefaultHttpClient();
            httpClient.setHttpRequestRetryHandler(new DefaultHttpRequestRetryHandler(0, false));
            HttpPost post = new HttpPost(url + suffix);
            log.info(" image upload url :" + url);

            post.addHeader("token", token);
            post.setEntity(new ByteArrayEntity(buffer));

            HttpResponse httpResponse = httpClient.execute(post);
            // 将结果转换成串
            String content = EntityUtils.toString(httpResponse.getEntity());
            log.info("upload result :" + content);

            fis.close();
            bos.close();
            httpClient.close();

            ObjectMapper mapper = new ObjectMapper();
            Map map = mapper.readValue(content, Map.class);

            return map;
        } catch (Exception e) {

            e.printStackTrace();
            return null;
        }
    }
}