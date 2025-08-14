<%@ page language="java" session="true" %>
<%@page import="java.util.Properties"%>
<%@page import="java.io.*"%>
		<script type="text/javascript">
		function callSbmt1()
		{
			debugger;
			document.mrchntfyhttpform.submit();
			return false;
		}
		</script>
<%
	Properties properties = null;
	FileInputStream inStream = null;
	File inputFile = null;
	File basePath = null;
 	try {
 		properties = new Properties();
		basePath = new File(pageContext.getServletContext().getRealPath("/"));
		inputFile = new File(basePath+"/shopping/merchanthostedvbv/", "tranportalvbvhttp.properties");
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
	if(properties != null){
		currency = properties.getProperty("currency");
		resourcePath = properties.getProperty("resourcePath");
		alaisName = properties.getProperty("aliasName");
		xmlData = properties.getProperty("xmlData");
		responceUrl = properties.getProperty("receiptURL");
		errorUrl = properties.getProperty("errorURL");
		processUrl = properties.getProperty("processUrl");
 	}
	iPayOabPipe pipe = new iPayOabPipe();
	int result = 0;
	pipe.setAlias(alaisName);
	pipe.setResourcePath(resourcePath);
	pipe.setKeystorePath(resourcePath);
	pipe.setAmt(request.getParameter("amount"));
	pipe.setCurrency(currency);
	pipe.setMember(request.getParameter("name"));
	pipe.setAction(request.getParameter("action"));
	pipe.setTrackId(request.getParameter("trckId"));
	pipe.setCvv2(request.getParameter("cvv"));
	pipe.setExpMonth(request.getParameter("expmm"));
	pipe.setExpYear(request.getParameter("expyy"));
	pipe.setCard(request.getParameter("cardNumber"));
	pipe.setUdf1(request.getParameter("udf1"));
	pipe.setUdf2(request.getParameter("udf2"));
	pipe.setUdf3(request.getParameter("udf3"));
	pipe.setUdf4(request.getParameter("udf4"));
	pipe.setUdf5(request.getParameter("udf5"));
	pipe.setBrowserAcceptHeader("text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8");
	pipe.setBrowserIP("91.74.99.114");
	pipe.setBrowserJavaEnabled(false);
	pipe.setBrowserJavascriptEnabled(true);
	pipe.setBrowserLanguage("en-US");
	pipe.setBrowserColorDepth("24");
	pipe.setBrowserScreenHeight("864");
	pipe.setBrowserScreenWidth("1536");
	pipe.setBrowserTZ("-240");
	pipe.setBrowserUserAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36");
	pipe.setDevice("web");
	
	/* pipe.setType(request.getParameter("transacType")); */
	if(request.getParameter("mrchHstVbvtokenFlag") != null && !request.getParameter("mrchHstVbvtokenFlag").trim().isEmpty()){
		pipe.setTokenFlag(request.getParameter("mrchHstVbvtokenFlag"));	
	}
	if(request.getParameter("mrchHstVbvtokenNumber") != null && !request.getParameter("mrchHstVbvtokenNumber").trim().isEmpty()){
		pipe.setTokenNumber(request.getParameter("mrchHstVbvtokenNumber"));
	}
	pipe.setResponseURL(responceUrl);
	pipe.setErrorURL(errorUrl);
	result = pipe.performVbVTransaction(xmlData); 
	if(result != 0) {
		url = errorUrl+pipe.getError();
	} else {
		url = pipe.getWebAddressUrl();
	}
	//response.sendRedirect(url);
%>

		<body onload="callSbmt1()">
			<form action="<%=url %>" name="mrchntfyhttpform" method="post">
				<input type="hidden" value="<%= pipe.getTrandata() %>" name="trandata" />
				<input type="hidden" value="<%= pipe.getId() %>" name="tranportalId" />
				<input type="hidden" value="<%= pipe.getResponseURL() %>" name="responseURL" />
				<input type="hidden" value="<%= pipe.getErrorURL() %>" name="errorURL" />
			</form>
		</body>
