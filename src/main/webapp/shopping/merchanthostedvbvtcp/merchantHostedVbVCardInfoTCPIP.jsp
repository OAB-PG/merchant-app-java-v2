<%@page import="java.util.Calendar"%>
<%@page import="java.util.Random"%>
<%@ page language="java" session="true" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD html 4.01 Transitional//EN">
<head>
<script type="text/javascript">
function fnClickProcessMerchantHostVbVTTCPTransaction(){
	document.merchantHostedvbvTCPTransaction.submit();
}

</script>

</head>
<div class="container">
	<div class="panel panel-default">
		<div class="panel-body">
			<form name="merchantHostedvbvTCPTransaction" action="shopping/merchanthostedvbvtcp/merchantHostedVbVBuyTCPIP.jsp" method="post">
				<div class="form-group row">
					<label for="ActionLbl" class="col-sm-3 col-form-label">Action</label>
					<div class="col-sm-3">
						<select class="form-control" name="action" id="mrchHstVbvaction" onchange="fnChangeRequiredField(this.value);">
							<option value="1"> 1 - Purchase </option> 
							<option value="4"> 4 - Authorization </option> 
							<option value="11"> 11 - Token Registration</option>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<label for="ActionLbl" class="col-sm-3 col-form-label">Token flag</label>
					<div class="col-sm-3">
						<select class="form-control" name="mrchHstVbvtokenFlag" id="mrchHstVbvtokenFlag">
							<option selected="selected" value="">Empty</option>
							<option value="1">Token Reg-Dereg</option>
							<option value="2">Token Transaction</option>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<label for="ActionLbl" class="col-sm-3 col-form-label">Token Number</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="mrchHstVbvtokenNumber" name="mrchHstVbvtokenNumber" value="" />
					</div>
				</div>
				<div class="form-group row">
					<label for="ActionLbl" class="col-sm-3 col-form-label">Amount</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20"  id="mrchHstVbvamount" name="amount" value="1.100" />
					</div>
				</div>

				<div class="form-group row">
					<label for="cardNumberLbl" class="col-sm-3 col-form-label">Card Number</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20"  id="mrchHstVbvcardNumber" name="cardNumber" value="4012001037490006" />
					</div>
				</div>

				<div class="form-group row">
					<label for="cvvLbl" class="col-sm-3 col-form-label">CVV</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="mrchHstVbvcvv" name="cvv" value="123" />
					</div>
				</div>

				<div class="form-group row">
					<label for="ActionLbl" class="col-sm-3 col-form-label">Expiry Date</label>
					<div class="col-sm-1">
						<select class="form-control" id="mrchHstVbvexpmm"  name="expmm" >
							<option value="">MM</option>
							<option value="1">1</option> 
							<option value="2">2</option> 
							<option value="3">3</option> 
							<option value="4">4</option> 
							<option value="5">5</option> 
							<option value="6">6</option> 
							<option value="7">7</option> 
							<option value="8">8</option> 
							<option value="9">9</option> 
							<option value="10">10</option> 
							<option value="11">11</option> 
							<option value="12" selected="selected" >12</option> 
						</select>
					</div>
					<div class="col-sm-2">
						<select class="form-control" id="mrchHstVbvexpyy" name="expyy" >
							<option value="">YYYY</option>
							<option value="2025">2025</option> 
							<option value="2026" selected="selected" >2026</option>  
						</select>
					</div>
				</div>

				<div class="form-group row">
					<label for="cardHolderLbl" class="col-sm-3 col-form-label">Cardholder's Name</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="mrchHstVbvname" name="name" value="Cardholders Name" />
					</div>
				</div>


				<div class="form-group row">
					<label for="cardHolderLbl" class="col-sm-3 col-form-label">UDF 1</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="mrchHstVbvudf1" name="udf1" value="udf 111 value" />
					</div>
				</div>

				<div class="form-group row">
					<label for="cardHolderLbl" class="col-sm-3 col-form-label">UDF 2</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="mrchHstVbvudf2" name="udf2" value="udf 222 value" />
					</div>
				</div>

				<div class="form-group row">
					<label for="cardHolderLbl" class="col-sm-3 col-form-label">UDF 3</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="mrchHstVbvudf3" name="udf3" value="udf 333 value" />
					</div>
				</div>

				<div class="form-group row">
					<label for="cardHolderLbl" class="col-sm-3 col-form-label">UDF 4</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="mrchHstVbvudf4" name="udf4" value="udf 444 value" />
					</div>
				</div>

				<div class="form-group row">
					<label for="cardHolderLbl" class="col-sm-3 col-form-label">UDF 5</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="mrchHstVbvudf5" name="udf5" value="udf 555 value" />
					</div>
				</div>

				<div class="form-group row">
					<label for="cardHolderLbl" class="col-sm-3 col-form-label">Track Id</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="mrchHstVbvtrackId" name="trckId" value="<%=String.valueOf(Calendar.getInstance().getTimeInMillis())%>" />
					</div>
				</div>

				<div class="form-group row">
					<label for="cardHolderLbl" class="col-sm-3 col-form-label">Transaction Type</label>
					<div class="col-sm-3">
						<select class="form-control" id="mrchHstVbvtransacType" name="transacType" >
							<option  value="AP">Apple Pay</option>
							<option value="SP">Samsung Pay</option>
							<option selected="selected" value="">--Select--</option>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<label for="expireDateLbl" class="col-sm-3 col-form-label"></label>
					<div class="col-sm-4">
						<button onclick="fnClickProcessMerchantHostVbVTTCPTransaction();" type="button" id="mrchHstVbvButtonClick" class="btn btn-default">Process</button>
					</div>
				</div>
				
			</form>
		</div>
	</div>
</div>

