package com.oab.ipay;

import com.oab.ipay.key.KeyParser;
import com.oab.ipay.vo.Request;
import com.oab.ipay.vo.RequestTranData;

public class OabIpayRequestBuilder {
	
	public static RequestTranData prepareSignedRequestTranData(Request request) throws Exception {
		return toSignedRequestTranData(request);
	}
	
	private static RequestTranData toSignedRequestTranData(Request request) throws Exception {
		RequestTranData tranData = new RequestTranData();
		
		String signKey = request.getSignKey();
		String webAddress = "https://securepayments.oabipay.com/trxns/";
		if("test".equals(request.getMode()) || "SANDBOX".equals(request.getMode())) {
			webAddress = "https://certpayments.oabipay.com/trxns/";	
		}
		request.setSignKey(null);
		request.setMode(null);
		
		request.setAction("1");
		tranData.setTrandata(request.getData(signKey));
		tranData.setWebAddress(webAddress.concat("transactionRoute.htm?param=tranRoute"));	
		tranData.setTranportalId(request.getId());
		tranData.setResponseURL(request.getResponseURL());
		tranData.setErrorURL(request.getErrorURL());
		return tranData;
	}

	
	public static RequestTranData prepareRequestTranData(Request request) throws Exception {
		return toRequestTranData(request);
	}

	private static RequestTranData toRequestTranData(Request request) throws Exception {
		RequestTranData tranData = new RequestTranData();
		KeyParser key = new KeyParser(request.getKeyPath(), request.getAlias());
		
		request.setAlias(null);
		request.setKeyPath(null);
		request.setId(key.getId());
		request.setPassword(key.getPassword());
		request.setAction("1");
		tranData.setTrandata(request.getData(key.getKey()));
		tranData.setWebAddress(key.getWebAddress().concat("transactionRoute.htm?param=tranRoute"));	
		
		tranData.setResponseURL(request.getResponseURL());
		tranData.setErrorURL(request.getErrorURL());
		tranData.setTranportalId(key.getId());
		return tranData;
	}
	
}
