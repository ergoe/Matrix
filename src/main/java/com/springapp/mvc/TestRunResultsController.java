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
 * Created by Eric on 1/26/16.
 */
@Controller
@RequestMapping("/TestResults")
public class TestRunResultsController {

    @RequestMapping(method = RequestMethod.GET)
    public String printWelcome(ModelMap model) {
        //model.addAttribute("message", "Hello world!");
        return "testResults";
    }


    String getTestResults() throws IOException {
        Response response = null;
        String uno1 = "";

        OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
                .url("http://eric-OptiPlex-980:3000")
                .build();
        response = client.newCall(request).execute();

        uno1 = response.body().string();

        return uno1;
    }


}
