package com.oab;

import java.util.Random;

import com.oab.ipay.OabIpayConnection;
import com.oab.ipay.OabIpayReplyBuilder;
import com.oab.ipay.OabIpayRequestBuilder;
import com.oab.ipay.vo.Reply;
import com.oab.ipay.vo.ReplyTranData;
import com.oab.ipay.vo.Request;
import com.oab.ipay.vo.RequestTranData;
import com.oab.ipay.vo.SplitPaymentPayload;

public class Application {

	public static void main(String[] args) throws Exception {
		show("=====================================");
		show("  Welcome to Oman Arab Bank Oab Ipay v-2");
		show("=====================================");
		show("Please use the library to use the version 2 features.");
		
//		testSignedBankHostedTransaction();
		
//		testMerchantTransaction();
//		parseResponse();
		testSignedMerchantTransaction();
		
//		testMerchantTransaction();
//		parseResponse();
//		parseSignedResponse();
		
//		testRefundTransaction();
		
	}
	
	private static void testSignedBankHostedTransaction() throws Exception {

		System.out.println("Application.testSignedMerchantTransaction()");
		RequestTranData reqTranData = null;
		Request req = null;
		String id = "ipay707336589914";
		String password = "Shopping@123";
		String resourceKey = "707360962352707360962352";
		String currency = "512";
		String language = "EN";
		String receiptURL = "http://localhost:8080/merchantPlugin/shopping/merchanthostedvbvtcp/vbvTranPipeResult.jsp";
		String errorURL = "http://localhost:8080/merchantPlugin/shopping/merchanthostedvbvtcp/vbvTranPipeError.jsp";
		String udf1 = "Udf 1";
		String udf2 = "Udf 2";
		String udf3 = "Udf 3";
		String udf4 = "Udf 4";
		String udf5 = "Udf 5";
		String amount = "100";
		String trackid = "920384234";
		String action = "1";
		String tokenNo = null;
		String tokenFlag = null;
		

		req = new Request();
		req.setMode("SANDBOX");
		
		req.setId(id);
		req.setPassword(password);
		req.setSignKey(resourceKey);
		req.setCurrencycode(currency);
		req.setLangid(language);
		req.setResponseURL(receiptURL);
		req.setErrorURL(errorURL);
		req.setAmt(amount);
		req.setTrackid(trackid);
		req.setUdf1(udf1);
		req.setUdf2(udf2);
		req.setUdf3(udf3);
		req.setUdf4(udf4);
		req.setUdf5(udf5);
		req.setTokenNo(tokenNo);
		req.setTokenFlag(tokenFlag);
		

		req.setSplitPaymentIndicator("0");
		SplitPaymentPayload splitPayLoad = new SplitPaymentPayload();

		splitPayLoad.setAliasName("ROPCUSTOMS2022");
		splitPayLoad.setNotes("Salary");
		splitPayLoad.setType("1");
		splitPayLoad.setReference(String.valueOf(Math.abs(new Random().nextInt())));
		splitPayLoad.setSplitAmount("10");

		req.addSplitPaymentPayload(splitPayLoad);

		if (tokenNo != null && tokenNo.isEmpty()) {
			req.setTokenNo(tokenNo);
			if ("1".equals(action)) {
				req.setTokenFlag("2");
			}
		}
		RequestTranData requestTranData = OabIpayRequestBuilder.prepareSignedRequestTranData(req);
		System.out.println("Reply Web Url : "+requestTranData.getWebAddress());
		System.out.println("Reply TranData : "+requestTranData.getTrandata());
		System.out.println("Reply Tranportal Id : "+requestTranData.getTranportalId());
		System.out.println("Reply Response Url : "+requestTranData.getResponseURL());
		System.out.println("Reply Error Url : "+requestTranData.getErrorURL());
	}

	
	private static void testRefundTransaction() throws Exception {

		String id = "ipay707336589914";
		String password = "Shopping@123";

		Request req = new Request();
		req.setMode("test");
		
		req.setId(id);
		req.setPassword(password);
		req.setCurrencycode("512");
		req.setAmt("100");
		req.setTransid("202513211360225");
		
	   
	   Reply reply = new OabIpayConnection().processSignedRefundByTranId(req);
		
		
	}

	private static void testSignedMerchantTransaction() throws Exception {

		System.out.println("Application.testSignedMerchantTransaction()");
		RequestTranData reqTranData = null;
		Request req = null;
		String id = "ipay707336589914";
		String password = "Shopping@123";
		String mode = "test";
		String currency = "512";
		String language = "EN";
		String receiptURL = "http://localhost:8080/merchantPlugin/shopping/merchanthostedvbvtcp/vbvTranPipeResult.jsp";
		String errorURL = "http://localhost:8080/merchantPlugin/shopping/merchanthostedvbvtcp/vbvTranPipeError.jsp";
		String udf1 = "Udf 1";
		String udf2 = "Udf 2";
		String udf3 = "Udf 3";
		String udf4 = "Udf 4";
		String udf5 = "Udf 5";
		String amount = "100";
		String trackid = "920384234";
		String action = "1";
		String tokenNo = null;
		String tokenFlag = null;
		
		String cardNo = "4761340000000019";
		String cardName = "SundareshKumar KV";
		String expMonth = "12";
		String expYear = "2030";
		String cvv2 = "123";

		req = new Request();
		req.setMode("test");
		
		req.setId(id);
		req.setPassword(password);
		req.setCurrencycode(currency);
		req.setLangid(language);
		req.setResponseURL(receiptURL);
		req.setErrorURL(errorURL);
		req.setAmt(amount);
		req.setTrackid(trackid);
		req.setUdf1(udf1);
		req.setUdf2(udf2);
		req.setUdf3(udf3);
		req.setUdf4(udf4);
		req.setUdf5(udf5);
		req.setTokenNo(tokenNo);
		req.setTokenFlag(tokenFlag);
		
//		req.setCardNo(cardNo);
//		req.setCardName(cardName);
//		req.setExpMonth(expMonth);
//		req.setExpYear(expYear);
//		req.setCvv2(cvv2);
		
		req.setWalletType("SP");

		req.setType("SP");
		
		req.setBrowserAcceptHeader("text/html,application/xhtml+xml,application/xml;q\u003d0.9,image/avif,image/webp,image/apng,*/*;q\u003d0.8,application/signed-exchange;v\u003db3;q\u003d0.7");
		req.setBrowserIP("148.64.17.32");
		req.setBrowserJavaEnabled(false);
		req.setBrowserJavascriptEnabled(false);
		req.setBrowserLanguage("en-GB");
		req.setBrowserColorDepth("24");
		req.setBrowserScreenHeight("800");
		req.setBrowserScreenWidth("1280");
		req.setBrowserTZ("-240");
		req.setBrowserUserAgent("Mozilla/5.0 \u0026 #40;Windows NT 10.0; Win64; x64\u0026 #41; AppleWebKit/537.36 \u0026 #40;KHTML, like Gecko\u0026 #41; Chrome/137.0.0.0 Safari/537.36");
	
//		req.setSplitPaymentIndicator("1");
		SplitPaymentPayload splitPayLoad = new SplitPaymentPayload();

		splitPayLoad.setAliasName("ROPCUSTOMS2022");
		splitPayLoad.setNotes("Salary");
		splitPayLoad.setType("1");
		splitPayLoad.setReference(String.valueOf(Math.abs(new Random().nextInt())));
		splitPayLoad.setSplitAmount("10");

//		req.addSplitPaymentPayload(splitPayLoad);

		if (tokenNo != null && tokenNo.isEmpty()) {
			req.setTokenNo(tokenNo);
			if ("1".equals(action)) {
				req.setTokenFlag("2");
			}
		}
		Reply reply = new OabIpayConnection().initiateSignedTransaction(req);
		System.out.println("Reply Payment Id : "+reply.getPaymentId());
		System.out.println("Reply Redirect Url : "+reply.getRedirectUrl());
	}

	public static void parseResponse() throws Exception {
		String tranData = "6593A06B027BD3D4177C4D1055317118D2CB3D0523746881E8029E5185E230D0C727434597A49722A0453533AD05A2B9E28134E015010AEBFF2A17F12991C0CDABE706A4F6A1D5FC0B99ADD8AAA0004D867B920B0244BD5201F2F1D9D2725E9E13ECB9A9C236D458E0D88B2AFADD39C93302FAB3C6B2BEDDBDD6D95734E6E4872F6944DBC695D89B0C06BA44AB4BB0F406FEF46210DDF959338C5D3580CDB46887A44BF6BF7991A373394C1C12334A13FFF3C0D1CF24D1AC400BF5A4171A1BE88C3C762E6FF86976384940DC42EE35FA1078196607F4335D98A0C1398DB918976280A54125006473B3B5964B92F6D8779E13DD632767FE15BCB7E0D05E288DC5";
		String resourcePath = "E:\\OAB_PROJECT\\pg\\oabresource\\uat-rop\\rop-uat-resource\\";
		String aliasName = "ROPCUSTOMS2022";

		ReplyTranData replyTranData = new ReplyTranData();
		replyTranData.setAlias(aliasName);
		replyTranData.setKeyPath(resourcePath);
		replyTranData.setTrandata(tranData);
		
		Reply reply = OabIpayReplyBuilder.prepareReply(replyTranData);
		System.out.println("Reply Payment Id : "+reply.getPaymentId());
		System.out.println("Reply Tran Url : "+reply.getTranId());
		System.out.println("Reply Result : "+reply.getResult());
		System.out.println("Reply auth : "+reply.getAuth());
		System.out.println("Reply Mrch Track Id : "+reply.getTrackId());
		System.out.println("Reply Ref : "+reply.getRef());
	}
	
	public static void parseSignedResponse() throws Exception {
		String tranData = "6593A06B027BD3D4177C4D1055317118D2CB3D0523746881E8029E5185E230D0C727434597A49722A0453533AD05A2B9E28134E015010AEBFF2A17F12991C0CDABE706A4F6A1D5FC0B99ADD8AAA0004D867B920B0244BD5201F2F1D9D2725E9E13ECB9A9C236D458E0D88B2AFADD39C93302FAB3C6B2BEDDBDD6D95734E6E4872F6944DBC695D89B0C06BA44AB4BB0F406FEF46210DDF959338C5D3580CDB46887A44BF6BF7991A373394C1C12334A13FFF3C0D1CF24D1AC400BF5A4171A1BE88C3C762E6FF86976384940DC42EE35FA1078196607F4335D98A0C1398DB918976280A54125006473B3B5964B92F6D8779E13DD632767FE15BCB7E0D05E288DC5";
		String signKey = "707360962352707360962352"; 
		
		ReplyTranData replyTranData = new ReplyTranData();
		replyTranData.setSignKey(signKey);
		replyTranData.setTrandata(tranData);
		
		Reply reply = OabIpayReplyBuilder.prepareSignedReply(replyTranData);
		System.out.println("Reply Payment Id : "+reply.getPaymentId());
		System.out.println("Reply Tran Url : "+reply.getTranId());
		System.out.println("Reply Result : "+reply.getResult());
		System.out.println("Reply auth : "+reply.getAuth());
		System.out.println("Reply Mrch Track Id : "+reply.getTrackId());
		System.out.println("Reply Ref : "+reply.getRef());
	}


	public static void testHostedTransaction() throws Exception {


		RequestTranData reqTranData = null;
		Request req = null;

		String resourcePath = "E:\\OAB_PROJECT\\pg\\oabresource\\uat-rop\\rop-uat-resource\\";
		String aliasName = "ROPCUSTOMS2022";
		String currency = "512";
		String language = "EN";
		String receiptURL = "https://certpayments.oabipay.com/";
		String errorURL = "https://certpayments.oabipay.com/";
		String udf1 = "Udf 1";
		String udf2 = "Udf 2";
		String udf3 = "Udf 3";
		String udf4 = "Udf 4";
		String udf5 = "Udf 5";
		String amount = "0.100";
		String trackid = "920384234";
		String action = "1";
		String tokenNo = null;
		String tokenFlag = null;

		req = new Request();
		req.setKeyPath(resourcePath);
		req.setAlias(aliasName);
		req.setCurrencycode(currency);
		req.setLangid(language);
		req.setResponseURL(receiptURL);
		req.setErrorURL(errorURL);
		req.setAmt(amount);
		req.setTrackid(trackid);
		req.setUdf1(udf1);
		req.setUdf2(udf2);
		req.setUdf3(udf3);
		req.setUdf4(udf4);
		req.setUdf5(udf5);
		req.setTokenNo(tokenNo);
		req.setTokenFlag(tokenFlag);

		req.setSplitPaymentIndicator("1");
		SplitPaymentPayload splitPayLoad = new SplitPaymentPayload();

		splitPayLoad.setAliasName("account001");
		splitPayLoad.setNotes("Salary");
		splitPayLoad.setType("1");
		splitPayLoad.setReference(String.valueOf(Math.abs(new Random().nextInt())));
		splitPayLoad.setSplitAmount("10");

		req.addSplitPaymentPayload(splitPayLoad);

		if (tokenNo != null && tokenNo.isEmpty()) {
			req.setTokenNo(tokenNo);
			if ("1".equals(action)) {
				req.setTokenFlag("2");
			}
		}
		reqTranData = OabIpayRequestBuilder.prepareRequestTranData(req);

	}
	
	public static void testMerchantTransaction() throws Exception {


		RequestTranData reqTranData = null;
		Request req = null;
		String resourcePath = "E:\\OAB_PROJECT\\pg\\oabresource\\uat-rop\\rop-uat-resource\\";
		String aliasName = "ROPCUSTOMS2022";
		String currency = "512";
		String language = "EN";
		String receiptURL = "http://localhost:8080/merchantPlugin/shopping/merchanthostedvbvtcp/vbvTranPipeResult.jsp";
		String errorURL = "http://localhost:8080/merchantPlugin/shopping/merchanthostedvbvtcp/vbvTranPipeError.jsp";
		String udf1 = "Udf 1";
		String udf2 = "Udf 2";
		String udf3 = "Udf 3";
		String udf4 = "Udf 4";
		String udf5 = "Udf 5";
		String amount = "100";
		String trackid = "920384234";
		String action = "1";
		String tokenNo = null;
		String tokenFlag = null;
		
		String cardNo = "4761340000000019";
		String cardName = "SundareshKumar KV";
		String expMonth = "12";
		String expYear = "2030";
		String cvv2 = "123";

		req = new Request();
		req.setKeyPath(resourcePath);
		req.setAlias(aliasName);
		req.setCurrencycode(currency);
		req.setLangid(language);
		req.setResponseURL(receiptURL);
		req.setErrorURL(errorURL);
		req.setAmt(amount);
		req.setTrackid(trackid);
		req.setUdf1(udf1);
		req.setUdf2(udf2);
		req.setUdf3(udf3);
		req.setUdf4(udf4);
		req.setUdf5(udf5);
		req.setTokenNo(tokenNo);
		req.setTokenFlag(tokenFlag);
		
		req.setType("AP");
		
		req.setBrowserAcceptHeader("text/html,application/xhtml+xml,application/xml;q\u003d0.9,image/avif,image/webp,image/apng,*/*;q\u003d0.8,application/signed-exchange;v\u003db3;q\u003d0.7");
		req.setBrowserIP("148.64.17.32");
		req.setBrowserJavaEnabled(false);
		req.setBrowserJavascriptEnabled(false);
		req.setBrowserLanguage("en-GB");
		req.setBrowserColorDepth("24");
		req.setBrowserScreenHeight("800");
		req.setBrowserScreenWidth("1280");
		req.setBrowserTZ("-240");
		req.setBrowserUserAgent("Mozilla/5.0 \u0026 #40;Windows NT 10.0; Win64; x64\u0026 #41; AppleWebKit/537.36 \u0026 #40;KHTML, like Gecko\u0026 #41; Chrome/137.0.0.0 Safari/537.36");
		
		
		req.setCardNo(cardNo);
		req.setCardName(cardName);
		req.setExpMonth(expMonth);
		req.setExpYear(expYear);
		req.setCvv2(cvv2);

		req.setSplitPaymentIndicator("1");
		SplitPaymentPayload splitPayLoad = new SplitPaymentPayload();

		splitPayLoad.setAliasName("ROPCUSTOMS2022");
		splitPayLoad.setNotes("Salary");
		splitPayLoad.setType("1");
		splitPayLoad.setReference(String.valueOf(Math.abs(new Random().nextInt())));
		splitPayLoad.setSplitAmount("10");

		req.addSplitPaymentPayload(splitPayLoad);

		if (tokenNo != null && tokenNo.isEmpty()) {
			req.setTokenNo(tokenNo);
			if ("1".equals(action)) {
				req.setTokenFlag("2");
			}
		}
		Reply reply = new OabIpayConnection().initiateTransaction(req);
		System.out.println("Reply Payment Id : "+reply.getPaymentId());
		System.out.println("Reply Redirect Url : "+reply.getRedirectUrl());
	}


	public static void show(String message) {
		System.out.println(message);
	}

}