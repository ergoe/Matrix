package api.getters;

import com.netflix.hystrix.HystrixCommand;
import com.netflix.hystrix.HystrixCommandGroupKey;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

/**
 * Created by Eric on 4/25/17.
 */
public class TestHistory extends HystrixCommand<String> {

    private String testRunId = "";
    private String optiPlexIPAddress = "10.7.35.158";

    public TestHistory(String testRunId) {
        super(HystrixCommandGroupKey.Factory.asKey("TestHistory"));
        this.testRunId  = testRunId;
    }

    @Override
    public String run() throws Exception {
        Response response = null;
        String testResultsHistory = "";

        OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
                .url("http://" + optiPlexIPAddress + ":8080/AllSpark/testCaseHistory/" + testRunId)
                .build();

        response = client.newCall(request).execute();

        testResultsHistory = response.body().string();

        return testResultsHistory;
    }
}
