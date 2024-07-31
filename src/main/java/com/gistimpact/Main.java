package com.gistimpact;

import com.gistimpact.logger.Logger;

import java.util.HashMap;
import java.util.Map;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
        Logger.setApplication("Capital Connector Service");

        Map<String, String> context = new HashMap<>();
        context.put("userId", "user1234");
        context.put("operation", "RetrieveProfile");
        context.put("stackTrace", "abc");

        Logger logger = new Logger();
        logger.setLevel("info");
        logger.setPath("/user/login");
        logger.setEventId("api_exception_03");
        logger.setStatus("Success");
        logger.setStatusCode(200);
        logger.setMessage("User have successfully logged in.");
        logger.setSource("UserProfileService");
        logger.setContext(context);

        logger.log();
    }
}