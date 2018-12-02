package com.jiuheng.api.utils;

import java.security.SecureRandom;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by liuhaikuo on 2017/11/6.
 */
public class SsoUserCookieTools {

    private static final Logger logger = LoggerFactory.getLogger(SsoUserCookieTools.class);

    private static SecureRandom secureRandom = new SecureRandom();

    public static long createRand(){
        return secureRandom.nextLong();
    }

}
