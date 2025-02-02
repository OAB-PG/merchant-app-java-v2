<%@page import="com.oab.ipay.vo.SplitPaymentPayload"%>
<%@page import="java.util.List"%>
<%@page import="com.oab.ipay.vo.Reply"%>
<%@page import="com.oab.ipay.OabIpayConnection"%>
<%@page import="com.oab.ipay.vo.Request"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.Random"%>
<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD html 4.01 Transitional//EN">
<html>
<head>
<META name="GENERATOR" content="IBM WebSphere Studio">
<LINK href="<%=request.getContextPath()%>/css/main.css" type=text/css
	rel=stylesheet>
<TITLE>Merchant Hosted Service OAB Transaction</TITLE>
<link href="../../css/payments-inter.css" rel="stylesheet"
	type="text/css">
<style>
.clr {
	overflow: hidden;
}

.mer-logo-wrap {
	text-align: left;
	padding-left: 35px;
}

.header-table {
	width: 100%;
}

.header-table td {
	vertical-align: middle;
	width: 49.9%;
}

.mer-logo-wrap>img {
	max-height: 75px;
}

.payz-logo-wrap {
	text-align: right;
	padding-right: 35px;
}

.norm-hd {
	padding: 15px 0;
	position: relative;
	z-index: 1000;
	border-bottom: 1px solid #e5e5e5;
}

.success-info {
	background: none repeat scroll 0 0 #dff2de;
	border: 2px solid #468847;
	color: #B94A48;
}

.success-info font {
	color: green;
}

.failure-info font {
	color: red;
}
</style>

</HEAD>
<%@ page language="java" session="true"%>
<%!
	public boolean validateParamenters(String... val){
		try{
			for(String v : val){
				if(v != null && !v.trim().isEmpty() && !("null").equals(v.trim())){
					continue;
				}else{
					return false;
				}
			}
		}catch(Exception ex){
			return false;
		}
		return true;
	}
	%>


<%
		int inquiryres = 0;
		Request req = null; 
		File basePath = null;;
		Properties properties = null;
		FileInputStream inStream = null;
		File inputFile = null;
 		String keyPath = null;
		String aliasName = null;
		String currency = null;
		String language = null;
		String receiptURL = null;
		String errorURL = null;
		String udf5 = null;
	 	String actionBy = null;
		String amount = null;
		String action = null;
		String inquiryTrackId = null;
		String transid = null;
		String splitTranId = null;
		String splitAmount = null;
		Reply reply = null;
			try {
		 		properties = new Properties();
		 		basePath = new File(pageContext.getServletContext().getRealPath("/"));
		 		inputFile = new File(basePath+"/shopping/merchanthostedoabservice/", "tranportalservice.properties");
				inStream = new FileInputStream(inputFile);
				properties.load(inStream);
				keyPath = properties.getProperty("keyPath");
				aliasName = properties.getProperty("aliasName");
				currency = "512";
				receiptURL = properties.getProperty("receiptURL");
				errorURL = properties.getProperty("errorURL");
				language = "EN";
				actionBy = request.getParameter("actionBy");
				action = request.getParameter("action");
				amount = request.getParameter("amount");
				inquiryTrackId = request.getParameter("trckId");
				transid = request.getParameter("transid");
				String price = request.getParameter("amount");
				if(price != null && !price.trim().isEmpty()){
					double pr = Double.parseDouble(price);
					amount = new DecimalFormat("###############.000").format(pr);
				}
				splitTranId = request.getParameter("splitTranId");
				splitAmount = request.getParameter("splitAmount");
				
				req = new Request();
				req.setAlias(aliasName);
				req.setKeyPath(keyPath);
				req.setCurrencycode(currency);
				if(action.equals("INQUIRY")){
					req.setAmt(amount);
					req.setTransid(transid);
					if(actionBy.equals("TRACKID")){
						reply = new OabIpayConnection().processInquiryByTrackId(req);
					} else if (actionBy.equals("PAYMENTID")){
						reply = new OabIpayConnection().processInquiryByPaymentId(req);
					} else if (actionBy.equals("TRANID")){
						reply = new OabIpayConnection().processInquiryByTranId(req);
					} else if (actionBy.equals("REFNO")){
						reply = new OabIpayConnection().processInquiryByRefNo(req);
					}
				} else if (action.equals("VOID")){
					req.setAmt(amount);
					req.setTransid(transid);
					if(actionBy.equals("TRACKID")){
						reply = new OabIpayConnection().processReversalByTrackId(req);
					} else if (actionBy.equals("TRANID")){
						reply = new OabIpayConnection().processReversalByTranId(req);
					}
				} else if (action.equals("REFUND")){
					req.setAmt(amount);
					req.setTransid(transid);
					
					req.setSplitPaymentIndicator("1");
					SplitPaymentPayload splitPaymentPayload = new SplitPaymentPayload();
					splitPaymentPayload.setSplitTranId(splitTranId);
					splitPaymentPayload.setNotes("Refund");
					splitPaymentPayload.setReference(String.valueOf(Calendar.getInstance().getTimeInMillis()));
					splitPaymentPayload.setSplitAmount(splitAmount);
					
					req.addSplitPaymentPayload(splitPaymentPayload);
					
					reply = new OabIpayConnection().processRefundByTranId(req);
				}
				
				}catch(Exception e){
					
				}finally{
					properties = null;
				}
				

%>
<%!
		
		public boolean isNotNullOrEmpty(String value){
			if(value != null && !value.isEmpty()){
				return true;
			}else{
				return false;	
			}
		}
		
		
		%>
	<body>
        <div class="wrap" id="detect-iframe">
			       <form name="formACS" id="formACS" action="<%=request.getContextPath() %>/" method="POST" target="_parent">
        			<table  <%
        			if(("APPROVED".equalsIgnoreCase(reply.getResult()) || "CAPTURED".equalsIgnoreCase(reply.getResult()) || "SUCCESS".equalsIgnoreCase(reply.getResult())  || "REGISTERED".equalsIgnoreCase(reply.getResult()))){
        			%>
        			class="info success-info"
        		 	<% 
        		 	} else { 
        		 	%> 
        		 	class="info failure-info" <% 
        		 	} 
        		 	%> >
				<tr>
					<td>
						<table align="center">
							<tr>
								<td colspan="2" align="center">
									<h2><B>Transaction Details   </B></h2>
								</td>
							</tr>
								<% if(isNotNullOrEmpty(reply.getResult())) {%>
								<tr>
									<td>Transaction Status</td><td> &nbsp;&nbsp;<b><font size="2" color="red"><%=reply.getResult()%></font></b></td>
								</tr>
								<%  }if(isNotNullOrEmpty(reply.getDate())){%>
								<tr>
									<td>Post Date</td><td> &nbsp;&nbsp;<%=reply.getDate()%></td>
								</tr>
								<%  } if(isNotNullOrEmpty(reply.getRef())){%>
								<tr>
									<td>Transaction Reference ID</td><td>&nbsp;&nbsp;<%=reply.getRef()%></td>
								</tr>
								<%  } if(isNotNullOrEmpty(reply.getAuth())){%>
								<tr>
									<td>Auth Code</td><td>&nbsp;&nbsp;<%=reply.getAuth()%></td>
								</tr>
								<%  } if(isNotNullOrEmpty(reply.getTrackId())){%>
								<tr>
									<td>Track ID</td><td>&nbsp;&nbsp;<%=reply.getTrackId()%></td>
								</tr>
								<%  } if(isNotNullOrEmpty(reply.getTranId())){%>
								<tr>
									<td><b>Transaction ID</b></td><td>&nbsp;&nbsp;<%=reply.getTranId()%></td>
								</tr>
								<%  } if(isNotNullOrEmpty(reply.getAmt())){%>
								<tr>
									<td>Transaction Amount</td><td>&nbsp;&nbsp;<%=reply.getAmt()%></td>
								</tr>
								<%  } if(isNotNullOrEmpty(reply.getUdf1())){%>
								<tr>
									<td>UDF1</td><td>&nbsp;&nbsp;<%=reply.getUdf1()%></td>
								</tr>
								<%  }  if(isNotNullOrEmpty(reply.getUdf2())){%>
								<tr>
									<td>UDF2</td><td>&nbsp;&nbsp;<%=reply.getUdf2()%></td>
								</tr>
								<%  }  if(isNotNullOrEmpty(reply.getUdf3())){%>
								<tr>
									<td>UDF3</td><td>&nbsp;&nbsp;<%=reply.getUdf3()%></td>
								</tr>
								<%  }  if(isNotNullOrEmpty(reply.getUdf4())){%>
								<tr>
									<td>UDF4</td><td>&nbsp;&nbsp;<%=reply.getUdf4()%></td>
								</tr>
								<%  }  if(isNotNullOrEmpty(reply.getUdf5())){%>
								<tr>
									<td>UDF5</td><td>&nbsp;&nbsp;<%=reply.getUdf5()%></td>
								</tr>
								<%  } if(isNotNullOrEmpty(reply.getPaymentId())){%>
								<tr>
									<td>Payment ID</td><td>&nbsp;&nbsp;<%=reply.getPaymentId()%></td>
								</tr>
								<%  } if(isNotNullOrEmpty(reply.getTokenNo())){%>
								<tr>
									<td>Customer Id(Token Number)</td><td>&nbsp;&nbsp;<%=reply.getTokenNo()%></td>
								</tr>
								<%  } if(isNotNullOrEmpty(reply.getTranDate())){%>
								<tr>
									<td> TranDate </td><td>&nbsp;&nbsp;<%= reply.getTranDate() %></td>
								</tr>
								<%  } if(isNotNullOrEmpty(reply.getTranRequestDate())){%>
								<tr>
									<td>TranRequestDate </td><td>&nbsp;&nbsp;<%=reply.getTranRequestDate() %></td>
								</tr>
								<%  } if(isNotNullOrEmpty(reply.getTranResponseDate())){%>
								<tr>
									<td>TranResponseDate</td><td>&nbsp;&nbsp;<%=reply.getTranResponseDate() %></td>
								</tr>
								<%  }%>
								
							</table>
							
							<% 
							
							List<SplitPaymentPayload> splits = reply.getSplitPaymentPayload();
							int count = splits == null ? 0 : splits.size();
							
							for(int i = 0; i < count; i++){ %>
							
							<table align="center">
							<tr>
								<td colspan="2" align="center">
									<h2><B>Split Transaction Details   </B></h2>
								</td>
							</tr>
								<% if(isNotNullOrEmpty(splits.get(i).getReference())) {%>
								<tr>
									<td>Reference No</td><td> &nbsp;&nbsp;<b><font size="2" color="red"><%=splits.get(i).getReference()%></font></b></td>
								</tr>
								<%  }if(isNotNullOrEmpty(splits.get(i).getAliasName())){%>
								<tr>
									<td>Alias Name</td><td> &nbsp;&nbsp;<%=splits.get(i).getAliasName()%></td>
								</tr>
								<%  } if(isNotNullOrEmpty(splits.get(i).getSplitTranId())){%>
								<tr>
									<td>Transaction ID</td><td>&nbsp;&nbsp;<%=splits.get(i).getSplitTranId()%></td>
								</tr>
								<%  } if(isNotNullOrEmpty(splits.get(i).getNotes())){%>
								<tr>
									<td>Notes</td><td>&nbsp;&nbsp;<%=splits.get(i).getNotes()%></td>
								</tr>
								<%  } if(isNotNullOrEmpty(splits.get(i).getSplitAmount())){%>
								<tr>
									<td>Split Amount</td><td>&nbsp;&nbsp;<%=splits.get(i).getSplitAmount()%></td>
								</tr>
								<%  }%>
								
							</table>
							
							<% } %>
						</td>
					</tr>
				</table>
			<br>
        </form>
            <p class="no-re-warn return-flkp succ"><a class="btn btn-danger" onclick="document.getElementById('formACS').submit();" target="_parent">Click here</a> for go to Home page </p>
        </div>
        <script>
            if (!(self === window.top)) {
                var el = document.getElementById('detect-iframe');
                if (el) {
                    el.className += ' iframe';
                }
            }
        </script>
	</body>
</html>