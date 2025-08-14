<%@page import="com.oab.ipay.vo.SplitPaymentPayload"%>
<%@page import="com.oab.ipay.vo.RequestTranData"%>
<%@page import="com.oab.ipay.OabIpayRequestBuilder"%>
<%@page import="com.oab.ipay.vo.Request"%>
<%@page import="java.util.Properties"%>
<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<META name="GENERATOR" content="IBM WebSphere Studio">
	</head>
<%@ page language="java" session="true" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.io.*" %>
<%
	Request req = null;
	String webaddressUrl = null;
	File basePath = null;;
	Properties properties = null;
	FileInputStream inStream = null;
	File inputFile = null;
	String resourcePath = null;
	String aliasName = null;
	String currency = null;
	String language = null;
	String receiptURL = null;
	String errorURL = null;
	String udf1 = null;
	String udf2 = null;
	String udf4 = null;
	String udf5 = null;
	String tokenNo = null;
	String tokenFlag = null;
	String splitIndicator = null;
	
	String action = null;
 	String udf3 = null;
 	String paymentBy = null;
 	RequestTranData reqTranData = null;
		try {
	 		properties = new Properties();
	 		basePath = new File(pageContext.getServletContext().getRealPath("/"));
	 		inputFile = new File(basePath+"/shopping/bankhosted/", "hostHttpres.properties");
			inStream = new FileInputStream(inputFile);
			properties.load(inStream);
	
			resourcePath = properties.getProperty("keyPath");
			aliasName = properties.getProperty("aliasName");
			currency = "512";
			language = "USA";
			receiptURL = properties.getProperty("receiptURL");
			errorURL = properties.getProperty("errorURL");
			udf1 = request.getParameter("udf1");
			udf2 = request.getParameter("udf2");
			udf4 = request.getParameter("udf4");
			udf3 = request.getParameter("udf3");
			udf5 = request.getParameter("udf5");
			tokenNo = request.getParameter("tokenNo");
	
			splitIndicator = request.getParameter("splitIndicator");
			action = request.getParameter("action");
			String amount = request.getParameter("amount");
			try{
				amount = new DecimalFormat("###########.000").format(Double.parseDouble(request.getParameter("amount")));	
			}catch(Exception ex){
				amount = request.getParameter("amount");
			}
			Random rnd = new Random(System.currentTimeMillis());
			String trackid = request.getParameter("trackId");
			if(trackid == null || trackid.trim().isEmpty()){
				trackid = String.valueOf(Math.abs(rnd.nextInt()));
			}
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
			
			req.setSplitPaymentIndicator(splitIndicator);
			
			String splitCountStr = request.getParameter("splitCount");
			int splitCount = 0;
			try {
				splitCount = Integer.parseInt(splitCountStr);
			} catch (Exception e) {
				e.printStackTrace();
			}

			for (int i = 0; i < splitCount; i++) {
				String aliasNameParam = request.getParameter("splitAliasName" + i);
				String notesParam = request.getParameter("splitNotes" + i);
				String typeParam = request.getParameter("splitType" + i);
				String referenceParam = request.getParameter("splitReference" + i);
				String amountParam = request.getParameter("splitAmount" + i);

				// Optional: skip empty rows
				if ((aliasNameParam != null && !aliasNameParam.trim().isEmpty())
					|| (amountParam != null && !amountParam.trim().isEmpty())) {

					SplitPaymentPayload payload = new SplitPaymentPayload();
					payload.setAliasName(aliasNameParam);
					payload.setNotes(notesParam);
					payload.setType(typeParam);
					payload.setReference(referenceParam);
					payload.setSplitAmount(amountParam);
					req.addSplitPaymentPayload(payload);
				}
			}
			
			if (tokenNo != null && tokenNo.isEmpty()) {
				req.setTokenNo(tokenNo);
				if ("1".equals(action)) {
					req.setTokenFlag("2");
				}
			}
			reqTranData = OabIpayRequestBuilder.prepareRequestTranData(req);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
%>
<form action="<%=reqTranData.getWebAddress() %>" method="post">
	<table>
		<tr>
			<td><label for="id">Id:</label></td>
			<td><input type="text" id="tranportalId" name="tranportalId" value="<%= reqTranData.getTranportalId()%>" required></td>
		</tr>
		<tr>
			<td><label for="id">Response Url:</label></td>
			<td><input type="text" id="responseURL" name="responseURL" value="<%= reqTranData.getResponseURL()%>" required></td>
		</tr>
		<tr>
			<td><label for="id">Error Url:</label></td>
			<td><input type="text" id="errorURL" name="errorURL" value="<%= reqTranData.getErrorURL()%>" required></td>
		</tr>
		<tr>
			<td><label for="id">Tran Data:</label></td>
			<td><input type="text" id="trandata" name="trandata" value="<%= reqTranData.getTrandata()%>" required></td>
		</tr>
	
	</table>
	<button type="submit">Submit</button>
</form>
</html>