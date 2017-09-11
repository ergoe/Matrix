package com.springapp.mvc;

import api.getters.TestHistory;
import api.getters.TestResults;
import api.getters.NewTestResults;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.IOException;
import java.util.*;

/**
 * Created by Eric on 1/26/16.
 */
@Controller
//@RequestMapping("/TestResults")
public class NewTestRunResultsController {

    String optiplexIPAddress = "10.7.31.162";

    @RequestMapping(value = "/NewTestResults/{testRunId}", method = RequestMethod.GET)
    public String printWelcome(@PathVariable("testRunId")String testRunId, ModelMap model) throws Exception {
        //model.addAttribute("message", "Hello world!");
        model.addAttribute("testRunId", testRunId);
        String testResults1 = getTestResults(testRunId);
        JsonNode node = getJsonNode(testResults1);
        JsonNode testHistoryNode = null;

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

        String testTagResultsString = getTestTagResults(testRunId);

//        String testResultHistory = getTestResultsHistory(testRunId);
//        testHistoryNode = getJsonNode(testResultHistory);
//        model.addAttribute("TestCaseHistory", testHistoryNode);
        node = getJsonNode(testTagResultsString);
        model.addAttribute("testTags", getTags(node));

        return "newTestResults";
    }

    String getTestResults(String testRunId) throws Exception {
//        String blah = new TestResults(testRunId).execute();
        String blah = new NewTestResults(testRunId).execute();
        return blah;
    }

    String getTestResultsHistory(String testRunId) throws IOException {
        String testHistoryResults = new TestHistory(testRunId).execute();
        return testHistoryResults;
    }



    String getTestTagResults(String testRunId) throws IOException {
        Response response = null;
        String testResults = "";

        OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
                .url("http://" + optiplexIPAddress + ":8080/LumberJackService/getTests?testRunId=" + testRunId)
                .build();
        response = client.newCall(request).execute();

        testResults = response.body().string();

        return testResults;
    }

    private Map<String, Integer> getTags(JsonNode node) {
        List<String> testTags = new CountItemsList<String>();
        Map<String, Integer> tags = new HashMap<String, Integer>();
        ArrayNode testResultsNodes = (ArrayNode)node;
        for (JsonNode n: testResultsNodes) {
            if (n.hasNonNull("tags")) {

                for (String tt : n.get("tags").toString().replace("\"", "").split(" ")) {
                    testTags.add(tt);
                }
            }
        }
        System.out.println(((CountItemsList)testTags).getCount("API"));
        return enterTagsCount((CountItemsList)testTags);
    }

    private Map<String, Integer> enterTagsCount(CountItemsList<String> testTags) {
        Map<String, Integer> tags = new HashMap<String, Integer>();

        List<String> tagKeys =
                new ArrayList<String>(new LinkedHashSet<String>(testTags));
        for (String t : tagKeys) {

            tags.put(t, testTags.getCount(t));
        }
        return tags;
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
