package com.oab.ipay;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.InetSocketAddress;
import java.net.Proxy;
import java.net.URL;

import org.json.JSONArray;
import org.json.JSONObject;

import com.oab.ipay.avail.JsonUtil;
import com.oab.ipay.key.KeyParser;
import com.oab.ipay.vo.Reply;
import com.oab.ipay.vo.Request;
import com.oab.ipay.vo.SplitPaymentPayload;

class OabIpayConnectionImpl {
	
	private Connection connection;
	
	public OabIpayConnectionImpl() {
		this.connection = new Connection();
	}

	public OabIpayConnectionImpl(boolean proxy, String proxyHost, Integer proxyPort) {
		this.connection = new Connection(proxy, proxyHost, proxyPort);
	}

	protected Reply processInquiryByTrackId(Request request) throws Exception {
		return processInquiry(request, "TrackID");
	}

	protected Reply processInquiryByPaymentId(Request request) throws Exception {
		return processInquiry(request, "PaymentID");
	}

	protected Reply processInquiryByTranId(Request request) throws Exception {
		return processInquiry(request, "");
	}

	protected Reply processInquiryByRefNo(Request request) throws Exception {
		return processInquiry(request, "SeqNum");
	}

	protected Reply processInquiry(Request request, String udf5) throws Exception {
		KeyParser key = new KeyParser(request.getKeyPath(), request.getAlias());
		request.setAlias(null);
		request.setKeyPath(null);
		request.setAction("8");
		request.setId(key.getId());
		request.setPassword(key.getPassword());
		request.setUdf5(udf5);
		request.setErrorURL(key.getWebAddress());
		request.setResponseURL(key.getWebAddress());
        String url = key.getWebAddress().concat("transactionRoute.htm?param=tranTCPIPRoute");
		return connection.connectIpay(url, request);
	}

	protected Reply processRefundByTranId(Request request) throws Exception {
		KeyParser key = new KeyParser(request.getKeyPath(), request.getAlias());
		request.setAlias(null);
		request.setKeyPath(null);
		request.setAction("2");
		request.setId(key.getId());
		request.setPassword(key.getPassword());
		request.setUdf5("");
		request.setErrorURL(key.getWebAddress());
		request.setResponseURL(key.getWebAddress());
		String url = key.getWebAddress().concat("transactionRoute.htm?param=tranTCPIPRoute");
		return connection.connectIpay(url, request);
	}
	
	protected Reply processSignedRefundByTranId(Request request) throws Exception {
		request.setAction("2");
		request.setUdf5("");
		String webAddress = "https://securepayments.oabipay.com/trxns/";
		if("test".equals(request.getMode()) || "SANDBOX".equals(request.getMode())) {
			webAddress = "https://certpayments.oabipay.com/trxns/";	
		}
		request.setErrorURL(webAddress);
		request.setResponseURL(webAddress);
		String url = webAddress.concat("transactionRoute.htm?param=tranTCPIPRoute");
		return connection.connectIpay(url, request);
	}
	
	protected Reply processReversalByTrackId(Request request) throws Exception {
		KeyParser key = new KeyParser(request.getKeyPath(), request.getAlias());
		request.setAlias(null);
		request.setKeyPath(null);

		request.setAction("3");
		request.setId(key.getId());
		request.setPassword(key.getPassword());
		request.setUdf5("TrackID");
		request.setErrorURL(key.getWebAddress());
		request.setResponseURL(key.getWebAddress());
		String url = key.getWebAddress().concat("transactionRoute.htm?param=tranTCPIPRoute");
		return connection.connectIpay(url, request);
	}

	protected Reply processReversalByTranId(Request request) throws Exception {
		KeyParser key = new KeyParser(request.getKeyPath(), request.getAlias());
		request.setAlias(null);
		request.setKeyPath(null);
		request.setAction("3");
		request.setId(key.getId());
		request.setPassword(key.getPassword());
		request.setUdf5("");
		request.setErrorURL(key.getWebAddress());
		request.setResponseURL(key.getWebAddress());
		String url = key.getWebAddress().concat("transactionRoute.htm?param=tranTCPIPRoute");
		return connection.connectIpay(url, request);
	}
	
	protected Reply initiateTransaction(Request request) throws Exception {
		KeyParser key = new KeyParser(request.getKeyPath(), request.getAlias());
		request.setAction("1");
		request.setId(key.getId());
		request.setPassword(key.getPassword());
		request.setCard(request.getCardNo());
		request.setExpmonth(request.getExpMonth());
		request.setExpyear(request.getExpYear());
		request.setMember(request.getCardName());
		request.setAlias(null);
		request.setKeyPath(null);
		request.setCardNo(null);
		request.setCardName(null);
		request.setExpMonth(null);
		request.setExpYear(null);
        String url = key.getWebAddress().concat("transactionRoute.htm?param=tranVBVRoute");
		Reply reply = connection.connectIpay(url, request);
		String error = reply.getError() != null && !reply.getError().isEmpty() ? reply.getError() : null;
		error =  error != null && !error.isEmpty() ? error : reply.getErrorText() != null && !reply.getErrorText().isEmpty() ? reply.getErrorText() : null;
		if(error != null) {
			throw new Exception(error);
		} else {
			reply.setResult("INITILIZED");
		}
        return reply;
	}

	
	protected Reply initiateSignedTransaction(Request request) throws Exception {
		request.setAction("1");
		request.setCard(request.getCardNo());
		request.setExpmonth(request.getExpMonth());
		request.setExpyear(request.getExpYear());
		request.setMember(request.getCardName());
		
		request.setAlias(null);
		request.setKeyPath(null);
		request.setCardNo(null);
		request.setCardName(null);
		request.setExpMonth(null);
		request.setExpYear(null);
		String webAddress = "https://securepayments.oabipay.com/trxns/";
		if("test".equals(request.getMode()) || "SANDBOX".equals(request.getMode())) {
			webAddress = "https://certpayments.oabipay.com/trxns/";	
		}
		request.setSignKey(null);
		request.setMode(null);
		String url = webAddress.concat("transactionRoute.htm?param=tranVBVRoute");
		Reply reply = connection.connectIpay(url, request);
		String error = reply.getError() != null && !reply.getError().isEmpty() ? reply.getError() : null;
		error =  error != null && !error.isEmpty() ? error : reply.getErrorText() != null && !reply.getErrorText().isEmpty() ? reply.getErrorText() : null;
		if(error != null) {
			throw new Exception(error);
		} else {
			reply.setResult("INITILIZED");
		}
        return reply;
	}

}

class Connection {

	private boolean proxy;
	private String proxyHost;
	private Integer proxyPort;
	
	public Connection() {
	}
	
	public Connection(boolean proxy, String proxyHost, Integer proxyPort) {
		this.proxy = proxy;
		this.proxyHost = proxyHost;
		this.proxyPort = proxyPort;
	}
	
	
    protected Reply connectIpay(String webUrl, Request request) throws Exception {
        String response = sendHttpRequest(webUrl, request);
        return parseReply(response);
    }

    private String sendHttpRequest(String webUrl, Request request) throws Exception {
        HttpURLConnection connection = createHttpConnection(webUrl);
        sendRequestPayload(connection, request);
        return getResponse(connection);
    }

    private HttpURLConnection createHttpConnection(String webUrl) throws IOException {
        Proxy proxy = this.proxy 
                ? new Proxy(Proxy.Type.HTTP, new InetSocketAddress(this.proxyHost, this.proxyPort))
                : Proxy.NO_PROXY;

        URL url = new URL(webUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection(proxy);
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setRequestProperty("Accept", "application/json");
        connection.setDoOutput(true);

        return connection;
    }

    private void sendRequestPayload(HttpURLConnection connection, Request request) throws Exception {
        try (OutputStreamWriter writer = new OutputStreamWriter(connection.getOutputStream())) {
            writer.write(JsonUtil.objectToJson(request).toString());
            writer.flush();
        }
    }

    private String getResponse(HttpURLConnection connection) throws IOException {
        StringBuilder response = new StringBuilder();

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
        }

        return response.toString();
    }

	public static Reply parseReply(String response) throws Exception {
		JSONObject json = new JSONObject(response);
		Reply reply = new Reply();
		reply.setResult(json.optString("result"));
		reply.setPaymentId(json.optString("paymentid"));
		reply.setTranId(json.optString("tranid"));
		reply.setRef(json.optString("ref"));
		reply.setAmt(json.optString("amt"));
		reply.setAuth(json.optString("auth"));
		reply.setDate(json.optString("date"));
		reply.setUdf1(json.optString("udf1"));
		reply.setUdf2(json.optString("udf2"));
		reply.setUdf3(json.optString("udf3"));
		reply.setUdf4(json.optString("udf4"));
		reply.setUdf5(json.optString("udf5"));
		reply.setUdf5(json.optString("udf5"));
		reply.setTranResponseDate(json.optString("tranResponseDate"));
		reply.setTranRequestDate(json.optString("tranRequestDate"));
		reply.setTranDate(json.optString("tranDate"));
		reply.setRedirectUrl(json.optString("url"));
		if (json.optString("tokencustid") == null) {
			reply.setTokenNo(json.optString("custid"));
		} else {
			reply.setTokenNo(json.optString("tokencustid"));
		}
		if (json.optString("trackid") == null) {
			reply.setTrackId(json.optString("trackId"));
		} else {
			reply.setTrackId(json.optString("trackid"));
		}
		JSONArray jsonArray = json.optJSONArray("splitPaymentPayload");
		if (jsonArray != null) {
			SplitPaymentPayload splitPayLoad = null;
			for (int i = 0; i < jsonArray.length(); i++) {
				splitPayLoad = new SplitPaymentPayload();
				JSONObject responseObj = (JSONObject) jsonArray.get(i);
				splitPayLoad.setAliasName(responseObj.optString("aliasName"));
				splitPayLoad.setReference(responseObj.optString("reference"));
				splitPayLoad.setNotes(responseObj.optString("notes"));
				splitPayLoad.setSplitAmount(responseObj.optString("splitAmount"));
				splitPayLoad.setSplitTranId(responseObj.optString("splitTranId"));
				splitPayLoad.setType(responseObj.optString("type"));
				reply.addSplitPaymentPayload(splitPayLoad);
			}
		}
		reply.setError(json.optString("Error"));
		reply.setErrorText(json.optString("ErrorText"));
		if(reply.getErrorText() == null || reply.getErrorText().trim().isEmpty()) {
			reply.setErrorText(json.optString("error_text"));	
		}
		return reply;
	}

}
