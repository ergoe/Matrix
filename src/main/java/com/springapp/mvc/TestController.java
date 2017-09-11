package com.springapp.mvc;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.IOException;

/**
 * Created by Eric on 2/12/16.
 */
@Controller
//@RequestMapping("/Test")
public class TestController {

    String optiplexIPAddress = "10.7.31.162";

    @RequestMapping("/Test")
    public String printThisIsATest(ModelMap model) {
        String result1 = "Hey... this is result 1";
        String result2 = "Hey... this is result 2";

        model.addAttribute("result1", result1);
        model.addAttribute("result2", result2);

        return "test";
    }

    @RequestMapping("/newIndex")
    public String displayNewTestRunPage(ModelMap model) {
        //model.addAttribute("message", "Hello world!");
        return "indexNew";
    }

    @RequestMapping("/uno")
    public String printUno(ModelMap model) {
        Response response = null;
        String uno1 = "";

        OkHttpClient client = new OkHttpClient();

        try {
            Request request = new Request.Builder()
                    .url("http://" + optiplexIPAddress + ":3000")
                    .build();
            response = client.newCall(request).execute();

            uno1 = response.body().string();
            System.out.println(response.body());
        } catch (IOException ioex) {

        }


        String uno2 = "Hey this is uno 2";

        model.addAttribute("result1", uno1);
        model.addAttribute("result2", uno2);

        return "test";
    }
}
