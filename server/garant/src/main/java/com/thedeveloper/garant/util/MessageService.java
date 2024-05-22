package com.thedeveloper.garant.util;

import java.io.IOException;
import java.io.OutputStream;
import java.net.*;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.StringJoiner;

public class MessageService {
    private final static String API_LOGIN = "erdosjz@mail.ru";
    private final static String API_PSW = "eastwestsms1A";
    public static void sendMessageRegisterCode(String number, String code) throws IOException, URISyntaxException, InterruptedException {

        HttpClient client = HttpClient.newHttpClient();

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create("https://smsc.kz/sys/send.php?login="+API_LOGIN+"&psw="+API_PSW+"&phones="+number))
                .POST(HttpRequest.BodyPublishers.ofString("mes=Ваш код для подтверждения: "+code))
                .setHeader("cache-control", "no-cache")
                .setHeader("content-type", "application/x-www-form-urlencoded")
                .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
    }
}
