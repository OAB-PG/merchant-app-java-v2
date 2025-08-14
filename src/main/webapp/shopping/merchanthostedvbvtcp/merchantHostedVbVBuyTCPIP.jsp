	<%@page import="com.oab.ipay.OabIpayConnection"%>
<%@page import="com.oab.ipay.vo.Reply"%>
<%@page import="java.util.Random"%>
<%@page import="com.oab.ipay.vo.SplitPaymentPayload"%>
<%@page import="com.oab.ipay.vo.Request"%>
<%@page import="java.util.HashMap"%>
<html>
<%@ page language="java" session="true" %>
<%@page import="java.util.Properties"%>
<%@page import="java.io.*"%>
		<script type="text/javascript">
		function callSbmt()
		{
			document.mrchntfyform.submit();
			return false;
		}
		</script>

<%
	Properties properties = null;
	FileInputStream inStream = null;
	File inputFile = null;
	File basePath = null;
	HashMap<String, String> paramMap = null;
 	try {
 		properties = new Properties();
		basePath = new File(pageContext.getServletContext().getRealPath("/"));
		inputFile = new File(basePath+"/shopping/merchanthostedvbvtcp/", "tranportalvbvtcpip.properties");
		inStream = new FileInputStream(inputFile);
		properties.load(inStream);
	}catch (Exception e) {
		e.printStackTrace();
		properties = null;
	}finally{
 		try {
 			if(inStream!=null){
				inStream.close();
				inStream = null;
			}
			if (inputFile != null){
				inputFile = null;
			}
		}catch (Exception e) {
			properties = null;
		}
 	}

	String url = null;
	String currency = null;
	String resourcePath = null;
	String alaisName = null;
	String xmlData = null;
	String responceUrl = null;
	String errorUrl = null;
	String processUrl = null;
	resourcePath = properties.getProperty("keyPath");
	alaisName = properties.getProperty("aliasName");
	responceUrl = properties.getProperty("receiptURL");
	errorUrl = properties.getProperty("errorURL");
	
	String tokenFlg = request.getParameter("mrchHstVbvtokenFlag");
	String tokenNo = request.getParameter("mrchHstVbvtokenNumber");
	
	Request req = null;
	req = new Request();
	int result = 0;
	req.setMode("test");
	
	req.setCurrencycode("512");
	req.setLangid("en");
	req.setResponseURL(responceUrl);
	req.setErrorURL(errorUrl);
	req.setAlias(alaisName);
	req.setKeyPath(resourcePath);
	req.setAmt(request.getParameter("amount"));
	req.setTrackid(request.getParameter("trckId"));
	req.setUdf1(request.getParameter("udf1"));
	req.setUdf2(request.getParameter("udf2"));
	req.setUdf3(request.getParameter("udf3"));
	req.setUdf4(request.getParameter("udf4"));
	req.setUdf5(request.getParameter("udf5"));
	req.setTokenNo(tokenNo);
	req.setTokenFlag(tokenFlg);
	
	req.setCardNo(request.getParameter("cardNumber"));
	req.setCardName(request.getParameter("name"));
	req.setExpMonth(request.getParameter("expmm"));
	req.setExpYear(request.getParameter("expyy"));
	req.setCvv2(request.getParameter("cvv"));
	

	req.setType(request.getParameter("transacType"));
	
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

//	req.setSplitPaymentIndicator("1");
	SplitPaymentPayload splitPayLoad = new SplitPaymentPayload();

	splitPayLoad.setAliasName("ROPCUSTOMS2022");
	splitPayLoad.setNotes("Salary");
	splitPayLoad.setType("1");
	splitPayLoad.setReference(String.valueOf(Math.abs(new Random().nextInt())));
	splitPayLoad.setSplitAmount("10");

//	req.addSplitPaymentPayload(splitPayLoad);

	if (tokenFlg != null && tokenFlg.equals("2") && tokenNo != null && tokenNo.isEmpty()) {
		req.setTokenNo(tokenNo);
	}
	Reply reply = new OabIpayConnection().initiateTransaction(req);
	url = reply.getRedirectUrl();
		
%>	
		<body onload="callSbmt()">
			<form action="<%=url %>" name="mrchntfyform" method="post">
				
			</form>
		</body>
	</html>



