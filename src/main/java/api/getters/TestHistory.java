package api.getters;

import com.netflix.hystrix.HystrixCommand;
import com.netflix.hystrix.HystrixCommandGroupKey;
import com.netflix.hystrix.HystrixCommandProperties;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

/**
 * Created by Eric on 4/25/17.
 */
public class TestHistory extends HystrixCommand<String> {

    private String testRunId = "";
    private String environment = "";
    private String optiPlexIPAddress = "10.7.31.162";

    public TestHistory(String testRunId, String environment) {
        super(
                Setter.withGroupKey(HystrixCommandGroupKey.Factory.asKey("TestHistory"))
                        .andCommandPropertiesDefaults(
                                HystrixCommandProperties.Setter()
                                .withExecutionTimeoutInMilliseconds(35000)));
        this.testRunId  = testRunId;
        this.environment = environment;
    }


    @Override
    public String run() throws Exception {
        Response response = null;
        String testResultsHistory = "";

        OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
                .url("http://" + optiPlexIPAddress + ":8080/LumberJackService/getTestHistory/" + testRunId + "?environment=" + environment)
                .build();

        response = client.newCall(request).execute();

        testResultsHistory = response.body().string();

        return testResultsHistory;
    }
}
