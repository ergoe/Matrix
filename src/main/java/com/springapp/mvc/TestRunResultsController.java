package com.springapp.mvc;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
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
        model.addAttribute("testRunId", testRunId);
        String testResults1 = getTestResults(testRunId);
        JsonNode node = getJsonNode(testResults1);

        String passCount = "";
        String failCount = "";
        String impossibleCount = "";

        if (node.has("PASS")) {
            passCount = node.at("/PASS").toString();
        } else {
            passCount = "0";
        }

        if (node.has("FAILED")) {
            failCount = node.at("/FAILED").toString();
        } else {
            failCount = "0";
        }

        if (node.has("IMPOSSIBLE")) {
            impossibleCount = node.at("/IMPOSSIBLE").toString();
        } else {
            impossibleCount = "0";
        }

        int intPassCount = Integer.parseInt(passCount);
        int intFailCount = Integer.parseInt(failCount);
        int intImpossibleCount = Integer.parseInt(impossibleCount);

        int total = intPassCount + intFailCount + intImpossibleCount;

        model.addAttribute("Failed", failCount);
        model.addAttribute("Passed", passCount);
        model.addAttribute("Impossible", impossibleCount);
        model.addAttribute("Total", total);
        return "testResults";
    }


    String getTestResults(String testRunId) throws IOException {
        Response response = null;
        String testResults = "";

        OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
                .url("http://eric-OptiPlex-980:3000/testRunResults?testRun=" + testRunId)
                .build();
        response = client.newCall(request).execute();

        testResults = response.body().string();

        return testResults;
    }

    private JsonNode getJsonNode(String jsonResponse) {
        JsonNode mainBody = null;

        ObjectMapper mapper = new ObjectMapper();
        try {
            String response = jsonResponse;
            mainBody = mapper.readTree(response);
        } catch (IOException ioex) {
            System.out.print(ioex.getStackTrace());
        }
        return mainBody;
    }


}
