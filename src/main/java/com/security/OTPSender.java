package com.security;

import com.twilio.sdk.TwilioRestClient;
import com.twilio.sdk.resource.factory.MessageFactory;
import com.twilio.sdk.resource.instance.Account;
import com.twilio.sdk.resource.instance.Message;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import java.util.ArrayList;
import java.util.List;

public class OTPSender {
    private final String ACCOUNT_SID;
    private final String AUTH_TOKEN;
    private final String FROM_NUMBER;
    
    public OTPSender(String accountSid, String authToken, String fromNumber) {
        this.ACCOUNT_SID = accountSid;
        this.AUTH_TOKEN = authToken;
        this.FROM_NUMBER = fromNumber;
    }
    
    public void sendOTP(String toNumber, String otp) {
        TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
        Account account = client.getAccount();
        MessageFactory messageFactory = account.getMessageFactory();

        List<NameValuePair> params = new ArrayList<>();
        params.add(new BasicNameValuePair("To", toNumber));
        params.add(new BasicNameValuePair("From", FROM_NUMBER));
        params.add(new BasicNameValuePair("Body", "" + otp));

        try {
            Message message = messageFactory.create(params);
            System.out.println("Message SID: " + message.getSid());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
