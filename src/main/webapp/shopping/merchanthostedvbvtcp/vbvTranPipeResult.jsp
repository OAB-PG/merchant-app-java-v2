<%@page import="com.oab.ipay.vo.SplitPaymentPayload"%>
<%@page import="java.util.List"%>
<%@page import="com.oab.ipay.vo.Reply"%>
<%@page import="com.oab.ipay.vo.ReplyTranData"%>
<%@page import="com.oab.ipay.OabIpayReplyBuilder"%>
<%@page import="com.oab.ipay.vo.Request"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Properties"%>
<html>
	<head>
    	<link href="../../css/payments-inter.css" rel="stylesheet" type="text/css">
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
		    .mer-logo-wrap > img {
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
			.success-info font{
				color: green;
			}
			.failure-info font{
				color: red;
			}
		</style>
		
		<%
		File basePath = null;
		Properties properties = null;
		FileInputStream inStream = null;
		File inputFile = null;
		String keyPath = null;
	 	String xmlData = null;
	 	String aliasName = null;
		Reply reply = null;
		try {
			properties = new Properties();
		 	basePath = new File(pageContext.getServletContext().getRealPath("/"));
		 	inputFile = new File(basePath+"/shopping/merchanthostedvbvtcp/", "tranportalvbvtcpip.properties");
			inStream = new FileInputStream(inputFile);
			properties.load(inStream);
			keyPath = properties.getProperty("keyPath");
			aliasName = properties.getProperty("aliasName");
			for(String value : request.getParameterMap().keySet()){
				System.out.print(value);
			}
			String replyTranData = request.getParameter("trandata");
			String trackId = request.getParameter("trackId");
			
			ReplyTranData tranData = new ReplyTranData();
			tranData.setKeyPath(keyPath);
			tranData.setAlias(aliasName);
			tranData.setTrandata(replyTranData);
			tranData.setTrackId(trackId);
			reply = OabIpayReplyBuilder.prepareReply(tranData);			
		}catch(Exception e){
				throw e;
		}finally{
			basePath = null;;
			properties = null;
			inStream = null;
			inputFile = null;
	 		aliasName = null;
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
	</head>
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
								<tr>
									<td>Merchant Track Id </td><td>&nbsp;&nbsp;<%=request.getParameter("trackId")%></td>
								</tr>
								<% if(isNotNullOrEmpty(reply.getResult())) {%>
								<tr>
									<td>Transaction Status</td><td> &nbsp;&nbsp;<b><font size="2" color="red"><%=reply.getResult()%></font></b></td>
								</tr>
								<%  } if(isNotNullOrEmpty(reply.getError())) {%>
								<tr>
									<td>Error </td><td> &nbsp;&nbsp;<b><font size="2" color="red"><%=reply.getError()%></font></b></td>
								</tr>
								<%  } if(isNotNullOrEmpty(reply.getErrorText())) {%>
								<tr>
									<td>ErrorText</td><td> &nbsp;&nbsp;<b><font size="2" color="red"><%=reply.getErrorText()%></font></b></td>
								</tr>
								<%  } if(isNotNullOrEmpty(reply.getDate())){%>
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