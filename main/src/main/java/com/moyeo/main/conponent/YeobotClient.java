package com.moyeo.main.conponent;

import com.google.gson.Gson;
import com.moyeo.main.exception.BaseException;
import com.moyeo.main.exception.ErrorMessage;
import lombok.extern.slf4j.Slf4j;
import okhttp3.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Map;

@Slf4j
@Component
public class YeobotClient {
    private final OkHttpClient okHttpClient;
    private final String flaskUrl;

    public YeobotClient(OkHttpClient okHttpClient, @Value("${flask-url}") String flaskUrl) {
        this.okHttpClient = okHttpClient;
        this.flaskUrl = flaskUrl;
    }

    public ResponseEntity<String> sendYeobotData(String caseType, String data) {
        MediaType mediaType = MediaType.parse("application/json; charset=utf-8");
        RequestBody requestBody = RequestBody.create(mediaType, data);
        Request request = new Request.Builder()
                .header("title", caseType)
                .url(flaskUrl)
                .post(requestBody)
                .build();

        Response response = null;
        try {
            response = okHttpClient.newCall(request).execute();
        } catch (Exception e) {
            throw new BaseException(ErrorMessage.FLASK_SERVER_ERROR);
        }
        String responseBody = null;
        try {
            responseBody = response.body().string();
            Gson gson = new Gson();
            Map<String, String> getdata = gson.fromJson(responseBody, Map.class);
            String result = getdata.get("result");
        } catch (Exception e) {
            throw new BaseException(ErrorMessage.TOO_LONG_COMMAND);
        }
        return ResponseEntity.ok(responseBody);
    }






}