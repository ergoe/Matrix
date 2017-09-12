package api.getters;

import com.netflix.hystrix.Hystrix;
import com.netflix.hystrix.HystrixCommand;
import com.netflix.hystrix.HystrixCommandGroupKey;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

/**
 * Created by Eric on 6/30/16.
 */
public class NewTestResults extends HystrixCommand<String>  {

    private String testRunId = "";
    String optiplexIPAddress = "10.7.31.162";

    public NewTestResults(String testRunId) {
        super(HystrixCommandGroupKey.Factory.asKey("TestResults"));
        this.testRunId = testRunId;
    }

    @Override
    public String run() throws Exception {
        Response response = null;
        String testResults = "";

        OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
                .url("http://" + optiplexIPAddress + ":8080/LumberJackService/getTests?testRunId=" + this.testRunId)
                .build();
        response = client.newCall(request).execute();

        testResults = response.body().string();
        Hystrix.reset();
        return testResults;
    }
}
