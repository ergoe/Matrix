package api.getters;

import com.netflix.hystrix.HystrixCommand;
import com.netflix.hystrix.HystrixCommandGroupKey;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

/**
 * Created by Eric on 6/30/16.
 */
public class TestResults extends HystrixCommand<String>  {

    private String testRunId = "";

    public TestResults(String testRunId) {
        super(HystrixCommandGroupKey.Factory.asKey("TestResults"));
        this.testRunId = testRunId;
    }

    @Override
    public String run() throws Exception {
        Response response = null;
        String testResults = "";

        OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
                .url("http://eric-OptiPlex-980:3000/testRunResults?testRun=" + this.testRunId)
                .build();
        response = client.newCall(request).execute();

        testResults = response.body().string();

        return testResults;
    }
}
