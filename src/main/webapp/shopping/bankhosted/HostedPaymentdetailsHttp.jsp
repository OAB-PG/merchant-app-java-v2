<!DOCTYPE html PUBLIC "-//W3C//DTD html 4.01 Transitional//EN">
<%@page import="java.util.Random"%>
<%@ page language="java" session="true" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.io.*" %>
	<head>
		<%
			Random rnd = new Random(System.currentTimeMillis());
			String trackid = String.valueOf(Math.abs(rnd.nextInt()));
		%>
		<title>Bank Hosted Transaction</title>
		<script type="text/javascript">
		
		function fnClickProcessTransaction(){
			document.bankHostedTransaction.submit();
		}

		function fnChangeRequiredField(value){
			if(value == 1 || value == 4 || value == 11 || value == 12){
				document.getElementById("tokenNumbertrId").style.display = "";
			}else{
				document.getElementById("tokenNumbertrId").style.display = "none";
			}
			if(value == 11 || value == 12){
				document.getElementById("amountTrId").style.display = "none";
			}else{
				document.getElementById("amountTrId").style.display = "";
			}
			if(value == 8){
				document.getElementById("originalTransId").style.display = "";
			}else{
				document.getElementById("originalTransId").style.display = "none";
			}
		}
		
		</script>
	</head>
<div class="container">
	<div class="panel panel-default">
		<div class="panel-body">
			<form name="bankHostedTransaction" id="bankHostedTransaction" action="shopping/bankhosted/HostedPaymentBuyHttp.jsp" method="post">

				<div class="form-group row">
					<label for="ActionLbl" class="col-sm-3 col-form-label">Payment By</label>
					<div class="col-sm-3">
						<select class="form-control" id="bnkHstPaymentInstrument" name="paymentInstrument">
							<option selected="selected" value="CREDIT">Credit Card</option>
							<option value="DEBIT">Debit card</option>
						</select>
					</div>
				</div>

				<div class="form-group row">
					<label for="ActionLbl" class="col-sm-3 col-form-label">Action</label>
					<div class="col-sm-3">
						<select class="form-control" id="bnkHstaction"  name="action" onchange="fnChangeRequiredField(this.value);">
							<option selected="selected" value="1">Purchase</option>
							<option value="4">Authorize</option>
							<option value="11">Token Registration</option>
							<option value="12">Token De-Registration</option>
							<option value="8">Inquiry</option>
						</select>
					</div>
				</div>
			
				<div id="amountTrId" class="form-group row">
					<label for="ActionLbl" class="col-sm-3 col-form-label">Amount</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" id="bnkHstamount" size="20" name="amount" value="10" />
					</div>
				</div>
			
				<div id="originalTransId" style="display: none;" class="form-group row">
					<label for="ActionLbl" class="col-sm-3 col-form-label">Original Transaction Id</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" id="bnkHsttransId" size="20" name="transId" value="" />
					</div>
				</div>
			
				<div id="tokenNumbertrId" class="form-group row">
					<label for="ActionLbl" class="col-sm-3 col-form-label">Token Number</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="bnkHsttokenNumber" name="tokenNumber" value="" />
					</div>
				</div>

				<div class="form-group row">
					<label for="udf1Lbl" class="col-sm-3 col-form-label">Udf 1</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="bnkHstudf1" name="udf1" value="udf1 Live Testing Kindly Ignore" />
					</div>
				</div>
							
				<div class="form-group row">
					<label for="udf1Lbl" class="col-sm-3 col-form-label">Udf 2</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="bnkHstudf2" name="udf2" value="udf2 Live Testing Kindly Ignore" />
					</div>
				</div>


				<div class="form-group row">
					<label for="udf1Lbl" class="col-sm-3 col-form-label">Udf 3</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="bnkHstudf3" name="udf3" value="udf3 Live Testing Kindly Ignore" />
					</div>
				</div>


				<div class="form-group row">
					<label for="udf1Lbl" class="col-sm-3 col-form-label">Udf 4</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="bnkHstudf4" name="udf4" value="udf4 Live Testing Kindly Ignore" />
					</div>
				</div>


				<div class="form-group row">
					<label for="udf1Lbl" class="col-sm-3 col-form-label">Udf 5</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" id="bnkHstudf5" size="20" name="udf5" value="udf5 Live Testing Kindly Ignore" />
					</div>
				</div>


				<div class="form-group row">
					<label for="udf1Lbl" class="col-sm-3 col-form-label">Udf 6</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" id="bnkHstudf6" size="20" name="udf6" value="udf666666666666666666666666666666666666666666666666666" />
					</div>
				</div>
				
				
				<div class="form-group row">
					<label for="udf1Lbl" class="col-sm-3 col-form-label">Udf 7</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" id="bnkHstudf7" size="20" name="udf7" value="udf777777777777777777777777777777777777777777777777777" />
					</div>
				</div>
				
				<div class="form-group row">
					<label for="udf1Lbl" class="col-sm-3 col-form-label">Udf 8</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" id="bnkHstudf8" size="20" name="udf8" value="udf888888888888888888888888888888888888888888888888888" />
					</div>
				</div>


				<div class="form-group row">
					<label for="udf1Lbl" class="col-sm-3 col-form-label">Udf 9</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" id="bnkHstudf9" size="20" name="udf9" value="udf999999999999999999999999999999999999999999999999999" />
					</div>
				</div>
				<div class="form-group row">
					<label for="udf1Lbl" class="col-sm-3 col-form-label">Udf 10</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" id="bnkHstudf10" size="20" name="udf10" value="udf101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010" />
					</div>
				</div>
				<div class="form-group row">
					<label for="udf1Lbl" class="col-sm-3 col-form-label">Udf 11</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="bnkHstudf11" name="udf11" value="udf111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" />
					</div>
				</div>
				<div class="form-group row">
					<label for="udf1Lbl" class="col-sm-3 col-form-label">Udf 12</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="bnkHstudf12" name="udf12" value="udf121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212121212" />
					</div>
				</div>
				<div class="form-group row">
					<label for="udf1Lbl" class="col-sm-3 col-form-label">Udf 13</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="bnkHstudf13" name="udf13" value="udf131313131313131313131313131313131313131313131313131313131313131313131313131313131313131313131313131313" />
					</div>
				</div>
				<div class="form-group row">
					<label for="udf1Lbl" class="col-sm-3 col-form-label">Udf 14</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="bnkHstudf14" name="udf14" value="udf141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414" />
					</div>
				</div>
				<div class="form-group row">
					<label for="udf1Lbl" class="col-sm-3 col-form-label">Udf 15</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="bnkHstudf15" name="udf15" value="udf151515151515151515151515151515151515151515151515151515151515151515151515151515151515151515151515151515" />
					</div>
				</div>

				<div class="form-group row">
					<label for="udf1Lbl" class="col-sm-3 col-form-label">Track Id</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20"  id="bnkHsttrackId" name="trackId" value="<%=trackid%>" />
					</div>
				</div>

				<div class="form-group row">
					<label for="expireDateLbl" class="col-sm-3 col-form-label"></label>
					<div class="col-sm-4">
						<button onclick="fnClickProcessTransaction();" id="bnkHstButtonClick" type="button" class="btn btn-default">Process</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
