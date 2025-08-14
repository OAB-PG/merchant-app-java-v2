<%@page import="java.io.File"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.fss.plugin.iPayOabPipe"%>
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
		iPayOabPipe pipe = null; 
		File basePath = null;;
		Properties properties = null;
		FileInputStream inStream = null;
		File inputFile = null;
 		String resourcePath = null;
		String aliasName = null;
	 	String xmlData = null;
	 	int result = 0;
		try {
	 		properties = new Properties();
	 		basePath = new File(pageContext.getServletContext().getRealPath("/"));
	 		inputFile = new File(basePath+"/shopping/merchanthostedvbv/", "tranportalvbvhttp.properties");
			inStream = new FileInputStream(inputFile);
			properties.load(inStream);
			resourcePath = properties.getProperty("resourcePath");
			aliasName = properties.getProperty("aliasName");
			xmlData = properties.getProperty("xmlData");
			pipe = new iPayOabPipe();
			pipe.setKeystorePath(resourcePath);
			pipe.setAlias(aliasName);
			pipe.setResourcePath(resourcePath);
			result = pipe.parseEncryptedResult(request.getParameter("trandata"),xmlData);

			
		}catch(Exception ex){
		}finally{
			basePath = null;;
			properties = null;
			inStream = null;
			inputFile = null;
 			resourcePath = null;
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
	<body class="bg" >
        <div class="wrap" id="detect-iframe">
			<form name="formACS" id="formACS" action="<%=request.getContextPath() %>/" method="POST" target="_parent">
			
        	<input type="hidden" value="<%=request.getParameter("trandata") %>" name="trandata" id="trandata">
        	<input type="hidden" value="<%=xmlData.replaceAll("\"", ":::") %>" name="xmlData" id="xmlData">
        	<input type="hidden" value="<%=request.getParameter("error") %>" name="error" id="error">
        	<input type="hidden" value="<%=request.getParameter("Error_text") %>" name="error_text" id="error_text">
			
        	<table  <%
        			if(("APPROVED".equalsIgnoreCase(pipe.getResult()) || "CAPTURED".equalsIgnoreCase(pipe.getResult()) || "SUCCESS".equalsIgnoreCase(pipe.getResult())  || "REGISTERED".equalsIgnoreCase(pipe.getResult()))){
        			
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
									<td>Return Result </td><td>&nbsp;&nbsp;<%=result%></td>
								</tr>

								<tr>
									<td>Request Track Id </td><td>&nbsp;&nbsp;<%=request.getParameter("trackId")%></td>
								</tr>

								<%if(isNotNullOrEmpty(request.getParameter("ErrorText"))){%>
								<tr>	
									<td>Request Error Text</td> <td> &nbsp;&nbsp;<b><font size="2" color="red"><%=request.getParameter("ErrorText")%></font></b></td>
								</tr>
								<% }if(isNotNullOrEmpty(pipe.getError())){%>
								<tr>	
									<td>Error</td> <td> &nbsp;&nbsp;<b><font size="2" color="red"><%=pipe.getError()%></font></b></td>
								</tr>
								<% }if(isNotNullOrEmpty(pipe.getError_text())){ %>	
								<tr>	
									<td>Error Text</td> <td> &nbsp;&nbsp;<b><font size="2" color="red"><%=pipe.getError_text()%></font></b></td>
								</tr>
								<% } if(isNotNullOrEmpty(pipe.getResult())) {%>
								<tr>
									<td>Transaction Status</td><td> &nbsp;&nbsp;<b><font size="2" color="red"><%=pipe.getResult()%></font></b></td>
								</tr>
								<%  }if(isNotNullOrEmpty(pipe.getDate())){%>
								<tr>
									<td>Post Date</td><td> &nbsp;&nbsp;<%=pipe.getDate()%></td>
								</tr>
								<%  } if(isNotNullOrEmpty(pipe.getRef())){%>
								<tr>
									<td>Transaction Reference ID</td><td>&nbsp;&nbsp;<%=pipe.getRef()%></td>
								</tr>
								<%  } if(isNotNullOrEmpty(pipe.getAuth())){%>
								<tr>
									<td>Auth Code</td><td>&nbsp;&nbsp;<%=pipe.getAuth()%></td>
								</tr>
								<%  } if(isNotNullOrEmpty(pipe.getTrackId())){%>
								<tr>
									<td>Track ID</td><td>&nbsp;&nbsp;<%=pipe.getTrackId()%></td>
								</tr>
								<%  } if(isNotNullOrEmpty(pipe.getTransId())){%>
								<tr>
									<td><b>Transaction ID</b></td><td>&nbsp;&nbsp;<%=pipe.getTransId()%></td>
								</tr>
								<%  } if(isNotNullOrEmpty(pipe.getAmt())){%>
								<tr>
									<td>Transaction Amount</td><td>&nbsp;&nbsp;<%=pipe.getAmt()%></td>
								</tr>
								<%  } if(isNotNullOrEmpty(pipe.getUdf1())){%>
								<tr>
									<td>UDF1</td><td>&nbsp;&nbsp;<%=pipe.getUdf1()%></td>
								</tr>
								<%  }  if(isNotNullOrEmpty(pipe.getUdf2())){%>
								<tr>
									<td>UDF2</td><td>&nbsp;&nbsp;<%=pipe.getUdf2()%></td>
								</tr>
								<%  }  if(isNotNullOrEmpty(pipe.getUdf3())){%>
								<tr>
									<td>UDF3</td><td>&nbsp;&nbsp;<%=pipe.getUdf3()%></td>
								</tr>
								<%  }  if(isNotNullOrEmpty(pipe.getUdf4())){%>
								<tr>
									<td>UDF4</td><td>&nbsp;&nbsp;<%=pipe.getUdf4()%></td>
								</tr>
								<%  }  if(isNotNullOrEmpty(pipe.getUdf5())){%>
								<tr>
									<td>UDF5</td><td>&nbsp;&nbsp;<%=pipe.getUdf5()%></td>
								</tr>
								<%  } if(isNotNullOrEmpty(pipe.getPaymentId())){%>
								<tr>
									<td>Payment ID</td><td>&nbsp;&nbsp;<%=pipe.getPaymentId()%></td>
								</tr>
								<%  } if(isNotNullOrEmpty(pipe.getCustid())){%>
								<tr>
									<td>Customer Id</td><td>&nbsp;&nbsp;<%=pipe.getCustid()%></td>
								</tr>
								<%  } if(isNotNullOrEmpty(pipe.getTokenCustomerId())){%>
								<tr>
									<td>Customer Id(getTokenCustomerId)</td><td>&nbsp;&nbsp;<%=pipe.getTokenCustomerId()%></td>
								</tr>
								<%  }%>
							</table>
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