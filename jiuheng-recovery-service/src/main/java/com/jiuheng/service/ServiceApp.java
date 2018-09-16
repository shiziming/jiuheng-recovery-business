package com.jiuheng.service;

import java.util.concurrent.CountDownLatch;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.ImportResource;

@SpringBootApplication
@ImportResource("classpath*:META-INF/applicationContext.xml")
public class ServiceApp {
	final static Logger logger = LoggerFactory.getLogger(ServiceApp.class);
    public static void main(String[] args) {
        ConfigurableApplicationContext context = SpringApplication.run(ServiceApp.class, args);
        logger.info("----------> jiuheng-order-service App Server Start Success <---------");
        try {
            CountDownLatch latch = new CountDownLatch(1);
            latch.await();
        } catch (BeansException | InterruptedException e) {
            e.printStackTrace();
        }
    }
}
