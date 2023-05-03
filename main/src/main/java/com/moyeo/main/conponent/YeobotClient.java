package com.moyeo.main.conponent;

import lombok.extern.slf4j.Slf4j;
import okhttp3.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Slf4j
@Component
public class YeobotClient {
    private final OkHttpClient okHttpClient;
    private final String flaskUrl;

    public YeobotClient(OkHttpClient okHttpClient, @Value("${flask-url}") String flaskUrl) {
        this.okHttpClient = okHttpClient;
        this.flaskUrl = flaskUrl;
    }

    public ResponseEntity<String> sendYeobotData(String endpoint, String data) throws IOException {
        MediaType mediaType = MediaType.parse("application/json");
        RequestBody requestBody = RequestBody.create(mediaType, data);
        Request request = new Request.Builder()
                .url(flaskUrl + "/api/auth/yeobot/" + endpoint)
                .post(requestBody)
                .build();
        Response response = okHttpClient.newCall(request).execute();
        String responseBody = response.body().string();
        return ResponseEntity.ok(responseBody);
    }

}