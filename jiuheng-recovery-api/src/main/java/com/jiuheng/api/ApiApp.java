package com.jiuheng.api;

import java.util.concurrent.CountDownLatch;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.ImportResource;


@SpringBootApplication
@ImportResource("classpath:/META-INF/spring-dubbo-client.xml")
public class ApiApp {
	final static Logger logger = LoggerFactory.getLogger(ApiApp.class);
    public static void main(String[] args) {
        ConfigurableApplicationContext context = SpringApplication.run(ApiApp.class, args);
        logger.info("----------> jiuheng-api App Server Start Success <---------");
        try {
            CountDownLatch latch = new CountDownLatch(1);
            latch.await();
        } catch (BeansException | InterruptedException e) {
            e.printStackTrace();
        }
    }
}
