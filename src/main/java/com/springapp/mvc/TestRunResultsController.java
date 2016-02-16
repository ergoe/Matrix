package com.springapp.mvc;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.IOException;

/**
 * Created by Eric on 1/26/16.
 */
@Controller
//@RequestMapping("/TestResults")
public class TestRunResultsController {

    @RequestMapping(value = "/TestResults/{testRunId}", method = RequestMethod.GET)
    public String printWelcome(@PathVariable("testRunId")String testRunId, ModelMap model) throws IOException {
        //model.addAttribute("message", "Hello world!");
        String testResults1 = getTestResults(testRunId);
        return "testResults";
    }


    String getTestResults(String testRunId) throws IOException {
        Response response = null;
        String testResults = "";

        OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
                .url("http://eric-OptiPlex-980:3000/testCaseResults?testRunId=" + testRunId)
                .build();
        response = client.newCall(request).execute();

        testResults = response.body().string();

        return testResults;
    }


}
