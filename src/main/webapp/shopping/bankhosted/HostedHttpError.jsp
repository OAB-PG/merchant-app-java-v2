
<%@page import="com.oab.ipay.vo.ReplyTranData"%>
<%@page import="com.oab.ipay.vo.Reply"%>
<%@page import="com.oab.ipay.OabIpayReplyBuilder"%>
<%@page import="com.oab.ipay.vo.Request"%>
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
		int result =-1;
		Reply reply = null;
		try {
			properties = new Properties();
		 	basePath = new File(pageContext.getServletContext().getRealPath("/"));
		 	inputFile = new File(basePath+"/shopping/bankhosted/", "hostHttpres.properties");
			inStream = new FileInputStream(inputFile);
			properties.load(inStream);
			
			String replyTranData = request.getParameter("trandata");
			String trackId = request.getParameter("trackId");
			
			ReplyTranData tranData = new ReplyTranData();

			keyPath = properties.getProperty("keyPath");
			aliasName = properties.getProperty("aliasName");
			tranData.setKeyPath(keyPath);
			tranData.setAlias(aliasName);
			
			tranData.setTrandata(replyTranData);
			tranData.setTrackId(trackId);
			reply = OabIpayReplyBuilder.prepareReply(tranData);
			
		}catch(Exception e){
				
		}finally{
			basePath = null;;
			properties = null;
			inStream = null;
			inputFile = null;
	 		xmlData = null;
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
        	<table>
				<tr>
					<td>
						<table align="center">
							<tr>
								<td colspan="2" align="center">
									<h2><B>Transaction Details   </B></h2>
								</td>
							</tr>
								<%if(isNotNullOrEmpty(request.getParameter("ErrorText"))){%>
								<tr>	
									<td>Request Error Text</td> <td> &nbsp;&nbsp;<b><font size="2" color="red"><%=request.getParameter("ErrorText")%></font></b></td>
								</tr>
								<% }if(isNotNullOrEmpty(reply.getError())){%>
								<tr>	
									<td>Error</td> <td> &nbsp;&nbsp;<b><font size="2" color="red"><%=reply.getError()%></font></b></td>
								</tr>
								<% }if(isNotNullOrEmpty(reply.getErrorText())){ %>	
								<tr>	
									<td>Error Text</td> <td> &nbsp;&nbsp;<b><font size="2" color="red"><%=reply.getErrorText()%></font></b></td>
								</tr>
								<% } if(isNotNullOrEmpty(reply.getResult())) {%>
								<tr>
									<td>Transaction Status</td><td> &nbsp;&nbsp;<b><font size="2" color="red"><%=reply.getResult()%></font></b></td>
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